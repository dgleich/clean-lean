# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from unittest.mock import patch
from cleanlang.core import Environment,Expr,Expressions
from cleanlang.modules import load_module,notation
from cleanlang.syntax import parse,expression_tree
from cleanlang.retained_codec import dumps,loads
from cleanlang.joint_inference.clean_rows import Builder
from cleanlang.joint_inference.constraint_model import NoSolution,Incomplete,Ambiguous
ROOT=Path(__file__).resolve().parents[2]

class ScopedCalls(unittest.TestCase):
 def setUp(self):
  self.env=Environment();load_module(ROOT/'library/linear_algebra.clean',self.env)
  self.scope={'n':Expr('n','n',self.env.type('Natural'),tree=['Local','n'])}
 def solve(self,source,**kwargs):
  return Builder(self.env,self.scope).materialize(expression_tree(parse(source,'expression')),**kwargs)
 def declare(self,name='consume',function='Function(k: Natural,Vector(k,Complex))'):
  notation(f'Notation {name}(f: {function},x: Real): Real:', ['Means: x','Render latex: c({f},{x})'],self.env)
 def test_direct_dependent_lambda_is_automatic(self):
  self.declare();value=self.solve('consume(function (k: Natural,0),0)',use_default=False)
  self.assertEqual(value.type,self.env.type('Real'))
  self.assertEqual(value.tree[2][0][3][3],'complex vector zero')
  self.assertEqual(value.tree[2][1][2],'Real')
 def test_computed_dependent_dimension(self):
  self.declare(function='Function(k: Natural,Vector((k+1),Complex))')
  value=self.solve('consume(function (k: Natural,0),0)',use_default=False)
  self.assertEqual(value.tree[2][0][3][3],'complex vector zero')
 def test_sibling_scopes_have_distinct_unknowns(self):
  a=Builder(self.env,self.scope,row_namespace=(2,0));b=Builder(self.env,self.scope,row_namespace=(2,1))
  self.assertNotEqual(a.variable('same','index'),b.variable('same','index'))
 def test_two_lambda_arguments_keep_independent_types(self):
  notation('Notation two(f: Function(Real,Real),g: Function(Real,Complex)): Real:',
   ['Means: 0','Render latex: two({f},{g})'],self.env)
  value=self.solve('two(function (a: Real,0),function (b: Real,0))',use_default=False)
  self.assertEqual(value.tree[2][0][3][2],'Real')
  self.assertEqual(value.tree[2][1][3][2],'Complex')
 def test_known_earlier_dimension_is_substituted(self):
  notation('Notation sized(n: Natural,f: Function(Real,Vector(n,Complex))): Real:',
   ['Means: 0','Render latex: sized({n},{f})'],self.env)
  value=self.solve('sized(n,function (a: Real,0))',use_default=False)
  self.assertEqual(value.tree[2][1][3][3],'complex vector zero')
 def test_sibling_vector_literals_do_not_share_formal_dimensions(self):
  notation('Notation mixed(n: Natural,m: Natural,f: Function(Real,Real),a: Vector(n,Complex),b: Vector(m,Complex)): Real:',
   ['Means: 0','Render latex: mixed({n},{m},{f},{a},{b})'],self.env)
  self.scope['m']=Expr('m','m',self.env.type('Natural'),tree=['Local','m'])
  value=self.solve('mixed(n,m,function (z: Real,0),0,0)',use_default=False)
  self.assertNotEqual(value.tree[2][3][5],value.tree[2][4][5])
 def test_quantified_argument_uses_the_same_joint_path(self):
  notation('Notation accept(p: Proposition,x: Real): Real:', ['Means: x','Render latex: accept({p},{x})'],self.env)
  value=self.solve('accept(for every (z: Real,z = 0),0)',use_default=False)
  self.assertEqual(value.tree[2][0][0],'Forall')
  self.assertEqual(value.tree[2][0][3][3][2],'Real')
 def test_known_earlier_carrier_is_substituted(self):
  notation('Notation typed(T: Type,f: Function(T,T),x: T): T:', ['Means: f x','Render latex: typed({T},{f},{x})'],self.env)
  value=self.solve('typed(type(Real),function (z: Real,0),0)',use_default=False)
  self.assertEqual(value.type,self.env.type('Real'))
  self.assertEqual(value.tree[2][1][3][2],'Real')
 def test_unresolved_earlier_dimension_is_incomplete(self):
  notation('Notation sized(n: Natural,f: Function(Real,Vector(n,Complex))): Real:',
   ['Means: 0','Render latex: sized({n},{f})'],self.env)
  with self.assertRaises(Incomplete):self.solve('sized(2,function (a: Real,0))')
 def test_implicit_consumer_is_explicitly_incomplete(self):
  notation('Notation generic(f):',['Let T: Type','Let f: Function(T,T)','Returns: Real','Means: 0','Render latex: g({f})'],self.env)
  with self.assertRaises(Incomplete):self.solve('generic(function (a: Real,0))')
 def test_lambda_domain_and_call_result_mismatch_reject(self):
  self.declare()
  with self.assertRaises(NoSolution):self.solve('consume(function (k: Real,0),0)')
  with self.assertRaises(NoSolution):self.solve('consume(function (k: Natural,0),0)',expected=self.env.type('Complex'))
 def test_retained_complete_call_round_trips(self):
  self.declare();value=self.solve('consume(function (k: Natural,0),0)')
  self.assertEqual(Expressions(self.env,self.scope).elaborate(loads(dumps(value.tree))).lean,value.lean)
 def test_children_are_not_independently_selected(self):
  self.declare()
  with patch.object(Builder,'solve_with_trace',side_effect=AssertionError('independent selection')):
   self.solve('consume(function (k: Natural,0),0)',use_default=False)
 def test_sibling_operator_ambiguity_is_preserved(self):
  self.declare()
  notation('Notation alternative(x: Real,y: Real): Complex:', ['Means: 0','Infix: +','Render latex: {x}+{y}'],self.env)
  self.scope['r']=Expr('r','r',self.env.type('Real'),tree=['Local','r'])
  with self.assertRaises(Ambiguous):self.solve('consume(function (k: Natural,0),r+0)')

 def test_nested_lambda_body(self):
  self.declare(function='Function(Real,Function(Real,Real))')
  with patch.object(Builder,'solve_with_trace',side_effect=AssertionError('inner selection')):
   value=self.solve('consume(function (a: Real,function (b: Real,0)),0)',use_default=False)
  self.assertEqual(value.tree[2][0][3][3][2],'Real')
 def test_nested_call_argument(self):
  self.declare()
  notation('Notation wrap(x: Real): Real:',['Means: x','Render latex: w({x})'],self.env)
  value=self.solve('wrap(consume(function (k: Natural,0),0))',use_default=False)
  self.assertEqual(value.tree[2][0][2][0][3][3],'complex vector zero')
 def test_call_inside_lambda_body(self):
  self.declare(function='Function(Real,Real)')
  value=self.solve('consume(function (a: Real,consume(function (b: Real,0),0)),0)',use_default=False)
  self.assertEqual(Expressions(self.env,self.scope).elaborate(loads(dumps(value.tree))).lean,value.lean)
 def test_nested_quantifier(self):
  notation('Notation accept(p: Proposition,x: Real): Real:', ['Means: x','Render latex: accept({p},{x})'],self.env)
  value=self.solve('accept(for every (a: Real,for every (b: Real,b = 0)),0)',use_default=False)
  self.assertEqual(value.tree[2][0][3][0],'Forall')

 def test_nested_resource_exhaustion_is_incomplete(self):
  self.declare(function='Function(Real,Function(Real,Real))')
  tree=expression_tree(parse('consume(function (a: Real,function (b: Real,0)),0)','expression'))
  with self.assertRaises(Incomplete):Builder(self.env,self.scope,limit=3).materialize(tree)
 def test_nested_operator_ambiguity_is_not_hidden(self):
  self.declare(function='Function(Real,Real)')
  notation('Notation alternative(x: Real,y: Real): Complex:', ['Means: 0','Infix: +','Render latex: {x}+{y}'],self.env)
  with self.assertRaises(Ambiguous):
   self.solve('consume(function (a: Real,consume(function (b: Real,b+0),0)),0)')

 def local_consumer(self,typ):
  self.scope['h']=Expr('h','h',self.env.type(typ,self.scope),tree=['Local','h'])
 def test_local_consumer(self):
  self.local_consumer('Function(Function(Real,Real),Real)')
  with patch.object(Builder,'solve_with_trace',side_effect=AssertionError('inner selection')):
   value=self.solve('h(function (a: Real,0))',use_default=False)
  self.assertEqual(value.type,self.env.type('Real'))
 def test_local_dependent_consumer(self):
  self.local_consumer('Function(k: Natural,Function(Function(Real,Vector(k,Complex)),Real))')
  value=self.solve('h(n)(function (a: Real,0))',use_default=False)
  self.assertEqual(value.tree[2][0][3][3],'complex vector zero')
 def test_local_unresolved_dependency_is_incomplete(self):
  self.local_consumer('Function(k: Natural,Function(Function(Real,Vector(k,Complex)),Real))')
  with self.assertRaises(Incomplete):self.solve('h(2)(function (a: Real,0))')
 def test_local_quantified_consumer(self):
  self.local_consumer('Function(Proposition,Real)')
  value=self.solve('h(for every (a: Real,a = 0))',use_default=False)
  self.assertEqual(value.tree[2][0][0],'Forall')
 def test_local_arity_mismatch(self):
  self.local_consumer('Function(Function(Real,Real),Real)')
  with self.assertRaises(NoSolution):self.solve('h(function (a: Real,0),0)')
 def test_local_consumer_round_trip(self):
  self.local_consumer('Function(Function(Real,Real),Real)')
  value=self.solve('h(function (a: Real,0))')
  self.assertEqual(Expressions(self.env,self.scope).elaborate(loads(dumps(value.tree))).lean,value.lean)

 def test_scoped_local_head_and_argument_are_joint(self):
  self.local_consumer('Function(Function(Real,Real),Function(Complex,Real))')
  with patch.object(Builder,'solve_with_trace',side_effect=AssertionError('inner selection')):
   value=self.solve('h(function (a: Real,0))(0)',use_default=False)
  self.assertEqual(value.tree[2][0][2],'Complex')
  self.assertEqual(value.tree[1][2][0][3][2],'Real')
 def test_scoped_module_head(self):
  notation('Notation factory(f: Function(Real,Real)): Function(Complex,Real):',
   ['Means: fun _ => f 0','Render latex: factory({f})'],self.env)
  value=self.solve('factory(function (a: Real,0))(0)',use_default=False)
  self.assertEqual(value.tree[2][0][2],'Complex')
 def test_nonscoped_literal_head_with_scoped_argument(self):
  self.local_consumer('Function(Complex,Function(Function(Real,Real),Real))')
  value=self.solve('h(0)(function (a: Real,0))',use_default=False)
  self.assertEqual(value.tree[1][2][0][2],'Complex')
 def test_nested_head_round_trip(self):
  self.local_consumer('Function(Function(Real,Real),Function(Complex,Real))')
  value=self.solve('h(function (a: Real,0))(0)')
  self.assertEqual(Expressions(self.env,self.scope).elaborate(loads(dumps(value.tree))).lean,value.lean)
 def test_head_operator_ambiguity_blocks_outer_selection(self):
  self.local_consumer('Function(Function(Real,Real),Function(Complex,Real))')
  notation('Notation alternative(x: Real,y: Real): Complex:', ['Means: 0','Infix: +','Render latex: {x}+{y}'],self.env)
  with self.assertRaises(Ambiguous):self.solve('h(function (a: Real,a+0))(0)')
 def test_head_resource_limit(self):
  self.local_consumer('Function(Function(Real,Real),Function(Complex,Real))')
  tree=expression_tree(parse('h(function (a: Real,0))(0)','expression'))
  with self.assertRaises(Incomplete):Builder(self.env,self.scope,limit=3).materialize(tree)

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
