# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Validate the working compiler directly; never apply historical patches."""
from pathlib import Path
import argparse,os,subprocess,sys
ROOT=Path(__file__).resolve().parents[1]
TESTS=['test_literal_retention', 'test_retained_codec', 'test_index_storage', 'test_lazy_reservation', 'test_stable_arguments', 'test_assumption_blocks', 'test_language_interactions', 'test_classifier_syntax', 'test_metadata', 'test_carriers', 'test_explicit_carriers', 'test_classified_values', 'test_value_storage', 'test_carrier_binders', 'test_computed_carriers', 'test_classifier_literal_interactions', 'test_dependent_functions', 'test_dependent_calls', 'test_structures', 'test_inferred_conversion', 'test_hygienic_conversion', 'test_type_expressions', 'test_applied_indices', 'test_quantified_beta', 'test_contextual_key_contract', 'test_contextual_family_comparison', 'test_exact_sequences', 'test_module_products', 'test_mayer_vietoris_maps', 'test_layout', 'test_conditions', 'test_editor_prototypes']

parser=argparse.ArgumentParser();parser.add_argument('--full',action='store_true');args=parser.parse_args()
env={**os.environ,'PYTHONPATH':os.pathsep.join(map(str,[ROOT,ROOT/'tests',ROOT/'studies/literal-retention']))}
python=sys.executable;lake=os.environ.get('LAKE','lake')
commands=[[python,'tools/generate_parser.py','--check'],[python,'-m','unittest',*TESTS,'-v']]
for script,flags in [
 ('studies/universe-classifiers/check_value_targets.py',['--payload-only']),
 ('studies/universe-classifiers/check_carrier_function_targets.py',[]),
 ('studies/universe-classifiers/check_carrier_record_targets.py',[]),
 ('studies/composed-language/check_interactions.py',[]),
 ('studies/bound-tree-codec/check_targets.py',['--payload-only']),
 ('tools/check_classifier_literal_targets.py',[]),
 ('studies/topology/verify_mayer_vietoris_maps.py',[]),
 ('verify_corpus.py',[])]:commands.append([python,script,*flags])
commands.append([lake,'env','lean','generated/VerifiedCorpus.lean'])
if args.full:commands.append([python,'-m','unittest','discover','-s','tests','-v'])
failures=[]
for command in commands:
 print('Checking:',command,flush=True)
 result=subprocess.run(command,cwd=ROOT,env=env)
 if result.returncode:failures.append((command,result.returncode))
print('Failures:',failures,flush=True)
raise SystemExit(bool(failures))

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
