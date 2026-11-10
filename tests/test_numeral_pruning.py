# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
from pathlib import Path
from itertools import product
import unittest,tempfile
from cleanlang.core import Environment,Expr,Expressions,Type,CleanError,SignatureMismatch
from cleanlang.modules import load_module
from cleanlang.syntax import expression_tree,parse
from cleanlang.numeral_inference import complete,holes,IncompleteNumeralAnalysis
from cleanlang.numerals import identity
ROOT=Path(__file__).resolve().parents[1]

def exhaustive(tree,e,s):
 positions=holes(tree);choices=[(n,identity(n,e)) for n,v in e.data['types'].items() if 'numerals' in v]
 owner=object();old=getattr(e,'_numeral_trial_owner',None);e._numeral_trial_owner=owner
 answers=[]
 try:
  for selected in product(choices,repeat=len(positions)):
   replacements={path:['BoundNumeral',digits,name,snapshot,'inferred'] for (path,digits),(name,snapshot) in zip(positions,selected)}
   def rewrite(node,path=()):
    if path in replacements:return replacements[path]
    if isinstance(node,list):return [rewrite(child,path+(i,)) for i,child in enumerate(node)]
    return node
   try:
    worker=Expressions(e,dict(s));worker.bound_counter=0
    answers.append(worker._elaborate(rewrite(tree)))
   except SignatureMismatch as error:
    if error.owner is not owner:raise
 finally:
  if old is None:del e._numeral_trial_owner
  else:e._numeral_trial_owner=old
 return answers

class NumeralPruning(unittest.TestCase):
 def setUp(self):
  self.e=Environment();load_module(ROOT/'library/operators.clean',self.e)
  self.s={n:Expr(n,n,self.e.type(t),tree=['Local',n]) for n,t in [('n','Natural'),('r','Real')]}
 def tree(self,text):return expression_tree(parse(text,'expression'))
 def test_matches_flat_exhaustive_search_before_defaults(self):
  del self.e.numeral_default
  for text in ['n+1','r=1+1','(n+1)+(n+2)','1+2','1=r','function(x: Natural,x+1)']:
   with self.subTest(text=text):
    tree=self.tree(text);expected=exhaustive(tree,self.e,self.s)
    if len(expected)==1:
     actual=complete(tree,self.e,self.s)
     self.assertEqual((actual.lean,actual.type),(expected[0].lean,expected[0].type))
    else:
     with self.assertRaisesRegex(CleanError,'Ambiguous numeral interpretation: '+str(len(expected))):complete(tree,self.e,self.s)
 def test_parent_selects_real_before_default(self):
  value=complete(self.tree('r=1+1'),self.e,self.s)
  key=self.e.data['types']['Real']['numerals']['native_binding']
  self.assertEqual(value.lean.count(key),2)
  self.assertNotIn('defaulted',str(value.tree))
 def test_long_determined_sum(self):
  tree=self.tree('+'.join(['(n+1)']*9))
  self.assertEqual(len(holes(tree)),9)
  value=complete(tree,self.e,self.s)
  key=self.e.data['types']['Natural']['numerals']['native_binding']
  self.assertEqual(value.lean.count(key),9)
  self.assertEqual(value.type,self.e.type('Natural'))
 def test_incomplete_local_search_does_not_use_default(self):
  with self.assertRaises(IncompleteNumeralAnalysis):complete(self.tree('1+1'),self.e,self.s,limit=2)
  self.assertFalse(hasattr(self.e,'_numeral_trial_owner'))
 def test_joint_default_conflict_is_preserved(self):
  source='''Import "PATH"
Default numerals: Natural
Condition cross left(x: Natural,y: Real):
  Infix: ^
  From Lean: True
Condition cross right(x: Real,y: Natural):
  Infix: ^
  From Lean: True
'''.replace('PATH',str(ROOT/'library/types.clean'))
  with tempfile.TemporaryDirectory() as d:
   p=Path(d)/'Cross.clean';p.write_text(source);e=Environment();load_module(p,e)
  with self.assertRaisesRegex(CleanError,'conflicts across ambiguous positions'):complete(self.tree('1^2'),e,{})
 def test_foreign_and_incomplete_errors_propagate(self):
  original=self.e.operator
  for error in [SignatureMismatch('foreign',object()),IncompleteNumeralAnalysis('unfinished')]:
   def fail(*a,**kw):raise error
   self.e.operator=fail
   with self.assertRaises(type(error)):complete(self.tree('n+1'),self.e,self.s)
   self.assertFalse(hasattr(self.e,'_numeral_trial_owner'))
  self.e.operator=original
 def test_binders_keep_their_scope(self):
  value=complete(self.tree('function(x: Natural,x+1)'),self.e,self.s)
  self.assertEqual(value.tree[0],'Lambda')
  self.assertNotIn('x',self.s)

 def test_invalid_sibling_does_not_hide_unknown_name(self):
  with self.assertRaisesRegex(CleanError,'Unknown name: missing'):complete(self.tree('missing+(type(Real)+1)'),self.e,self.s)

 def test_generated_small_expressions_match_flat_oracle(self):
  del self.e.numeral_default
  expressions=[f'({a})+({b})' for a in ['n','r','1','n+1','r+1']
               for b in ['n','r','2','n+2','r+2']]
  expressions += ['-(r+1)','(function(x: Natural,x+1))(2)',
                  'for every(x: Natural,x+1=x+1)',
                  'there exists(x: Real,x=1)']
  for source in expressions:
   with self.subTest(source=source):
    tree=self.tree(source);expected=exhaustive(tree,self.e,self.s)
    if len(expected)==1:
     actual=complete(tree,self.e,self.s)
     self.assertEqual((actual.lean,actual.type),(expected[0].lean,expected[0].type))
    elif expected:
     with self.assertRaisesRegex(CleanError,'Ambiguous numeral interpretation: '+str(len(expected))):
      complete(tree,self.e,self.s)
    else:
     with self.assertRaises(CleanError):complete(tree,self.e,self.s)
 def test_expected_type_filters_complete_root_solutions(self):
  tree=self.tree('1+2')
  for name in ['Natural','Real','Complex']:
   expected_type=self.e.type(name)
   expected=[x for x in exhaustive(tree,self.e,self.s) if x.type==expected_type]
   self.assertEqual(len(expected),1)
   actual=complete(tree,self.e,self.s,expected_type)
   self.assertEqual((actual.lean,actual.type),(expected[0].lean,expected[0].type))
 def test_failed_first_child_does_not_hide_unknown_second_child(self):
  with self.assertRaisesRegex(CleanError,'Unknown name: missing'):
   complete(self.tree('(type(Real)+1)+missing'),self.e,self.s)
 def test_atomic_binder_limit_is_explicit(self):
  source='function(x: Natural,'+'+'.join(['(x+1)']*9)+')'
  with self.assertRaises(IncompleteNumeralAnalysis):complete(self.tree(source),self.e,self.s)
 def test_existing_search_owner_is_restored(self):
  sentinel=object();self.e._numeral_trial_owner=sentinel
  complete(self.tree('n+1'),self.e,self.s)
  self.assertIs(self.e._numeral_trial_owner,sentinel)
  with self.assertRaises(IncompleteNumeralAnalysis):complete(self.tree('1+2'),self.e,self.s,limit=1)
  self.assertIs(self.e._numeral_trial_owner,sentinel)

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
