# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Isolated closed classifiers and generic implicit carrier arguments; partial implementation."""
from pathlib import Path
import argparse,os,shutil,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[2]
BASE='dde5d8ef4d76763b41d28c6c452f48c9129c6bdb'
parser=argparse.ArgumentParser();parser.add_argument('--full',action='store_true');args=parser.parse_args()
full=args.full
with tempfile.TemporaryDirectory(prefix='clean-classifier-syntax-') as directory:
 target=Path(directory);sys.path.insert(0,str(ROOT/'tools'));import study_checkout
 study_checkout.BASE_COMMIT=BASE;study_checkout.create_study_checkout(target,ROOT)
 for patch in ('syntax.patch','metadata.patch','carriers.patch','carrier-fixtures.patch','explicit-carriers.patch','explicit-oracles.patch','type-values.patch','type-value-fixtures.patch'):
  subprocess.run(['git','apply',str(Path(__file__).with_name(patch))],cwd=target,check=True)
 env={**os.environ,'PYTHONPATH':os.pathsep.join([str(target/'studies/universe-classifiers'),str(target/'tests'),str(target)])}
 for args in [['tools/generate_parser.py'],['tools/generate_parser.py','--check'],['-m','unittest','test_syntax','test_metadata','test_carriers','test_explicit_carriers','test_classified_values','test_generated_parser','test_type_expressions','test_closed_universes','test_universes','test_dependent_calls','test_dependent_functions','test_structures','test_inferred_conversion','test_hygienic_conversion','test_binding_identity','test_linear_spaces','test_value_indices','test_declared_standard_operators','-v']]:
  subprocess.run([sys.executable,*args],cwd=target,env=env,check=True)
 subprocess.run([sys.executable,'studies/universe-classifiers/check_metadata_targets.py'],cwd=target,env=env,check=True)
 subprocess.run([sys.executable,'studies/universe-classifiers/check_carrier_targets.py'],cwd=target,env=env,check=True)
 subprocess.run([sys.executable,'studies/universe-classifiers/check_explicit_targets.py'],cwd=target,env=env,check=True)
 subprocess.run([sys.executable,'studies/universe-classifiers/check_value_targets.py'],cwd=target,env=env,check=True)
 for suite in ('foundations','saved','dispatch'):
  subprocess.run([sys.executable,'studies/operator-integration/verify_'+suite+'.py',str(target)],cwd=target,env=env,check=True)
 subprocess.run([os.environ.get('LAKE','lake'),'env','lean','studies/universe-classifiers/Targets.lean'],cwd=target,check=True)
 for name in ('MetadataTargets.lean','CarrierTargets.lean','ExplicitCarrierTargets.lean','TypeValueTargets.lean','TypeValueExample.tex'):
  shutil.copy2(target/'studies/universe-classifiers'/name,Path(__file__).with_name(name))
 if full:subprocess.run([sys.executable,'-m','unittest','discover','-s','tests','-v'],cwd=target,env=env,check=True)
print('Classifier declarations, carrier calls and first-class values passed selected checks; full language integration remains pending.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
