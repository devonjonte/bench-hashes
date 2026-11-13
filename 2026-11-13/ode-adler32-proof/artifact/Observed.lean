import Lang
open L

/-! Written by odec.py from source.ode. Not edited by hand. -/

namespace Ode

def adler32 : Fn where
  name := "b3l_adler32"
  params := ["input", "n"]
  locals := ["a", "b", "i"]
  regs := []
  bufs := []
  externs := []
  body := [
    .set "a" (.const 1),
    .set "b" (.const 0),
    .set "i" (.const 0),
    .while (.ltu (.var "i") (.var "n")) [
      .set "a" (.add (.var "a") (.load 8 (.add (.var "input") (.var "i")))),
      .ite (.ltu (.var "a") (.const 65521)) [] [
        .set "a" (.sub (.var "a") (.const 65521))],
      .set "b" (.add (.var "b") (.var "a")),
      .ite (.ltu (.var "b") (.const 65521)) [] [
        .set "b" (.sub (.var "b") (.const 65521))],
      .set "i" (.add (.var "i") (.const 1))]]
  ret := (.or (.shl (.var "b") 16) (.var "a"))

def all : List Fn := [adler32]

/-- Each kernel written here, and the symbol it takes the place of. -/
def replaces : List (String × String) := []

def data : List (String × List Nat) := []

end Ode

def main (args : List String) : IO Unit :=
  match args with
  | ["rust", p] => IO.print (rustFile (rename p [] Ode.all))
  | ["asm", p] => IO.print (asmFile (rename p [] Ode.all) Ode.data)
  | ["asm", p, "own"] => IO.print (asmFile (rename p Ode.replaces Ode.all) Ode.data)
  | ["asm", p, "only", n] => IO.print (asmFile ((rename p [] Ode.all).filter (·.name == p ++ n)) (Ode.data.filter fun d => (Ode.all.filter (·.name == "b3l_" ++ n)).any fun f => f.body.any fun s => match s with | .ins t => (t.splitOn d.1).length > 1 | _ => false))
  | ["layout", n] => match Ode.all.find? (·.name == "b3l_" ++ n) with
    | some f => do
      let L := f.layout
      IO.println ("saved " ++ " ".intercalate L.saved)
      IO.println s!"frame {L.frame}"
      for x in f.params ++ f.locals do IO.println s!"home {x} {L.home x}"
      for b in f.bufs do IO.println s!"buf {b.1} {L.bufAt b.1}"
    | none => IO.eprintln "no such function"
  | _ => IO.eprintln "usage: rust PREFIX | asm PREFIX [own]"
