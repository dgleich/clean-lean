# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Replay operators and numerals on the post-binding compiler, without old repairs."""
from pathlib import Path
import io,os,subprocess,sys,tarfile,tempfile
ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
BASE='f2b8a100765f2e871babc5ddb82330a76607dc59'
with tempfile.TemporaryDirectory(prefix='clean-current-integration-') as td:
    dest=Path(td)
    archive=subprocess.check_output(['git','archive',BASE],cwd=ROOT)
    with tarfile.open(fileobj=io.BytesIO(archive),mode='r:') as tree:
        tree.extractall(dest)
    (dest/'.lake').symlink_to(ROOT/'.lake',target_is_directory=True)
    subprocess.run(['git','apply',str(HERE/'integration.patch')],cwd=dest,check=True)
    env=os.environ.copy();env['PYTHONPATH']=str(dest)
    env['PATH']='/home/claude/.elan/bin:'+env.get('PATH','')
    def run(*args):
        subprocess.run([sys.executable,*map(str,args)],cwd=dest,env=env,check=True)
    run(dest/'tools/generate_parser.py')
    run(dest/'tools/generate_parser.py','--check')
    run(HERE/'check_retained_numerals.py')
    run('-m','unittest','tests.test_bound_comparison_reuse','tests.test_generated_parser','-v')
    for name in ['verify_defaults.py','verify_inference.py','verify_expressions.py']:
        extra=['--inferred'] if name=='verify_expressions.py' else []
        run(dest/'studies/module-numerals'/name,dest,*extra)
    run(dest/'studies/operator-integration/verify_foundations.py',dest)
print('Current-base integration: 80 exact targets, sixteen proofs and retained-binding regressions passed')

# generated: gpt-6 2026-11-07 role=assisted; LLM-authored portions; see PROVENANCE.md
