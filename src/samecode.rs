//! Whether two builds hold the same allocated code and data (bench-hashes #125).
//! `check` builds both library commits at one path and compares every allocated
//! section except the build-ID note, masking the declared
//! provenance strings that intentionally name different commits.
//!
//! Every other data byte participates, including panic source locations. A
//! filename pointer and length followed by two words can also describe ordinary
//! program data, such as a file's size limit (bench-hashes #219). Retaining those
//! words sends line-only location changes to normal measurement too.
//!
//! Both builds use one path because source paths and crate metadata also reach
//! the executable. Separate paths introduce differences unrelated to the change.
//! Supports 64-bit little-endian ELF and 64-bit little-endian Mach-O: `compare`
//! returns None on other formats, and `check` measures as before.

use std::collections::{BTreeMap, BTreeSet};
use std::path::Path;
use std::process::Command;

const SHF_ALLOC: u64 = 2;
const SHT_NOBITS: u32 = 8;
const SHT_NOTE: u32 = 7;

const MH_MAGIC_64: u32 = 0xfeed_facf;
const LC_SYMTAB: u32 = 0x02;
const LC_SEGMENT_64: u32 = 0x19;
const SECTION_TYPE_MASK: u32 = 0xff;
const S_ZEROFILL: u32 = 0x01;
const S_GB_ZEROFILL: u32 = 0x0c;
const S_THREAD_LOCAL_ZEROFILL: u32 = 0x12;
const S_ATTR_DEBUG: u32 = 0x0200_0000;
const N_STAB: u8 = 0xe0;
const N_TYPE: u8 = 0x0e;
const N_SECT: u8 = 0x0e;

enum Format {
    Elf,
    MachO {
        text_ordinal: Option<usize>,
        symtab: Option<(usize, usize, usize, usize)>,
        raw: Vec<u8>,
    },
}

/// Allocated sections: name, address, size and contents (empty for NOBITS/ZEROFILL).
struct Image {
    format: Format,
    sections: BTreeMap<String, (u64, u64, Vec<u8>)>,
}

fn u16_at(d: &[u8], o: usize) -> u16 {
    u16::from_le_bytes(d[o..o + 2].try_into().unwrap())
}
fn u32_at(d: &[u8], o: usize) -> u32 {
    u32::from_le_bytes(d[o..o + 4].try_into().unwrap())
}
fn u64_at(d: &[u8], o: usize) -> u64 {
    u64::from_le_bytes(d[o..o + 8].try_into().unwrap())
}

fn fixed_cstr(bytes: &[u8]) -> String {
    let len = bytes.iter().position(|&b| b == 0).unwrap_or(bytes.len());
    String::from_utf8_lossy(&bytes[..len]).into_owned()
}

fn strip_legacy_hash(name: &str) -> &str {
    match name.rfind("::h") {
        Some(i) if name.len() - i == 19 && name[i + 3..].bytes().all(|b| b.is_ascii_hexdigit()) => {
            &name[..i]
        }
        _ => name,
    }
}

/// A 64-bit little-endian ELF or Mach-O file's image; None for any other file.
fn read(path: &Path) -> Option<Image> {
    let d = std::fs::read(path).unwrap_or_else(|e| panic!("{}: {e}", path.display()));
    if d.len() >= 64 && &d[..4] == b"\x7fELF" && d[4] == 2 && d[5] == 1 {
        return read_elf(&d);
    }
    if d.len() >= 32 && u32_at(&d, 0) == MH_MAGIC_64 {
        return read_macho(d);
    }
    None
}

fn read_elf(d: &[u8]) -> Option<Image> {
    let shoff = u64_at(d, 0x28) as usize;
    let (entsize, count, names) = (
        u16_at(d, 0x3A) as usize,
        u16_at(d, 0x3C) as usize,
        u16_at(d, 0x3E) as usize,
    );
    let header = |i: usize| {
        let o = shoff + i * entsize;
        // name, type, flags, addr, offset, size
        (
            u32_at(d, o),
            u32_at(d, o + 4),
            u64_at(d, o + 8),
            u64_at(d, o + 16),
            u64_at(d, o + 24) as usize,
            u64_at(d, o + 32),
        )
    };
    let names_at = header(names).4;
    let name_of = |off: u32| {
        let start = names_at + off as usize;
        let end = start
            + d[start..]
                .iter()
                .position(|&b| b == 0)
                .expect("a section name ends");
        String::from_utf8_lossy(&d[start..end]).into_owned()
    };
    let mut sections = BTreeMap::new();
    for i in 0..count {
        let (name, kind, flags, addr, offset, size) = header(i);
        if flags & SHF_ALLOC == 0 {
            continue;
        }
        let name = name_of(name);
        if kind == SHT_NOTE && name == ".note.gnu.build-id" {
            continue;
        }
        let body = if kind == SHT_NOBITS {
            Vec::new()
        } else {
            d[offset..offset + size as usize].to_vec()
        };
        sections.insert(name, (addr, size, body));
    }
    Some(Image {
        format: Format::Elf,
        sections,
    })
}

