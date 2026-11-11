# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Independent collision and operation-count contracts for lazy reservation."""
from pathlib import Path
from types import SimpleNamespace
from unittest.mock import patch
import unittest
import cleanlang
from cleanlang.core import Environment,Expr,Expressions,Type
from cleanlang.modules import load_module
from cleanlang.binder_keys import Pool,environment_tokens
from cleanlang.conversion import index_comparison
ROOT=Path(cleanlang.__file__).resolve().parents[1]

class Reservation(unittest.TestCase):
 def test_all_collision_sources_are_reserved_before_allocation(self):
  env=SimpleNamespace(data={'token':'clean_comparison_identity_0'},
   notation_definitions={'native':'clean_comparison_identity_1'})
  local={'clean_comparison_identity_2':Expr('x','x',Type('Real'))}
  with patch('cleanlang.binder_keys.environment_tokens',wraps=environment_tokens) as scan:
   pool=Pool(env,local,['Local','clean_comparison_identity_3'])
   self.assertEqual(scan.call_count,0)
   self.assertEqual(pool.fresh(local),'clean_comparison_identity_4')
   self.assertEqual(pool.fresh(local),'clean_comparison_identity_5')
   self.assertEqual(scan.call_count,1)
 def test_later_pool_observes_environment_changes(self):
  env=SimpleNamespace(data={},notation_definitions={})
  first=Pool(env,{},['Local','x'])
  self.assertEqual(first.fresh({}),'clean_comparison_identity_0')
  env.data['later']='clean_comparison_identity_0'
  second=Pool(env,{},['Local','x'])
  self.assertEqual(second.fresh({}),'clean_comparison_identity_1')
 def test_allocation_checks_new_local_scope(self):
  env=SimpleNamespace(data={},notation_definitions={})
  pool=Pool(env,{},['Local','x'])
  local={'y':Expr('clean_comparison_identity_0','y',Type('Real'))}
  self.assertEqual(pool.fresh(local),'clean_comparison_identity_1')
 def test_shared_containers_are_scanned_once(self):
  class Counted(list):
   visits=0
   def __iter__(self):self.visits+=1;return super().__iter__()
  shared=Counted(['clean_comparison_identity_0'])
  env=SimpleNamespace(data={'first':[shared]*100,'second':shared},notation_definitions={})
  tokens=environment_tokens(env)
  self.assertEqual(shared.visits,1)
  self.assertEqual(tokens,frozenset(['first','second','clean_comparison_identity_0']))
 def test_text_set_is_independent_of_order_and_sharing(self):
  a=SimpleNamespace(data={'a':['x','y','x'],'b':['y']},notation_definitions={'body':'z'})
  b=SimpleNamespace(data={'b':['y','x'],'a':['x','y']},notation_definitions={'body':'z'})
  self.assertEqual(environment_tokens(a),environment_tokens(b))
  self.assertEqual(a._comparison_reserved_tokens[0],b._comparison_reserved_tokens[0])
 def test_shared_mutations_are_read_by_later_scan(self):
  shared=['clean_comparison_identity_0']
  env=SimpleNamespace(data=[shared,shared],notation_definitions={})
  self.assertIn('clean_comparison_identity_0',environment_tokens(env))
  shared[:]=['clean_comparison_identity_1']
  current=environment_tokens(env)
  self.assertNotIn('clean_comparison_identity_0',current)
  self.assertIn('clean_comparison_identity_1',current)
 def test_deep_shared_graph_reserves_every_collision_token(self):
  graph=['clean_comparison_identity_0']
  for _ in range(2000):graph=[graph,graph]
  env=SimpleNamespace(data=graph,notation_definitions={'body':'clean_comparison_identity_1'})
  self.assertEqual(Pool(env,{},['Local','x']).fresh({}),'clean_comparison_identity_2')
 def test_dictionary_keys_and_native_bodies_are_scanned(self):
  env=SimpleNamespace(data={('clean_comparison_identity_0','key'):['value']},
   notation_definitions={'native':'def clean_comparison_identity_1 := value'})
  self.assertEqual(Pool(env,{},['Local','x']).fresh({}),'clean_comparison_identity_2')
 def test_binder_free_comparison_does_not_scan_environment(self):
  env=Environment();load_module(ROOT/'library/operators.clean',env)
  local={'x':Expr('x','x',env.type('Real'),tree=['Local','x'])}
  value=Expressions(env,local).parse('x=x')
  with patch('cleanlang.binder_keys.environment_tokens',wraps=environment_tokens) as scan:
   self.assertEqual(index_comparison(value,env,local),value.lean)
   self.assertEqual(index_comparison(value,env,local),value.lean)
   self.assertEqual(scan.call_count,0)
 def test_quantified_comparison_reserves_once_and_preserves_alpha_key(self):
  env=Environment();load_module(ROOT/'library/operators.clean',env)
  a=Expressions(env,{}).parse('for every(x: Real,for every(y: Real,x=y))')
  b=Expressions(env,{}).parse('for every(u: Real,for every(v: Real,u=v))')
  with patch('cleanlang.binder_keys.environment_tokens',wraps=environment_tokens) as scan:
   first=index_comparison(a,env,{})
   self.assertEqual(scan.call_count,1)
   second=index_comparison(b,env,{})
   self.assertEqual(scan.call_count,2)
   self.assertEqual(first,second)
   self.assertFalse(hasattr(env,'_comparison_pool'))

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
