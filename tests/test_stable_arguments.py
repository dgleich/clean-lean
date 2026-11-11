# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
from pathlib import Path
from dataclasses import replace
from unittest.mock import patch
import unittest
from cleanlang.core import Environment,Expr,Expressions,Type,CleanError
from cleanlang.modules import load_module,notation
from cleanlang.conversion import index_comparison
from cleanlang.bound_calls import bind
ROOT=Path(__file__).resolve().parents[1]

class StableArguments(unittest.TestCase):
 def setUp(self):
  self.env=Environment();load_module(ROOT/'library/operators.clean',self.env)
  notation('Notation retain(x: Real): Real:',['Means: x','Render latex: {x}'],self.env)
  notation('Define alias(x: Real): Real:',['Equals: retain(x)'],self.env,authored=True)
  self.scope={'x':Expr('first','x',self.env.type('Real'),tree=['Local','x'])}
 def expr(self,text):return Expressions(self.env,self.scope).parse(text)
 def test_nested_native_arguments_normalized_once(self):
  import cleanlang.conversion as conversion
  depth=8;value=self.expr('retain('*depth+'x'+')'*depth)
  original=conversion._normal_form;calls=[]
  def counted(value,*args,**kwargs):
   if value.tree[0] in ('Call','ModuleCall') and value.tree[1]=='retain':calls.append(value.tree)
   return original(value,*args,**kwargs)
  with patch('cleanlang.conversion._normal_form',side_effect=counted):key=index_comparison(value,self.env,self.scope)
  self.assertEqual(len(calls),depth)
  self.assertEqual(key,value.lean)
 def test_nested_native_operators_normalized_once(self):
  import cleanlang.conversion as conversion
  depth=7;value=self.expr('x'+'+1'*depth)
  original=conversion._normal_form;calls=[]
  def counted(value,*args,**kwargs):
   if value.tree[0]=='Operator':calls.append(value.tree)
   return original(value,*args,**kwargs)
  with patch('cleanlang.conversion._normal_form',side_effect=counted):
   result=index_comparison(value,self.env,self.scope)
  self.assertEqual(len(calls),depth)
  self.assertEqual(result,value.lean)
 def test_prefix_operator_chain_normalized_once(self):
  import cleanlang.conversion as conversion
  depth=6;value=self.expr('-('*depth+'x'+')'*depth)
  original=conversion._normal_form;calls=[]
  def counted(value,*args,**kwargs):
   if value.tree[0]=='Unary':calls.append(value.tree)
   return original(value,*args,**kwargs)
  with patch('cleanlang.conversion._normal_form',side_effect=counted):
   result=index_comparison(value,self.env,self.scope)
  self.assertEqual(len(calls),depth)
  self.assertEqual(result,value.lean)
 def test_operator_children_still_expand_authored_aliases(self):
  self.assertEqual(index_comparison(self.expr('x+alias(x)'),self.env,self.scope),
                   index_comparison(self.expr('x+retain(x)'),self.env,self.scope))
 def test_public_operator_comparison_rechecks_new_overload(self):
  value=self.expr('x+x')
  notation('Notation other sum(x: Real,y: Real): Real:',
           ['Means: x+y','Infix: +','Render latex: {x}+{y}'],self.env)
  with self.assertRaises(CleanError):index_comparison(value,self.env,self.scope)
 def test_authored_alias_still_expands(self):
  self.assertEqual(index_comparison(self.expr('retain(alias(x))'),self.env,self.scope),
   index_comparison(self.expr('retain(retain(x))'),self.env,self.scope))
 def test_public_call_rechecks_mutated_metadata_and_scope(self):
  old=self.expr('retain(retain(x))');old.checked_args=(self.expr('x'),)
  self.scope['x']=Expr('second','x',self.env.type('Real'),tree=['Local','x'])
  current=self.expr('retain(retain(x))')
  self.assertEqual(index_comparison(old,self.env,self.scope),index_comparison(current,self.env,self.scope))
  self.assertIn('second',index_comparison(old,self.env,self.scope))
 def test_retained_identity_still_checked(self):
  value=self.expr('retain(retain(x))');tree=bind(value.tree,self.env,self.scope,binders=True)
  value=Expressions(self.env,self.scope).elaborate(tree)
  self.env.data['functions']['retain']['lean']='changed'
  with self.assertRaises(CleanError):index_comparison(value,self.env,self.scope)
 def test_emission_and_metadata_unchanged(self):
  value=self.expr('retain(alias(x))');before=(value.lean,repr(value.tree),value.checked_args)
  index_comparison(value,self.env,self.scope)
  self.assertEqual((value.lean,repr(value.tree),value.checked_args),before)
 def test_local_normal_is_not_assumed_stable(self):
  value=self.expr('retain(x)')
  self.scope['y']=Expr('second','y',self.env.type('Real'),tree=['Local','y'])
  self.scope['x']=replace(self.scope['x'],local_normal=self.expr('retain(y)'),local_expand=False)
  self.assertEqual(index_comparison(value,self.env,self.scope),index_comparison(self.expr('retain(retain(y))'),self.env,self.scope))