/// A 64-bit little-endian Mach-O file's image: every non-debug program section
/// outside `__PAGEZERO`, `__LINKEDIT`, and `__DWARF`. Load-command metadata
/// (`LC_UUID`) and `__LINKEDIT` (including ad-hoc code signatures) are excluded,
/// mirroring ELF's `.note.gnu.build-id` exclusion.
fn read_macho(d: Vec<u8>) -> Option<Image> {
    let ncmds = u32_at(&d, 16) as usize;
    let sizeofcmds = u32_at(&d, 20) as usize;
    let cmds_end = 32usize.checked_add(sizeofcmds)?;
    if cmds_end > d.len() {
        return None;
    }
    let mut sections = BTreeMap::new();
    let mut text_ordinal = None;
    let mut symtab = None;
    let mut sect_ordinal = 0usize;
    let mut at = 32usize;
    for _ in 0..ncmds {
        if at + 8 > cmds_end {
            return None;
        }
        let cmd = u32_at(&d, at);
        let cmdsize = u32_at(&d, at + 4) as usize;
        if cmdsize < 8 || at.checked_add(cmdsize)? > cmds_end {
            return None;
        }
        if cmd == LC_SEGMENT_64 {
            if cmdsize < 72 {
                return None;
            }
            let segname = fixed_cstr(&d[at + 8..at + 24]);
            let nsects = u32_at(&d, at + 64) as usize;
            if 72usize.checked_add(nsects.checked_mul(80)?)? > cmdsize {
                return None;
            }
            let skip_seg = matches!(segname.as_str(), "__LINKEDIT" | "__PAGEZERO" | "__DWARF");
            for s in 0..nsects {
                sect_ordinal += 1;
                if skip_seg {
                    continue;
                }
                let so = at + 72 + s * 80;
                let sectname = fixed_cstr(&d[so..so + 16]);
                let sect_seg = fixed_cstr(&d[so + 16..so + 32]);
                let addr = u64_at(&d, so + 32);
                let size = u64_at(&d, so + 40);
                let offset = u32_at(&d, so + 48) as usize;
                let flags = u32_at(&d, so + 64);
                if flags & S_ATTR_DEBUG != 0 {
                    continue;
                }
                let kind = flags & SECTION_TYPE_MASK;
                let zerofill = matches!(kind, S_ZEROFILL | S_GB_ZEROFILL | S_THREAD_LOCAL_ZEROFILL);
                let body = if zerofill || size == 0 {
                    Vec::new()
                } else {
                    let end = offset.checked_add(usize::try_from(size).ok()?)?;
                    if end > d.len() {
                        return None;
                    }
                    d[offset..end].to_vec()
                };
                if sect_seg == "__TEXT" && sectname == "__text" {
                    text_ordinal = Some(sect_ordinal);
                }
                sections.insert(format!("{sect_seg},{sectname}"), (addr, size, body));
            }
        } else if cmd == LC_SYMTAB {
            if cmdsize < 24 {
                return None;
            }
            symtab = Some((
                u32_at(&d, at + 8) as usize,
                u32_at(&d, at + 12) as usize,
                u32_at(&d, at + 16) as usize,
                u32_at(&d, at + 20) as usize,
            ));
        }
        at += cmdsize;
    }
    Some(Image {
        format: Format::MachO {
            text_ordinal,
            symtab,
            raw: d,
        },
        sections,
    })
}

/// `body` with every occurrence of each of `masks` zeroed.
fn mask_strings(body: &mut [u8], masks: &[&str]) {
    for m in masks.iter().map(|m| m.as_bytes()).filter(|m| !m.is_empty()) {
        let mut i = 0;
        while i + m.len() <= body.len() {
            if &body[i..i + m.len()] == m {
                body[i..i + m.len()].fill(b'0');
                i += m.len();
            } else {
                i += 1;
            }
        }
    }
}

/// What two builds hold.
#[derive(Debug, PartialEq)]
pub enum Verdict {
    /// The same code and data, as masked.
    Same,
    /// The sections that differ, and the functions (by name, demangled, the
    /// legacy hash suffix dropped): those of another size or on one side
    /// alone, where a change lands; and those of the same size and other
    /// bytes, among them every function whose calls' targets moved.
    Differs {
        sections: Vec<String>,
        resized: Vec<String>,
        changed: Vec<String>,
    },
}

/// Each function's sizes and bytes, by name.
fn functions_of(path: &Path, image: &Image) -> BTreeMap<String, Vec<(u64, Vec<u8>)>> {
    match &image.format {
        Format::Elf => functions_elf(path, image.sections.get(".text")),
        Format::MachO {
            text_ordinal,
            symtab,
            raw,
        } => functions_macho(
            raw,
            *text_ordinal,
            *symtab,
            image.sections.get("__TEXT,__text"),
        ),
    }
}

