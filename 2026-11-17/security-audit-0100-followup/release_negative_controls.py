"""Run source-only negative controls using the release tool's own Repository fixture.
The printed assertions are computed by this script, not read off manually.
"""
import json, os, subprocess, sys, unittest
sys.path.insert(0, sys.argv[1])
import release_artifacts as ra
import test_release_artifacts as fixture

class Controls(fixture.Repository):
    def test_controls(self):
        base = self.crate("")
        for name, change in [
            ('duplicate', lambda files, record: files.update({'src/lib.rs': b'changed\n'})),
        ]:
            pass
        # Keep a good first copy and a bad second copy: readers differ on which wins.
        import io, tarfile
        def _tar(items):
            out = io.BytesIO()
            with tarfile.open(fileobj=out, mode='w:gz') as a:
                for name, data in items:
                    m = tarfile.TarInfo(name); m.size = len(data); a.addfile(m, io.BytesIO(data))
            return out.getvalue()
        members = []
        with tarfile.open(fileobj=io.BytesIO(base), mode='r:gz') as a:
            for m in a.getmembers():
                members.append((m.name, a.extractfile(m).read()))
        for name, additions in [
            ('duplicate source', [(next(name for name, _ in members if name.endswith('/src/lib.rs')), b'wrong\n')]),
            ('root file', [('evil', b'wrong')]),
            ('another folder', [('other/src/lib.rs', b'wrong')]),
            ('parent path', [(members[-1][0].replace('/src/', '/../src/'), b'wrong')]),
        ]:
            problems = ra.crate_problems(_tar(members + additions), self.release)
            print(name, 'REFUSED' if problems else 'PASSED', problems)
            self.assertTrue(problems, name)
        self.assertTrue(ra.digest_problems('b3sum.sha256', b'wrong', {'b3sum': b'abc'}))
        self.assertTrue(ra.problems('b3sum-v-anything.b3', b'bytes', self.release))
        print('bad digest and unknown .b3 REFUSED')

        # Forge a version commit whose source changed without a version stamp.
        blob = self.git('hash-object', '-w', '--stdin') if False else subprocess.run(
            ['git','-C',self.repo,'hash-object','-w','--stdin'],input=b'pub fn wrong() {}\n',capture_output=True,check=True).stdout.decode().strip()
        env = dict(os.environ, GIT_INDEX_FILE=os.path.join(self.repo,'.git','audit-index'))
        subprocess.run(['git','-C',self.repo,'read-tree',self.commit],env=env,check=True)
        subprocess.run(['git','-C',self.repo,'update-index','--cacheinfo',f'100644,{blob},src/lib.rs'],env=env,check=True)
        tree = subprocess.check_output(['git','-C',self.repo,'write-tree'],env=env).decode().strip()
        forged = subprocess.check_output(['git','-C',self.repo,'commit-tree',tree,'-p',self.code],input=b'forged').decode().strip()
        with self.assertRaises(ra.NotARelease):
            ra.Release(self.tag, self.repo, commit=forged)
        os.unlink(env['GIT_INDEX_FILE'])
        print('forged version commit REFUSED')

result = unittest.TextTestRunner(verbosity=2).run(unittest.defaultTestLoader.loadTestsFromTestCase(Controls))
sys.exit(not result.wasSuccessful())