class FreshIndexArguments(StableArguments):
 def test_fresh_and_rechecked_indices_have_identical_payloads(self):
  from cleanlang.indices import index_value
  from cleanlang.retained_codec import dumps
  for source in ('x','retain(alias(x))','x+x'):
   value=self.expr(source)
   self.assertEqual(dumps(index_value(value,self.env,self.scope,_fresh=True)),
                    dumps(index_value(value,self.env,self.scope)))
 def test_fresh_index_avoids_reelaborating_checked_root(self):
  from cleanlang.indices import index_value
  value=self.expr('retain(retain(x))');original=Expressions.elaborate;counts=[]
  def counted(instance,tree):
   if tree==value.tree:counts.append(tree)
   return original(instance,tree)
  with patch.object(Expressions,'elaborate',counted):
   index_value(value,self.env,self.scope,_fresh=True)
  self.assertEqual(counts,[])
  with patch.object(Expressions,'elaborate',counted):
   index_value(value,self.env,self.scope)
  self.assertGreater(len(counts),0)
 def test_public_index_rechecks_scope_despite_cached_operands(self):
  from cleanlang.indices import index_value
  value=self.expr('retain(x)')
  self.scope['x']=Expr('second','x',self.env.type('Real'),tree=['Local','x'])
  self.assertIn('second',str(index_value(value,self.env,self.scope).comparison))
 def test_fresh_retained_index_still_rejects_changed_binding(self):
  from cleanlang.indices import index_value
  value=Expressions(self.env,self.scope).elaborate(bind(self.expr('retain(x)').tree,self.env,self.scope))
  self.env.data['functions']['retain']['lean']='changed'
  with self.assertRaises(CleanError):index_value(value,self.env,self.scope,_fresh=True)