/// Each ELF function's sizes and bytes, by name (`nm -S -C` over the symbol table).
fn functions_elf(
    path: &Path,
    text: Option<&(u64, u64, Vec<u8>)>,
) -> BTreeMap<String, Vec<(u64, Vec<u8>)>> {
    let out = Command::new("nm")
        .args(["-S", "-C", "--defined-only"])
        .arg(path)
        .output()
        .expect("nm runs");
    assert!(
        out.status.success(),
        "nm {}: {}",
        path.display(),
        String::from_utf8_lossy(&out.stderr)
    );
    let mut found: BTreeMap<String, Vec<(u64, Vec<u8>)>> = BTreeMap::new();
    for line in String::from_utf8_lossy(&out.stdout).lines() {
        let f: Vec<&str> = line.splitn(4, ' ').collect();
        if f.len() != 4 || !matches!(f[2], "t" | "T") {
            continue;
        }
        let (Ok(addr), Ok(size)) = (u64::from_str_radix(f[0], 16), u64::from_str_radix(f[1], 16))
        else {
            continue;
        };
        let name = strip_legacy_hash(f[3]);
        let bytes = match text {
            Some((t, tsize, body)) if (*t..t + tsize).contains(&addr) => {
                let o = (addr - t) as usize;
                body[o..(o + size as usize).min(body.len())].to_vec()
            }
            _ => Vec::new(),
        };
        found
            .entry(name.to_string())
            .or_default()
            .push((size, bytes));
    }
    for v in found.values_mut() {
        v.sort();
    }
    found
}

/// Each Mach-O `__TEXT,__text` function's span and bytes, directly from
/// `LC_SYMTAB` (avoiding GNU-only `nm -S` flags on macOS).
fn functions_macho(
    raw: &[u8],
    text_ordinal: Option<usize>,
    symtab: Option<(usize, usize, usize, usize)>,
    text: Option<&(u64, u64, Vec<u8>)>,
) -> BTreeMap<String, Vec<(u64, Vec<u8>)>> {
    let (Some(text_ord), Some((symoff, nsyms, stroff, strsize)), Some((t_addr, t_size, t_body))) =
        (text_ordinal, symtab, text)
    else {
        return BTreeMap::new();
    };
    let Some(str_end) = stroff.checked_add(strsize) else {
        return BTreeMap::new();
    };
    let Some(sym_end) = symoff.checked_add(nsyms.saturating_mul(16)) else {
        return BTreeMap::new();
    };
    if str_end > raw.len() || sym_end > raw.len() {
        return BTreeMap::new();
    }
    let strtab = &raw[stroff..str_end];
    let t_addr = *t_addr;
    let t_end = t_addr.saturating_add(*t_size);
    let mut syms: Vec<(u64, String)> = Vec::new();
    for i in 0..nsyms {
        let o = symoff + i * 16;
        let n_strx = u32_at(raw, o) as usize;
        let n_type = raw[o + 4];
        let n_sect = raw[o + 5] as usize;
        let n_value = u64_at(raw, o + 8);
        if (n_type & N_STAB) != 0 || (n_type & N_TYPE) != N_SECT || n_sect != text_ord {
            continue;
        }
        if !(t_addr..t_end).contains(&n_value) || n_strx >= strtab.len() {
            continue;
        }
        let name_end = strtab[n_strx..]
            .iter()
            .position(|&b| b == 0)
            .unwrap_or(strtab.len() - n_strx);
        let raw_name = String::from_utf8_lossy(&strtab[n_strx..n_strx + name_end]);
        let name = strip_legacy_hash(raw_name.strip_prefix('_').unwrap_or(&raw_name));
        if !name.is_empty() {
            syms.push((n_value, name.to_string()));
        }
    }
    syms.sort();
    let mut starts: Vec<u64> = syms.iter().map(|(a, _)| *a).collect();
    starts.dedup();
    let mut found: BTreeMap<String, Vec<(u64, Vec<u8>)>> = BTreeMap::new();
    for (addr, name) in syms {
        let next_idx = starts.partition_point(|&s| s <= addr);
        let end = starts.get(next_idx).copied().unwrap_or(t_end).min(t_end);
        let size = end - addr;
        let off = (addr - t_addr) as usize;
        let bytes = t_body[off..(off + size as usize).min(t_body.len())].to_vec();
        found.entry(name).or_default().push((size, bytes));
    }
    for v in found.values_mut() {
        v.sort();
    }
    found
}

/// Read-only sections that hold compiled-in provenance strings (git commits,
/// bench versions). Executable code and mutable data sections are never masked.
fn is_provenance_section(name: &str) -> bool {
    name == ".rodata"
        || name.starts_with(".rodata.")
        || matches!(name, "__TEXT,__const" | "__TEXT,__cstring")
}

