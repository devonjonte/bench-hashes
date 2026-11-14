import importlib.util,json,os,pathlib,shutil,subprocess,sys
root=pathlib.Path.cwd();out=pathlib.Path(os.environ['O']);arm=os.environ['ARM']
sys.argv=['check.py','--crate','threads']
spec=importlib.util.spec_from_file_location('mutation_check',root/'tools/mutants/check.py')
m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
pattern=r'replace (\+= with -= in Ring<X>::push_back|-= with (\+=|/=) in Ring<X>::pop_front)$'
selected=json.loads(subprocess.check_output(['cargo','mutants',*m.BUILD,'--file','src/pipeline.rs','--re',pattern,'--list','--json'],cwd=m.CRATE_DIR,text=True))
assert len(selected)==3, len(selected)
(out/(arm+'-selected.json')).write_text(json.dumps(selected,indent=2)+'\n')
missed,functions,timed=m.run(['src/pipeline.rs'],extra=['--re',pattern],shards=1,label='ring-'+arm)
summary={'source':subprocess.check_output(['git','rev-parse','HEAD'],text=True).strip(),'missed':dict(missed),'timed':dict(timed),'functions':[{'file':f,'function':n,'outcomes':v} for (f,n),v in functions.items()]}
(out/(arm+'-summary.json')).write_text(json.dumps(summary,indent=2)+'\n')
shutil.copytree(pathlib.Path(m.last())/('ring-'+arm),out/(arm+'-outcomes'))
for name in ['Cargo.lock','threads/Cargo.lock']:
 p=root/name
 if p.exists():shutil.copyfile(p,out/(arm+'-'+name.replace('/','-')))
print(json.dumps(summary,indent=2))
