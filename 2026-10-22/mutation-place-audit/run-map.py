import importlib.util, sys
sys.argv = ["check.py", "--map"]
spec = importlib.util.spec_from_file_location("check", "/home/agent/BLAKE3-mini/tools/mutants/check.py")
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
m.SHARDS = 1
m.main()