/// Whether `a` and `b` hold the same allocated code and data at the same
/// addresses, with `masks` (the declared provenance strings) zeroed only in
/// read-only provenance sections (`.rodata*`, `__TEXT,__const`,
/// `__TEXT,__cstring`). On ELF, `.note.gnu.build-id` is excluded; on Mach-O,
/// `LC_UUID` and `__LINKEDIT` are excluded. None where either file has another
/// format.
pub fn compare(a: &Path, b: &Path, masks: &[&str]) -> Option<Verdict> {
    let (mut ia, mut ib) = (read(a)?, read(b)?);
    for image in [&mut ia, &mut ib] {
        for (name, (_, _, body)) in &mut image.sections {
            if is_provenance_section(name) {
                mask_strings(body, masks);
            }
        }
    }
    let names: BTreeSet<&String> = ia.sections.keys().chain(ib.sections.keys()).collect();
    let sections: Vec<String> = names
        .into_iter()
        .filter(|n| match (ia.sections.get(*n), ib.sections.get(*n)) {
            (Some((aa, sa, ba)), Some((ab, sb, bb))) => aa != ab || sa != sb || ba != bb,
            _ => true,
        })
        .cloned()
        .collect();
    if sections.is_empty() {
        return Some(Verdict::Same);
    }
    let (fa, fb) = (functions_of(a, &ia), functions_of(b, &ib));
    let sizes = |f: &BTreeMap<String, Vec<(u64, Vec<u8>)>>, n: &String| {
        f.get(n)
            .map(|v| v.iter().map(|(s, _)| *s).collect::<Vec<_>>())
    };
    let (mut resized, mut changed) = (Vec::new(), Vec::new());
    for n in fa.keys().chain(fb.keys()).collect::<BTreeSet<_>>() {
        if sizes(&fa, n) != sizes(&fb, n) {
            resized.push(n.clone());
        } else if fa.get(n) != fb.get(n) {
            changed.push(n.clone());
        }
    }
    Some(Verdict::Differs {
        sections,
        resized,
        changed,
    })
}

#[cfg(all(test, target_os = "linux"))]
mod tests {
    use super::*;

    /// A string the test binary holds, as the bench holds its commits.
    const MARK: &str = "0123456789abcdef0123456789abcdef01234567";

    #[inline(never)]
    fn marker_function(x: u64) -> u64 {
        std::hint::black_box(x).wrapping_mul(0x9E37_79B9_7F4A_7C15) ^ 0x1234
    }

    #[repr(C)]
    struct FileLimit {
        path: &'static str,
        max_bytes: u32,
        flags: u32,
    }

    #[used]
    static FILE_LIMIT: FileLimit = FileLimit {
        path: "input.rs",
        max_bytes: 111,
        flags: 0,
    };

    fn symbol_address(exe: &Path, name: &str) -> u64 {
        let out = Command::new("nm")
            .args(["-S", "-C", "--defined-only"])
            .arg(exe)
            .output()
            .unwrap();
        assert!(out.status.success());
        let text = String::from_utf8_lossy(&out.stdout);
        let line = text
            .lines()
            .find(|line| line.contains(name))
            .expect("the named symbol");
        u64::from_str_radix(line.split_whitespace().next().unwrap(), 16).unwrap()
    }

    /// A copy of this test binary in a directory of the test's own, changed by `edit`.
    fn copy_with(tag: &str, edit: impl FnOnce(&mut Vec<u8>)) -> std::path::PathBuf {
        let exe = std::env::current_exe().unwrap();
        let dir = std::env::temp_dir().join(format!("samecode-{}-{tag}", std::process::id()));
        std::fs::create_dir_all(&dir).unwrap();
        let copy = dir.join("exe");
        let mut data = std::fs::read(&exe).unwrap();
        edit(&mut data);
        std::fs::write(&copy, data).unwrap();
        copy
    }

    /// The file offset of virtual address `addr` in `section` of `exe`.
    fn offset_of(exe: &[u8], section: &str, addr: u64) -> usize {
        let shoff = u64_at(exe, 0x28) as usize;
        let (entsize, count, names) = (
            u16_at(exe, 0x3A) as usize,
            u16_at(exe, 0x3C) as usize,
            u16_at(exe, 0x3E) as usize,
        );
        let names_at = u64_at(exe, shoff + names * entsize + 24) as usize;
        (0..count)
            .map(|i| shoff + i * entsize)
            .find(|&o| {
                let start = names_at + u32_at(exe, o) as usize;
                exe[start..].starts_with(section.as_bytes()) && exe[start + section.len()] == 0
            })
            .map(|o| u64_at(exe, o + 24) as usize + (addr - u64_at(exe, o + 16)) as usize)
            .expect("the section")
    }

    /// A fixed ELF64 relocatable object with two valid allocated notes.
    /// readelf/nm independently check this layout in the issue's evidence.
    fn note_object(build_id: u8, value: u32) -> Vec<u8> {
        let mut data = vec![0; 416];
        data[..8].copy_from_slice(b"\x7fELF\x02\x01\x01\0");
        let machine = if cfg!(target_arch = "aarch64") {
            183u16
        } else {
            62u16
        };
        for (at, word) in [
            (16, 1u16),
            (18, machine),
            (52, 64),
            (58, 64),
            (60, 4),
            (62, 1),
        ] {
            data[at..at + 2].copy_from_slice(&word.to_le_bytes());
        }
        data[20..24].copy_from_slice(&1u32.to_le_bytes());
        data[40..48].copy_from_slice(&160u64.to_le_bytes());
        data[64..104].copy_from_slice(b"\0.shstrtab\0.note.gnu.build-id\0.note.app\0");
        for (at, words) in [(104, [4u32, 16, 3]), (136, [4u32, 4, 1])] {
            for (i, word) in words.into_iter().enumerate() {
                data[at + i * 4..at + (i + 1) * 4].copy_from_slice(&word.to_le_bytes());
            }
        }
        data[116..120].copy_from_slice(b"GNU\0");
        data[120..136].fill(build_id);
        data[148..152].copy_from_slice(b"APP\0");
        data[152..156].copy_from_slice(&value.to_le_bytes());
        for (i, (name, kind, flags, offset, size, align)) in [
            (1u32, 3u32, 0u64, 64u64, 40u64, 1u64),
            (11, 7, 2, 104, 32, 4),
            (30, 7, 2, 136, 20, 4),
        ]
        .into_iter()
        .enumerate()
        {
            let at = 160 + (i + 1) * 64;
            data[at..at + 4].copy_from_slice(&name.to_le_bytes());
            data[at + 4..at + 8].copy_from_slice(&kind.to_le_bytes());
            for (field, word) in [(8, flags), (24, offset), (32, size), (48, align)] {
                data[at + field..at + field + 8].copy_from_slice(&word.to_le_bytes());
            }
        }
        data
    }

