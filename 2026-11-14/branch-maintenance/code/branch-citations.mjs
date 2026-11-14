// Read-only citation review. Raw API bodies and private notes are not published.
import fs from 'node:fs';
import path from 'node:path';
const dir='/home/agent/bench-hashes-validation/autonomous-20261114';
const inventory=JSON.parse(fs.readFileSync(dir+'/branches.json','utf8'));
const candidates=inventory.rows.filter(r=>r.reviewCandidate);
const names=[...new Set(candidates.map(r=>r.branch))];
const hits=new Map(names.map(n=>[n,[]]));
function inspect(text, source) {
 for(const n of names) if(text.includes(n)) hits.get(n).push(source);
}
const suffixes=new Set(['.md','.sh','.py','.mjs','.rs','.toml','.yml','.yaml']);
function walk(root, prefix) {
 if(prefix === 'data/2026-11-14/branch-maintenance') return; // This proposal is not an older dependency.
 for(const entry of fs.readdirSync(root,{withFileTypes:true})) {
  if(['.git','target','node_modules','__pycache__','autonomous-20261114'].includes(entry.name)) continue;
  const file=path.join(root,entry.name), name=path.join(prefix,entry.name);
  if(entry.isDirectory()) walk(file,name);
  else if(entry.isFile()&&suffixes.has(path.extname(entry.name))) inspect(fs.readFileSync(file,'utf8'),name);
 }
}
walk('/home/agent/bench-hashes-data','data');
walk('/home/agent/bench-incremental-lifetime','current-source');
walk('/home/agent/bench-hashes-validation','working-notes');
const token=fs.readFileSync('/home/agent/.config/devon-github/repo-token','utf8').trim();
const headers={Authorization:`Bearer ${token}`,Accept:'application/vnd.github+json'};
let pages=0;
for(const repo of ['servil-software-factory/bench-hashes','devonjonte/bench-hashes','zooko/bench-hashes']) {
 for(const endpoint of ['issues?state=all','issues/comments?sort=created&direction=asc']) {
  for(let page=1;;page++) {
   const r=await fetch(`https://api.github.com/repos/${repo}/${endpoint}&per_page=100&page=${page}`,{headers,signal:AbortSignal.timeout(15000)});
   if(!r.ok) throw Error(`HTTP ${r.status} ${repo} page${page}`);
   const items=await r.json(); pages++;
   for(const item of items) inspect(item.body||'',item.html_url);
   if(items.length<100) break;
  }
 }
}
const reviewed=candidates.map(r=>({...r,citations:[...new Set(hits.get(r.branch))],uncitedInReviewedScope:hits.get(r.branch).length===0}));
fs.writeFileSync(dir+'/branch-citations.json',JSON.stringify({at:new Date().toISOString(),pages,scope:'data and source docs/scripts, working notes, maintained parent, fork and ultimate source issue/PR bodies and issue comments; own inventory/proposal excluded; no deletion',rows:reviewed},null,2)+'\n');
const clean=reviewed.filter(r=>r.uncitedInReviewedScope);
console.log(`${reviewed.length} ancestry candidates; ${clean.length} uncited in reviewed scope; ${pages} API pages; zero deletions`);
let md='# Pruning proposal: conservative, uncited merged candidates\n\nNo deletion performed. All commits remain ancestors of retained heads in the same repository. Active worktrees, differing local tips and open PRs were excluded. Citation search is finite; external references remain a review consideration.\n\n| repository | branch | exact expected tip | retained ancestry |\n|---|---|---|---|\n';
for(const r of clean)md+=`| ${r.repo} | ${r.branch} | ${r.sha} | ${r.ancestorOfRetained.join(', ')} |\n`;
fs.writeFileSync(dir+'/branch-proposal.md',md);