class ScopedComparisonReuse(StableArguments):
 def test_snapshot_visits_shared_values_once_and_reads_mutations(self):
  from cleanlang.comparison_snapshot import snapshot
  value=['Local','x'];shared=[value]*100
  before=snapshot(shared)
  self.assertEqual(len(before[1]),2)
  value[1]='y'
  self.assertNotEqual(before,snapshot(shared))
 def test_snapshot_distinguishes_boolean_and_integer(self):
  from cleanlang.comparison_snapshot import snapshot
  self.assertNotEqual(snapshot([True]),snapshot([1]))
 def test_snapshot_rejects_cycles(self):
  from cleanlang.comparison_snapshot import snapshot
  value=[];value.append(value)
  with self.assertRaises(CleanError):snapshot(value)
 def test_optional_snapshot_exhaustion_falls_back_to_comparison(self):
  from cleanlang.binder_keys import Pool
  from cleanlang.comparison_snapshot import SnapshotUnavailable
  value=self.expr('retain(x)');expected=index_comparison(value,self.env,self.scope)
  self.env._comparison_pool=Pool(self.env,self.scope,value.tree)
  try:
   with patch('cleanlang.comparison_snapshot.snapshot',side_effect=SnapshotUnavailable('budget')):
    self.assertEqual(index_comparison(value,self.env,self.scope),expected)
  finally:del self.env._comparison_pool
 def test_unavailable_snapshot_disables_only_current_pool(self):
  from cleanlang.binder_keys import Pool
  from cleanlang.comparison_snapshot import SnapshotUnavailable
  value=self.expr('retain(x)');expected=index_comparison(value,self.env,self.scope)
  self.env._comparison_pool=Pool(self.env,self.scope,value.tree)
  try:
   with patch('cleanlang.comparison_snapshot.snapshot',side_effect=SnapshotUnavailable('budget')) as snapshots:
    self.assertEqual(index_comparison(value,self.env,self.scope),expected)
    self.assertEqual(index_comparison(value,self.env,self.scope),expected)
    self.assertEqual(snapshots.call_count,1)
   self.scope['x'].lean='changed'
   self.assertIn('changed',str(index_comparison(value,self.env,self.scope)))
  finally:del self.env._comparison_pool
  self.env._comparison_pool=Pool(self.env,self.scope,value.tree)
  try:
   from cleanlang.comparison_snapshot import snapshot
   with patch('cleanlang.comparison_snapshot.snapshot',wraps=snapshot) as snapshots:
    index_comparison(value,self.env,self.scope)
    self.assertGreater(snapshots.call_count,0)
  finally:del self.env._comparison_pool
 def test_unavailable_snapshot_clears_prior_entries(self):
  from cleanlang.binder_keys import Pool
  from cleanlang.comparison_snapshot import SnapshotUnavailable
  value=self.expr('retain(x)');other=self.expr('retain(retain(x))')
  pool=Pool(self.env,self.scope,value.tree);self.env._comparison_pool=pool
  try:
   index_comparison(value,self.env,self.scope)
   self.assertTrue(pool.comparison_memo)
   with patch('cleanlang.comparison_snapshot.snapshot',side_effect=SnapshotUnavailable('budget')):
    index_comparison(other,self.env,self.scope)
   self.assertTrue(pool.comparison_memo_disabled)
   self.assertEqual(pool.comparison_memo,{})
   index_comparison(value,self.env,self.scope)
   self.assertEqual(pool.comparison_memo,{})
  finally:del self.env._comparison_pool
 def test_disable_during_normalization_prevents_outer_storage(self):
  from cleanlang.binder_keys import Pool
  import cleanlang.conversion as conversion
  value=self.expr('retain(x)');pool=Pool(self.env,self.scope,value.tree)
  self.env._comparison_pool=pool;original=conversion._normal_form
  def disable(*args,**kwargs):
   pool.comparison_memo_disabled=True
   return original(*args,**kwargs)
  try:
   with patch('cleanlang.conversion._normal_form',side_effect=disable):
    index_comparison(value,self.env,self.scope)
   self.assertEqual(pool.comparison_memo,{})
  finally:del self.env._comparison_pool
 def test_snapshot_budget_is_bounded(self):
  from cleanlang.comparison_snapshot import snapshot,SnapshotUnavailable
  with self.assertRaises(SnapshotUnavailable):snapshot(list(range(20)),limit=10)
 def test_repeated_index_within_pool_normalizes_once(self):
  from cleanlang.binder_keys import Pool
  import cleanlang.conversion as conversion
  value=self.expr('retain(x)')
  self.env._comparison_pool=Pool(self.env,self.scope,value.tree)
  original=conversion._normal_form;calls=[]
  def counted(value,*args,**kwargs):
   if value.tree[0]=='Call' and value.tree[1]=='retain':calls.append(value.tree)
   return original(value,*args,**kwargs)
  try:
   with patch('cleanlang.conversion._normal_form',side_effect=counted):
    first=index_comparison(value,self.env,self.scope)
    second=index_comparison(value,self.env,self.scope)
   self.assertEqual(first,second);self.assertEqual(len(calls),1)
  finally:del self.env._comparison_pool
 def test_in_place_local_change_invalidates_memo(self):
  from cleanlang.binder_keys import Pool
  value=self.expr('retain(x)');self.env._comparison_pool=Pool(self.env,self.scope,value.tree)
  try:
   before=index_comparison(value,self.env,self.scope)
   self.scope['x'].lean='changed'
   after=index_comparison(value,self.env,self.scope)
   self.assertNotEqual(before,after);self.assertIn('changed',str(after))
  finally:del self.env._comparison_pool
 def test_pool_identity_growth_invalidates_memo(self):
  from cleanlang.binder_keys import Pool
  value=self.expr('retain(x)');pool=Pool(self.env,self.scope,value.tree)
  self.env._comparison_pool=pool
  try:
   index_comparison(value,self.env,self.scope)
   old=len(pool.comparison_memo)
   pool.fresh(self.scope)
   index_comparison(value,self.env,self.scope)
   self.assertEqual(len(pool.comparison_memo),old+1)
  finally:del self.env._comparison_pool
 def test_allocation_during_comparison_prevents_storage(self):
  from cleanlang.binder_keys import Pool
  import cleanlang.conversion as conversion
  value=self.expr('retain(x)');pool=Pool(self.env,self.scope,value.tree)
  self.env._comparison_pool=pool;original=conversion._normal_form
  def allocate(*args,**kwargs):
   pool.fresh(self.scope)
   return original(*args,**kwargs)
  try:
   with patch('cleanlang.conversion._normal_form',side_effect=allocate):
    index_comparison(value,self.env,self.scope)
   self.assertEqual(pool.comparison_memo,{})
  finally:del self.env._comparison_pool
 def test_failure_is_not_stored(self):
  from cleanlang.binder_keys import Pool
  value=self.expr('retain(x)');pool=Pool(self.env,self.scope,value.tree)
  self.env._comparison_pool=pool
  try:
   with patch('cleanlang.conversion._normal_form',side_effect=CleanError('incomplete check')) as failed:
    for _ in range(2):
     with self.assertRaisesRegex(CleanError,'incomplete check'):
      index_comparison(value,self.env,self.scope)
    self.assertEqual(failed.call_count,2)
   self.assertEqual(pool.comparison_memo,{})
  finally:del self.env._comparison_pool
 def test_public_comparisons_do_not_retain_memo(self):
  value=self.expr('retain(x)');index_comparison(value,self.env,self.scope)
  self.assertFalse(hasattr(self.env,'_comparison_pool'))
  self.env.data['functions']['retain']['lean']='changed'
  updated=index_comparison(value,self.env,self.scope)
  self.assertIn('changed',str(updated))

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