    #[test]
    fn only_the_build_id_note_is_ignored() {
        let dir = std::env::temp_dir().join(format!("samecode-{}-notes", std::process::id()));
        std::fs::create_dir_all(&dir).unwrap();
        let (base, id, app) = (dir.join("base.o"), dir.join("id.o"), dir.join("app.o"));
        std::fs::write(&base, note_object(1, 111)).unwrap();
        std::fs::write(&id, note_object(2, 111)).unwrap();
        std::fs::write(&app, note_object(1, 222)).unwrap();
        assert_eq!(compare(&base, &id, &[]), Some(Verdict::Same));
        assert!(
            matches!(compare(&base, &app, &[]),
                Some(Verdict::Differs { sections, resized, changed })
                    if sections == [".note.app"] && resized.is_empty() && changed.is_empty()
            ),
            "ordinary allocated notes can affect program behavior"
        );
        std::fs::remove_dir_all(dir).unwrap();
    }

    #[test]
    fn a_build_is_the_same_as_itself() {
        let exe = std::env::current_exe().unwrap();
        assert_eq!(compare(&exe, &exe, &[]), Some(Verdict::Same));
        std::hint::black_box(MARK);
    }

    #[test]
    fn a_changed_function_differs_by_name() {
        let exe = std::env::current_exe().unwrap();
        assert_eq!(
            marker_function(1),
            std::hint::black_box(1u64).wrapping_mul(0x9E37_79B9_7F4A_7C15) ^ 0x1234
        );
        let image = read(&exe).unwrap();
        let fs = functions_elf(&exe, image.sections.get(".text"));
        let (name, _) = fs
            .iter()
            .find(|(n, _)| n.ends_with("samecode::tests::marker_function"))
            .expect("the marker in the symbol table");
        let addr = symbol_address(&exe, "samecode::tests::marker_function");
        let copy = copy_with("function", |data| {
            let o = offset_of(data, ".text", addr);
            data[o] ^= 0xFF;
        });
        match compare(&exe, &copy, &[]) {
            Some(Verdict::Differs {
                sections,
                resized,
                changed,
            }) => {
                assert_eq!(sections, [".text"]);
                assert_eq!(resized, Vec::<String>::new());
                assert_eq!(changed, [name.clone()]);
            }
            other => panic!("one changed byte reads {other:?}"),
        }
        std::fs::remove_dir_all(copy.parent().unwrap()).unwrap();
    }

    #[test]
    fn the_commits_are_masked() {
        let exe = std::env::current_exe().unwrap();
        std::hint::black_box(MARK);
        let other = "fedcba9876543210fedcba9876543210fedcba98";
        let copy = copy_with("commit", |data| {
            let at = data
                .windows(MARK.len())
                .position(|w| w == MARK.as_bytes())
                .expect("the mark in the binary");
            data[at..at + MARK.len()].copy_from_slice(other.as_bytes());
        });
        assert!(
            matches!(compare(&exe, &copy, &[]), Some(Verdict::Differs { .. })),
            "unmasked, a commit differs"
        );
        assert_eq!(compare(&exe, &copy, &[MARK, other]), Some(Verdict::Same));
        std::fs::remove_dir_all(copy.parent().unwrap()).unwrap();
    }

    #[test]
    fn ordinary_data_with_a_rust_filename_still_differs() {
        let exe = std::env::current_exe().unwrap();
        assert_eq!(std::hint::black_box(&FILE_LIMIT).max_bytes, 111);
        assert_eq!(std::mem::size_of::<FileLimit>(), 24);
        let addr = symbol_address(&exe, "samecode::tests::FILE_LIMIT");
        let image = read(&exe).unwrap();
        let section = image
            .sections
            .iter()
            .find(|(_, (start, size, _))| (*start..start + size).contains(&addr))
            .map(|(name, _)| name.clone())
            .expect("the file-limit record is allocated data");
        let copy = copy_with("file-limit", |data| {
            let o = offset_of(data, &section, addr) + std::mem::offset_of!(FileLimit, max_bytes);
            assert_eq!(u32_at(data, o), 111);
            data[o..o + 4].copy_from_slice(&222u32.to_le_bytes());
        });
        assert!(
            matches!(
                compare(&exe, &copy, &[]),
                Some(Verdict::Differs { sections, resized, changed })
                    if sections == [section] && resized.is_empty() && changed.is_empty()
            ),
            "an ordinary limit beside a .rs filename affects the program"
        );
        std::fs::remove_dir_all(copy.parent().unwrap()).unwrap();
    }
}

