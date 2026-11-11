# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Run a fixed translator regression slice under isolated joint routing.

Two legacy limitations are replaced by explicit positive checks, never skipped.
"""
from pathlib import Path
import sys,unittest
ROOT=Path(__file__).resolve().parents[1]
sys.path[:0]=[str(ROOT),str(ROOT/'tests')]
from cleanlang import numeral_inference

MODULES=['test_numeral_pruning','test_declared_standard_operators',
         'test_literal_retention','test_dependent_functions','test_structures']


def main():
 original=numeral_inference.complete
 numeral_inference.complete=numeral_inference.complete_joint
 try:
  from test_numeral_pruning import NumeralPruning
  from test_literal_retention import ExactLiteralPrototype
  from cleanlang.core import Expr,Expressions
  def determined_binder():
   case=NumeralPruning();case.setUp()
   source='function(x: Natural,'+'+'.join(['(x+1)']*9)+')'
   value=numeral_inference.complete(case.tree(source),case.e,case.s)
   case.assertEqual(value.type,case.e.function_type(case.e.type('Natural'),case.e.type('Natural')))
   key=case.e.data['types']['Natural']['numerals']['native_binding']
   case.assertEqual(value.lean.count(key),9)
   case.assertNotIn('x',case.s)
  def inferred_vector_zero():
   case=ExactLiteralPrototype();env=case.load();scope=case.scope(env)
   scope['x']=Expr('x','x',env.type('Vector(n,Complex)',scope),tree=['Local','x'])
   actual=Expressions(env,scope).parse('x != 0')
   explicit=Expressions(env,scope).parse('x != vector zero(n)')
   case.assertEqual((actual.lean,actual.type),(explicit.lean,explicit.type))
   case.assertEqual(actual.tree[3][3],'vector zero')
  replacements={
   'test_numeral_pruning.NumeralPruning.test_atomic_binder_limit_is_explicit':determined_binder,
   'test_literal_retention.ExactLiteralPrototype.test_inferred_calls_do_not_enable_unannotated_zero':inferred_vector_zero,
  }
  def cases(suite):
   for item in suite:
    if isinstance(item,unittest.TestSuite):yield from cases(item)
    else:yield item
  selected=[];seen=set()
  for case in cases(unittest.defaultTestLoader.loadTestsFromNames(MODULES)):
   replacement=replacements.get(case.id())
   if replacement:
    seen.add(case.id());print('Updated joint expectation:',case.id(),flush=True)
    selected.append(unittest.FunctionTestCase(replacement))
   else:selected.append(case)
  if seen!=set(replacements):raise RuntimeError('A documented migration case disappeared')
  result=unittest.TextTestRunner(verbosity=2).run(unittest.TestSuite(selected))
  return 0 if result.wasSuccessful() else 1
 finally:numeral_inference.complete=original

if __name__=='__main__':raise SystemExit(main())

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
