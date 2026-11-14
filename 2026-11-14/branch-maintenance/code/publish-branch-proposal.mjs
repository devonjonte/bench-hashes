import fs from 'node:fs';
import {execFileSync} from 'node:child_process';
const local='/home/agent/bench-hashes-validation/autonomous-20261114';
const out='/home/agent/bench-hashes-data/2026-11-14/branch-maintenance';
const rows=JSON.parse(fs.readFileSync(local+'/branch-citations.json','utf8')).rows.filter(r=>r.uncitedInReviewedScope);
const headers={Authorization:`Bearer ${fs.readFileSync('/home/agent/.config/devon-github/repo-token','utf8').trim()}`,Accept:'application/vnd.github+json'};
const retainedHeads={};
for(const repo of new Set(rows.map(r=>r.repo))) {
 retainedHeads[repo]={};
 for(const branch of new Set(rows.filter(r=>r.repo===repo).flatMap(r=>r.ancestorOfRetained))) {
  const r=await fetch(`https://api.github.com/repos/${repo}/branches/${branch}`,{headers,signal:AbortSignal.timeout(15000)});
  if(!r.ok)throw Error(`${repo}/${branch}: HTTP ${r.status}`);
  retainedHeads[repo][branch]=(await r.json()).commit.sha;
 }
}
for(const row of rows) {
 if(!row.ancestorOfRetained.some(b=>{
  try {execFileSync('git',['-C','/home/agent/bench-incremental-lifetime','merge-base','--is-ancestor',row.sha,retainedHeads[row.repo][b]],{stdio:'pipe',timeout:10000});return true;}catch(e){if(e.status!==1)throw e;return false;}
 }))throw Error(`ancestry changed: ${row.branch}`);
}
fs.mkdirSync(out+'/code',{recursive:true});
fs.writeFileSync(out+'/proposal.json',JSON.stringify({at:new Date().toISOString(),status:'proposed; no deletion yet',retainedHeads,branches:rows.map(({repo,branch,sha,date,ancestorOfRetained})=>({repo,branch,sha,date,ancestorOfRetained}))},null,2)+'\n');
fs.copyFileSync(local+'/branch-proposal.md',out+'/PROPOSAL.md');
for(const name of ['branch-inventory.mjs','branch-citations.mjs','publish-branch-proposal.mjs'])fs.copyFileSync(local+'/'+name,out+'/code/'+name);
console.log(`${rows.length} proposed refs recorded; retained-head ancestry rechecked; zero deletions`);