#[cfg(test)]
mod macho_tests {
    use super::*;

    fn put_fixed16(dst: &mut [u8], name: &str) {
        dst.fill(0);
        let b = name.as_bytes();
        dst[..b.len()].copy_from_slice(b);
    }

    /// Build a minimal valid 64-bit little-endian Mach-O executable with:
    /// - `LC_SEGMENT_64(__TEXT)` containing `__text` and `__cstring`
    /// - `LC_SEGMENT_64(__DATA)` containing `__data` and zerofill `__bss`
    /// - `LC_SEGMENT_64(__LINKEDIT)` (excluded, carrying ad-hoc signature bytes)
    /// - `LC_UUID` (excluded)
    /// - `LC_SYMTAB` naming `_marker_function` and `_other_function` in `__text`
    fn synthetic_macho(
        uuid_byte: u8,
        linkedit_byte: u8,
        text: &[u8],
        other_offset: u64,
        cstring: &[u8],
        data_word: u32,
        bss_size: u64,
    ) -> Vec<u8> {
        synthetic_macho_at(
            uuid_byte,
            linkedit_byte,
            0x1_0000_4000,
            text,
            other_offset,
            cstring,
            &data_word.to_le_bytes(),
            bss_size,
        )
    }

    #[allow(clippy::too_many_arguments)]
    fn synthetic_macho_at(
        uuid_byte: u8,
        linkedit_byte: u8,
        text_addr: u64,
        text: &[u8],
        other_offset: u64,
        cstring: &[u8],
        data: &[u8],
        bss_size: u64,
    ) -> Vec<u8> {
        let mut cmds = Vec::new();
        // We compute payload offsets after sizing the load commands.
        // Command sizes:
        //   __TEXT seg (72 + 2*80 = 232)
        //   __DATA seg (72 + 2*80 = 232)
        //   __LINKEDIT seg (72)
        //   LC_UUID (24)
        //   LC_SYMTAB (24)
        let sizeofcmds = 232 + 232 + 72 + 24 + 24;
        let payload_start = 32 + sizeofcmds;
        let text_off = payload_start;
        let cstr_off = text_off + text.len();
        let data_off = cstr_off + cstring.len();
        let sym_off = data_off + data.len();
        let nsyms = 2usize;
        let str_off = sym_off + nsyms * 16;
        let strtab = b"\0_marker_function\0_other_function\0";
        let linkedit_off = str_off + strtab.len();
        let linkedit_len = 16usize;

        let push_seg =
            |buf: &mut Vec<u8>, name: &str, sects: &[(&str, &str, u64, u64, u32, u32)]| {
                let cmdsize = (72 + sects.len() * 80) as u32;
                let start = buf.len();
                buf.resize(start + cmdsize as usize, 0);
                buf[start..start + 4].copy_from_slice(&LC_SEGMENT_64.to_le_bytes());
                buf[start + 4..start + 8].copy_from_slice(&cmdsize.to_le_bytes());
                put_fixed16(&mut buf[start + 8..start + 24], name);
                buf[start + 64..start + 68].copy_from_slice(&(sects.len() as u32).to_le_bytes());
                for (i, &(sect, seg, addr, size, off, flags)) in sects.iter().enumerate() {
                    let so = start + 72 + i * 80;
                    put_fixed16(&mut buf[so..so + 16], sect);
                    put_fixed16(&mut buf[so + 16..so + 32], seg);
                    buf[so + 32..so + 40].copy_from_slice(&addr.to_le_bytes());
                    buf[so + 40..so + 48].copy_from_slice(&size.to_le_bytes());
                    buf[so + 48..so + 52].copy_from_slice(&off.to_le_bytes());
                    buf[so + 64..so + 68].copy_from_slice(&flags.to_le_bytes());
                }
            };

        push_seg(
            &mut cmds,
            "__TEXT",
            &[
                (
                    "__text",
                    "__TEXT",
                    text_addr,
                    text.len() as u64,
                    text_off as u32,
                    0x8000_0400,
                ),
                (
                    "__cstring",
                    "__TEXT",
                    text_addr + 0x1000,
                    cstring.len() as u64,
                    cstr_off as u32,
                    2,
                ),
            ],
        );
        push_seg(
            &mut cmds,
            "__DATA",
            &[
                (
                    "__data",
                    "__DATA",
                    text_addr + 0x2000,
                    data.len() as u64,
                    data_off as u32,
                    0,
                ),
                (
                    "__bss",
                    "__DATA",
                    text_addr + 0x2000 + data.len() as u64,
                    bss_size,
                    0,
                    S_ZEROFILL,
                ),
            ],
        );
        push_seg(&mut cmds, "__LINKEDIT", &[]);
        // LC_UUID (0x1b, 24 bytes)
        let uuid_at = cmds.len();
        cmds.resize(uuid_at + 24, 0);
        cmds[uuid_at..uuid_at + 4].copy_from_slice(&0x1bu32.to_le_bytes());
        cmds[uuid_at + 4..uuid_at + 8].copy_from_slice(&24u32.to_le_bytes());
        cmds[uuid_at + 8..uuid_at + 24].fill(uuid_byte);
        // LC_SYMTAB (0x02, 24 bytes)
        let sym_at = cmds.len();
        cmds.resize(sym_at + 24, 0);
        cmds[sym_at..sym_at + 4].copy_from_slice(&LC_SYMTAB.to_le_bytes());
        cmds[sym_at + 4..sym_at + 8].copy_from_slice(&24u32.to_le_bytes());
        cmds[sym_at + 8..sym_at + 12].copy_from_slice(&(sym_off as u32).to_le_bytes());
        cmds[sym_at + 12..sym_at + 16].copy_from_slice(&(nsyms as u32).to_le_bytes());
        cmds[sym_at + 16..sym_at + 20].copy_from_slice(&(str_off as u32).to_le_bytes());
        cmds[sym_at + 20..sym_at + 24].copy_from_slice(&(strtab.len() as u32).to_le_bytes());
        assert_eq!(cmds.len(), sizeofcmds);

        let mut out = vec![0u8; 32];
        out[0..4].copy_from_slice(&MH_MAGIC_64.to_le_bytes());
        out[4..8].copy_from_slice(&0x0100_000cu32.to_le_bytes()); // CPU_TYPE_ARM64
        out[12..16].copy_from_slice(&2u32.to_le_bytes()); // MH_EXECUTE
        out[16..20].copy_from_slice(&5u32.to_le_bytes()); // ncmds
        out[20..24].copy_from_slice(&(sizeofcmds as u32).to_le_bytes());
        out.extend_from_slice(&cmds);
        out.extend_from_slice(text);
        out.extend_from_slice(cstring);
        out.extend_from_slice(data);
        // nlist_64 entries (16 bytes each)
        for (strx, addr) in [(1u32, text_addr), (18u32, text_addr + other_offset)] {
            out.extend_from_slice(&strx.to_le_bytes());
            out.push(N_SECT); // n_type
            out.push(1); // n_sect = 1 (__TEXT,__text)
            out.extend_from_slice(&0u16.to_le_bytes());
            out.extend_from_slice(&addr.to_le_bytes());
        }
        out.extend_from_slice(strtab);
        assert_eq!(out.len(), linkedit_off);
        out.resize(linkedit_off + linkedit_len, linkedit_byte);
        out
    }

