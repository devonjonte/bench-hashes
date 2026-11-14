// Act only on the immutable published proposal. Recheck eligibility and use
// atomic exact-tip leases. No local refs, worktrees or retained heads change.
import fs from 'node:fs';
import {execFileSync} from 'node:child_process';
const mode=process.argv[2];
if(!['review','apply'].includes(mode)||process.argv.length!==3)throw Error('usage: prune-proposal.mjs review|apply');
const dir='/home/agent/bench-hashes-validation/autonomous-20261114';
const checkout='/home/agent/bench-incremental-lifetime';
const proposalCommit='461e77d440d4d413384225b76cb40de052327ad0';
const proposal=JSON.parse(execFileSync('git',['-C','/home/agent/bench-hashes-data','show',proposalCommit+':2026-11-14/branch-maintenance/proposal.json'],{encoding:'utf8',timeout:10000}));
for(const script of ['branch-inventory.mjs','branch-citations.mjs'])execFileSync(process.execPath,[dir+'/'+script],{stdio:'inherit',timeout:180000});
const inventory=JSON.parse(fs.readFileSync(dir+'/branches.json','utf8'));
if(inventory.unreadable.length)throw Error('unreadable local Git markers require review');
const current=JSON.parse(fs.readFileSync(dir+'/branch-citations.json','utf8')).rows;
for(const row of proposal.branches) {
 if(!row.branch.startsWith('candidate/devon-'))throw Error('outside owned candidate scope');
 const found=current.find(r=>r.repo===row.repo&&r.branch===row.branch);
 if(!found||!found.uncitedInReviewedScope||found.sha!==row.sha)throw Error(`eligibility changed: ${row.repo} ${row.branch}`);
}
// Keep the working Git transport configured by this environment. The child
// timeout and run-bounded own liveness; Git itself receives no interactive prompt.
const env={...process.env,GIT_TERMINAL_PROMPT:'0'};
const git=args=>execFileSync('git',['-C',checkout,...args],{encoding:'utf8',stdio:['ignore','pipe','pipe'],timeout:120000,env});
const heads=url=>Object.fromEntries(git(['ls-remote','--heads',url]).split('\n').filter(Boolean).map(l=>{const [sha,ref]=l.split('\t');return [ref,sha];}));
const receipts={at:new Date().toISOString(),mode,proposalCommit,repositories:[]};
const file=dir+'/prune-'+mode+'.json';
for(const repo of ['devonjonte/bench-hashes','servil-software-factory/bench-hashes']) {
 const rows=proposal.branches.filter(r=>r.repo===repo);
 const url=`git@github.com:${repo}.git`;
 const before=heads(url);
 for(const row of rows)if(before['refs/heads/'+row.branch]!==row.sha)throw Error(`tip changed: ${row.branch}`);
 const args=['push','--atomic','--porcelain',...(mode==='review'?['--dry-run']:[]),...rows.map(r=>`--force-with-lease=refs/heads/${r.branch}:${r.sha}`),url,...rows.map(r=>`:refs/heads/${r.branch}`)];
 const receipt={repo,before,command:['git',...args]};
 receipts.repositories.push(receipt);
 fs.writeFileSync(file,JSON.stringify(receipts,null,2)+'\n');
 try {receipt.output=git(args);receipt.commandSucceeded=true;}
 catch(e){receipt.commandSucceeded=false;receipt.stdout=String(e.stdout||'');receipt.stderr=String(e.stderr||'');fs.writeFileSync(file,JSON.stringify(receipts,null,2)+'\n');throw Error(`push stopped: ${repo}; receipt retained`);}
 const after=heads(url);receipt.after=after;
 fs.writeFileSync(file,JSON.stringify(receipts,null,2)+'\n');
 if(mode==='apply') {
  for(const row of rows)if(after['refs/heads/'+row.branch])throw Error(`branch still present: ${row.branch}`);
  for(const name of Object.keys(proposal.retainedHeads[repo])) {
   const ref='refs/heads/'+name;
   if(after[ref]!==before[ref])throw Error(`retained head changed concurrently: ${repo}/${name}; inspect before proceeding`);
  }
 }
 fs.writeFileSync(file,JSON.stringify(receipts,null,2)+'\n');
 console.log(`${repo}: ${rows.length} ${mode==='apply'?'deleted with leases':'reviewed in dry run'}`);
}
console.log(mode==='apply'?'Published proposal completed; retained heads unchanged':'Dry run complete; zero deletions');
