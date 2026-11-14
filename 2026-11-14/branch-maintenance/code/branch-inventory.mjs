// Read-only inventory. An ancestry candidate still needs citation/owner review.
import fs from 'node:fs';
import { execFileSync } from 'node:child_process';
const out = '/home/agent/bench-hashes-validation/autonomous-20261114';
const checkout = '/home/agent/bench-incremental-lifetime';
const token = fs.readFileSync('/home/agent/.config/devon-github/repo-token', 'utf8').trim();
const headers = {Authorization: `Bearer ${token}`, Accept: 'application/vnd.github+json'};
async function get(path) {
  const r = await fetch('https://api.github.com/' + path, {headers, signal: AbortSignal.timeout(15000)});
  if (!r.ok) throw Error(`${path}: HTTP ${r.status}`);
  return r.json();
}
async function list(path) {
  const items = [];
  for (let page=1;;page++) {
    const part = await get(`${path}${path.includes('?')?'&':'?'}per_page=100&page=${page}`);
    items.push(...part);
    if (part.length < 100) return items;
  }
}
function git(args) { return execFileSync('git',['-C',checkout,...args],{encoding:'utf8',stdio:['ignore','pipe','pipe'],timeout:10000}).trim(); }
// Cover independent clones too, not only the current checkout's worktree family.
const worktreeRecords=[]; const localRefRecords=[]; const commonDirs=new Set(); const unreadable=[];
for(const entry of fs.readdirSync('/home/agent',{withFileTypes:true})) {
 if(!entry.isDirectory()) continue;
 const root='/home/agent/'+entry.name;
 if(!fs.existsSync(root+'/.git')) continue;
 try {
  const common=execFileSync('git',['-C',root,'rev-parse','--path-format=absolute','--git-common-dir'],{encoding:'utf8',stdio:['ignore','pipe','pipe'],timeout:10000}).trim();
  if(commonDirs.has(common))continue;
  commonDirs.add(common);
  worktreeRecords.push(execFileSync('git',['-C',root,'worktree','list','--porcelain'],{encoding:'utf8',stdio:['ignore','pipe','pipe'],timeout:10000}));
  localRefRecords.push(execFileSync('git',['-C',root,'for-each-ref','--format=%(refname:short) %(objectname)','refs/heads'],{encoding:'utf8',stdio:['ignore','pipe','pipe'],timeout:10000}));
 } catch(e) {unreadable.push({directory:entry.name,status:e.status});}
}
const worktrees=worktreeRecords.join('\n');
const activeBranches = new Set([...worktrees.matchAll(/^branch refs\/heads\/(.+)$/gm)].map(m=>m[1]));
const activeHeads = new Set([...worktrees.matchAll(/^HEAD (.+)$/gm)].map(m=>m[1]));
const local = new Map();
for(const line of localRefRecords.join('\n').split('\n').filter(Boolean)) {
 const [name,sha]=line.split(' ');
 if(!local.has(name))local.set(name,new Set());
 local.get(name).add(sha);
}
const known = new Map();
function exists(sha) {
  if(!known.has(sha)) { try {git(['cat-file','-e',sha+'^{commit}']);known.set(sha,true);} catch (e) {if(e.status!==128) throw e; known.set(sha,false);} }
  return known.get(sha);
}
const repos = ['servil-software-factory/bench-hashes','devonjonte/bench-hashes'];
const reviewBases = [...repos, 'zooko/bench-hashes']; // Ultimate fork-network source as well as the maintained parent.
const open = (await Promise.all(reviewBases.map(r=>list(`repos/${r}/pulls?state=open`)))).flat();
const rows=[];
for(const repo of repos) {
  const meta=await get(`repos/${repo}`);
  const branches=await list(`repos/${repo}/branches`);
  const retained=branches.filter(b=>b.protected || [meta.default_branch,'main','next','data','master','servil'].includes(b.name));
  for(const b of branches) {
    const sha=b.commit.sha;
    const inUse=activeBranches.has(b.name)||activeHeads.has(sha);
    const prs=open.filter(p=>p.head.repo?.full_name===repo && p.head.ref===b.name).map(p=>p.html_url);
    const ancestors=[];
    if(exists(sha)) for(const target of retained) {
      if(!exists(target.commit.sha)) continue;
      try {git(['merge-base','--is-ancestor',sha,target.commit.sha]);ancestors.push(target.name);} catch (e) {if(e.status!==1) throw e;}
    }
    const localDiffers=local.has(b.name)&&[...local.get(b.name)].some(s=>s!==sha);
    const owned=b.name.startsWith('candidate/devon-');
    const protectedName=b.protected||retained.some(r=>r.name===b.name)||/^(archive|probe|experiment)\//.test(b.name);
    const candidate=owned&&!protectedName&&!inUse&&!localDiffers&&prs.length===0&&ancestors.length>0;
    const date=exists(sha)?git(['show','-s','--format=%cI',sha]):null;
    rows.push({repo,branch:b.name,sha,date,protectedName,owned,inUse,localDiffers,openPRs:prs,ancestorOfRetained:ancestors,objectAvailable:exists(sha),reviewCandidate:candidate});
  }
}
fs.writeFileSync(`${out}/branches.json`,JSON.stringify({at:new Date().toISOString(),readOnly:true,gitFamilies:commonDirs.size,unreadable,rows},null,2)+'\n');
let text='# Read-only branch inventory\n\nNo branch was deleted. Candidates still need citation and ownership review.\n\n';
for(const repo of repos) {
 const all=rows.filter(r=>r.repo===repo); const candidates=all.filter(r=>r.reviewCandidate).sort((a,b)=>(a.date||'').localeCompare(b.date||''));
 text+=`## ${repo}\n\n${all.length} branches; ${candidates.length} conservative ancestry candidates; ${all.filter(r=>r.inUse).length} protected by active local worktrees.\n\n`;
 text+='| branch | tip | retained ancestry | date |\n|---|---|---|---|\n';
 for(const r of candidates) text+=`| ${r.branch} | ${r.sha} | ${r.ancestorOfRetained.join(', ')} | ${r.date} |\n`;
 text+='\n';
}
fs.writeFileSync(`${out}/branches.md`,text);
console.log(`${rows.length} remote branches inventoried; ${rows.filter(r=>r.reviewCandidate).length} review candidates; ${commonDirs.size} local Git families; ${unreadable.length} unreadable markers; zero deletions`);