    #[test]
    fn macho_ignores_uuid_and_linkedit_masks_provenance_and_detects_code_or_data_changes() {
        let dir = std::env::temp_dir().join(format!("samecode-macho-{}", std::process::id()));
        std::fs::create_dir_all(&dir).unwrap();
        let write = |name: &str, bytes: Vec<u8>| {
            let p = dir.join(name);
            std::fs::write(&p, bytes).unwrap();
            p
        };
        let old_sha = "1111111111111111111111111111111111111111";
        let new_sha = "2222222222222222222222222222222222222222";
        let base_text = [0x10u8, 0x20, 0x30, 0x40, 0x50, 0x60, 0x70, 0x80];
        let base = write(
            "base",
            synthetic_macho(1, 0xaa, &base_text, 4, old_sha.as_bytes(), 111, 64),
        );
        // Different LC_UUID and __LINKEDIT (ad-hoc signature): still Same.
        let uuid_sig = write(
            "uuid-sig",
            synthetic_macho(2, 0xbb, &base_text, 4, old_sha.as_bytes(), 111, 64),
        );
        assert_eq!(compare(&base, &uuid_sig, &[]), Some(Verdict::Same));

        // Different provenance string in __TEXT,__cstring: differs unmasked, Same when masked.
        let prov = write(
            "prov",
            synthetic_macho(3, 0xcc, &base_text, 4, new_sha.as_bytes(), 111, 64),
        );
        assert!(matches!(
            compare(&base, &prov, &[]),
            Some(Verdict::Differs { sections, .. }) if sections == ["__TEXT,__cstring"]
        ));
        assert_eq!(
            compare(&base, &prov, &[old_sha, new_sha]),
            Some(Verdict::Same)
        );

        // Changed byte inside marker_function: reported in changed.
        let mut mod_text = base_text;
        mod_text[1] ^= 0xff;
        let mod_fn = write(
            "mod-fn",
            synthetic_macho(1, 0xaa, &mod_text, 4, old_sha.as_bytes(), 111, 64),
        );
        assert_eq!(
            compare(&base, &mod_fn, &[]),
            Some(Verdict::Differs {
                sections: vec!["__TEXT,__text".to_owned()],
                resized: Vec::new(),
                changed: vec!["marker_function".to_owned()],
            })
        );

        // Resized marker_function / other_function boundary: reported in resized.
        let resized_text = [0x10u8, 0x20, 0x30, 0x40, 0x41, 0x42, 0x50, 0x60, 0x70, 0x80];
        let resized_fn = write(
            "resized-fn",
            synthetic_macho(1, 0xaa, &resized_text, 6, old_sha.as_bytes(), 111, 64),
        );
        assert_eq!(
            compare(&base, &resized_fn, &[]),
            Some(Verdict::Differs {
                sections: vec!["__TEXT,__text".to_owned()],
                resized: vec!["marker_function".to_owned()],
                changed: Vec::new(),
            })
        );

        // Ordinary data change in __DATA,__data and zerofill __DATA,__bss size change.
        let mod_data = write(
            "mod-data",
            synthetic_macho(1, 0xaa, &base_text, 4, old_sha.as_bytes(), 222, 64),
        );
        assert_eq!(
            compare(&base, &mod_data, &[]),
            Some(Verdict::Differs {
                sections: vec!["__DATA,__data".to_owned()],
                resized: Vec::new(),
                changed: Vec::new(),
            })
        );
        let mod_bss = write(
            "mod-bss",
            synthetic_macho(1, 0xaa, &base_text, 4, old_sha.as_bytes(), 111, 128),
        );
        assert_eq!(
            compare(&base, &mod_bss, &[]),
            Some(Verdict::Differs {
                sections: vec!["__DATA,__bss".to_owned()],
                resized: Vec::new(),
                changed: Vec::new(),
            })
        );

        // An address-only placement shift (identical bytes and sizes) must never
        // be called Same: code placement affects timing.
        let shifted = write(
            "shifted",
            synthetic_macho_at(
                1,
                0xaa,
                0x1_0000_5000,
                &base_text,
                4,
                old_sha.as_bytes(),
                &111u32.to_le_bytes(),
                64,
            ),
        );
        assert!(
            matches!(compare(&base, &shifted, &[]), Some(Verdict::Differs { sections, .. }) if sections.contains(&"__TEXT,__text".to_owned())),
            "address-only shift must report Differs"
        );

        // Provenance-like text inside mutable __DATA,__data or executable __TEXT,__text
        // must never be masked away.
        let data_old = write(
            "data-old",
            synthetic_macho_at(
                1,
                0xaa,
                0x1_0000_4000,
                &base_text,
                4,
                old_sha.as_bytes(),
                old_sha.as_bytes(),
                64,
            ),
        );
        let data_new = write(
            "data-new",
            synthetic_macho_at(
                1,
                0xaa,
                0x1_0000_4000,
                &base_text,
                4,
                old_sha.as_bytes(),
                new_sha.as_bytes(),
                64,
            ),
        );
        assert!(
            matches!(
                compare(&data_old, &data_new, &[old_sha, new_sha]),
                Some(Verdict::Differs { sections, .. }) if sections == ["__DATA,__data"]
            ),
            "mutable __DATA,__data must not be masked by provenance strings"
        );

        let text_old = write(
            "text-old",
            synthetic_macho_at(
                1,
                0xaa,
                0x1_0000_4000,
                old_sha.as_bytes(),
                20,
                old_sha.as_bytes(),
                &111u32.to_le_bytes(),
                64,
            ),
        );
        let text_new = write(
            "text-new",
            synthetic_macho_at(
                1,
                0xaa,
                0x1_0000_4000,
                new_sha.as_bytes(),
                20,
                old_sha.as_bytes(),
                &111u32.to_le_bytes(),
                64,
            ),
        );
        assert!(
            matches!(
                compare(&text_old, &text_new, &[old_sha, new_sha]),
                Some(Verdict::Differs { sections, .. }) if sections == ["__TEXT,__text"]
            ),
            "executable __TEXT,__text must not be masked by provenance strings"
        );

        std::fs::remove_dir_all(&dir).unwrap();
    }
}

#[cfg(all(test, target_os = "macos"))]
mod macos_native_tests {
    use super::*;

    const MARK: &str = "0123456789abcdef0123456789abcdef01234567";

    #[test]
    fn macos_native_binary_matches_itself_and_masks_commits() {
        let exe = std::env::current_exe().unwrap();
        std::hint::black_box(MARK);
        let image = read(&exe).expect("macos executable parses as Mach-O 64-bit");
        assert!(
            image.sections.contains_key("__TEXT,__text"),
            "Mach-O executable exposes __TEXT,__text"
        );
        assert!(
            !functions_of(&exe, &image).is_empty(),
            "LC_SYMTAB yields text symbols on real Mach-O executables"
        );
        assert_eq!(compare(&exe, &exe, &[]), Some(Verdict::Same));

        let other = "fedcba9876543210fedcba9876543210fedcba98";
        let dir = std::env::temp_dir().join(format!("samecode-macos-{}", std::process::id()));
        std::fs::create_dir_all(&dir).unwrap();
        let copy = dir.join("exe");
        let mut data = std::fs::read(&exe).unwrap();
        let at = data
            .windows(MARK.len())
            .position(|w| w == MARK.as_bytes())
            .expect("the mark in the binary");
        data[at..at + MARK.len()].copy_from_slice(other.as_bytes());
        std::fs::write(&copy, data).unwrap();
        assert!(
            matches!(compare(&exe, &copy, &[]), Some(Verdict::Differs { .. })),
            "unmasked, a commit differs"
        );
        assert_eq!(compare(&exe, &copy, &[MARK, other]), Some(Verdict::Same));
        std::fs::remove_dir_all(&dir).unwrap();
    }
}
