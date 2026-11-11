# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Explicit packaged API; these tests do not enable it as default inference."""
from pathlib import Path
import unittest
from unittest.mock import patch
from cleanlang.core import Environment,Expr,Expressions,CleanError
from cleanlang.modules import load_module,type_declaration,notation
from cleanlang.syntax import parse,expression_tree
from cleanlang.joint_inference import complete,Incomplete,NoSolution,Ambiguous

ROOT=Path(__file__).resolve().parents[1]

class JointCompletion(unittest.TestCase):
 def setUp(self):
  self.env=Environment();load_module(ROOT/'library/linear_algebra.clean',self.env)
  self.scope={'n':Expr('n','n',self.env.type('Natural'),tree=['Local','n'])}
 def test_vector_zero_uses_explicit_expected_carrier(self):
  expected=self.env.type('Vector(n,Complex)',self.scope)
  value=complete(expression_tree(parse('0','expression')),self.env,self.scope,expected,use_default=False)
  self.assertEqual(value.type,expected)
  self.assertEqual(value.tree[0],'BoundLiteral')
  self.assertEqual(value.tree[3],'complex vector zero')
 def test_local_scoped_application_uses_packaged_recursive_path(self):
  typ=self.env.type('Function(Function(Real,Real),Function(Complex,Real))')
  self.scope['h']=Expr('h','h',typ,tree=['Local','h'])
  tree=expression_tree(parse('h(function (a: Real,0))(0)','expression'))
  value=complete(tree,self.env,self.scope,use_default=False)
  self.assertEqual(value.tree[2][0][2],'Complex')
  self.assertEqual(Expressions(self.env,self.scope).elaborate(value.tree).lean,value.lean)
 def test_incomplete_never_falls_back_to_legacy_completion(self):
  typ=self.env.type('Function(k: Natural,Function(Function(Real,Vector(k,Complex)),Real))')
  self.scope['h']=Expr('h','h',typ,tree=['Local','h'])
  tree=expression_tree(parse('h(2)(function (a: Real,0))','expression'))
  # Checked subexpressions still use the ordinary no-hole elaborator. Verify
  # that an incomplete joint solve itself is propagated without a retry.
  with patch('cleanlang.joint_inference.clean_rows.Builder.materialize',side_effect=Incomplete('unresolved head')):
   with patch('cleanlang.numeral_inference.complete',side_effect=AssertionError('legacy fallback')):
    with self.assertRaises(Incomplete):complete(tree,self.env,self.scope)
 def test_caller_scope_dictionary_is_not_mutated(self):
  before=dict(self.scope)
  complete(expression_tree(parse('0','expression')),self.env,self.scope,self.env.type('Real'))
  self.assertEqual(self.scope,before)

 def test_analysis_identity_does_not_expand_impossible_child_rows(self):
  load_module(ROOT/'library/analysis.clean',self.env)
  self.scope['x']=Expr('x','x',self.env.type('Real'),tree=['Local','x'])
  tree=expression_tree(parse('sin(x)^2 + cos(x)^2 = 1','expression'))
  value=complete(tree,self.env,self.scope,use_default=False)
  self.assertEqual(value.type,self.env.type('Proposition'))
  self.assertEqual(Expressions(self.env,self.scope).elaborate(value.tree).lean,value.lean)

 def high_carrier(self,level):
  name='High'+str(level)
  type_declaration('Type '+name+'():',['Universe: '+str(level),'Means: ULift.{'+str(level)+',0} Nat','Render latex: H'],self.env)
  return self.env.type(name)
 def test_closed_higher_nominal_function_results(self):
  for level in (1,2):
   typ=self.high_carrier(level)
   self.scope['object']=Expr('object','object',self.env.function_type(self.env.type('Natural'),typ),tree=['Local','object'])
   value=complete(expression_tree(parse('object(n+1)','expression')),self.env,self.scope,use_default=False)
   self.assertEqual(value.type,typ)
   self.assertEqual(self.env.sort_level(value.type),level+1)
 def test_higher_nominal_result_cannot_match_lower_expected_type(self):
  typ=self.high_carrier(1)
  self.scope['object']=Expr('object','object',self.env.function_type(self.env.type('Natural'),typ),tree=['Local','object'])
  with self.assertRaises(NoSolution):
   complete(expression_tree(parse('object(n+1)','expression')),self.env,self.scope,self.env.type('Natural'))
 def test_higher_classifier_inference_remains_explicitly_incomplete(self):
  self.high_carrier(1)
  type_declaration('Type Large():',['Universe: 2','Classifies: 1','Means: Type 1','Render latex: L'],self.env)
  notation('Notation take(T: Large,x: Natural): Natural:', ['Means: x','Render latex: t({T},{x})'],self.env)
  with self.assertRaises(Incomplete):
   complete(expression_tree(parse('take(type(High1),0)','expression')),self.env,self.scope)

 def test_direct_lambda_application_without_inner_selection(self):
  tree=expression_tree(parse('(function(x: Natural,x+1))(2)','expression'))
  with patch('cleanlang.joint_inference.clean_rows.Builder.solve_with_trace',side_effect=AssertionError('inner selection')):
   value=complete(tree,self.env,self.scope,use_default=False)
  self.assertEqual(value.type,self.env.type('Natural'))
  self.assertEqual(value.tree[1][0],'Lambda')
  self.assertEqual(value.tree[2][0][2],'Natural')
 def test_direct_lambda_application_domain_mismatch(self):
  self.scope['r']=Expr('r','r',self.env.type('Real'),tree=['Local','r'])
  with self.assertRaises(NoSolution):
   complete(expression_tree(parse('(function(x: Natural,x+1))(r)','expression')),self.env,self.scope)
 def test_direct_lambda_body_operator_ambiguity_survives(self):
  notation('Notation other sum(x: Natural,y: Natural): Natural:', ['Means: x+y','Infix: +','Render latex: {x}+{y}'],self.env)
  with self.assertRaises(Ambiguous):
   complete(expression_tree(parse('(function(x: Natural,x+1))(2)','expression')),self.env,self.scope)
 def test_direct_lambda_undetermined_codomain_remains_incomplete(self):
  with self.assertRaises(Incomplete):
   complete(expression_tree(parse('(function(x: Natural,0))(2)','expression')),self.env,self.scope)

 def indexed_lambda_overloads(self,reverse=False):
  declarations=[('indexed sum','k','Real'),('successor indexed sum','(k+1)','Complex')]
  if reverse:declarations.reverse()
  for name,index,carrier in declarations:
   notation(f'Notation {name}(k: Natural,z: {carrier}): Vector({index},Complex):',
            ['Means: fun _ => 0','Infix: +','Render latex: {k}+{z}'],self.env)
 def test_direct_lambda_distinct_codomains_remain_ambiguous(self):
  self.indexed_lambda_overloads()
  with self.assertRaises(Ambiguous):
   complete(expression_tree(parse('(function(k: Natural,k+0))(n)','expression')),
            self.env,self.scope,use_default=False)
 def test_indexed_expectation_selects_lambda_codomain_after_application(self):
  self.indexed_lambda_overloads()
  tree=expression_tree(parse('(function(k: Natural,k+0))(n)','expression'))
  self.assertEqual(tree,['Apply',['Lambda','k','Natural',['Operator','+',['Local','k'],['Decimal','0']]],[['Local','n']]])
  expected=self.env.type('Vector(n,Complex)',self.scope)
  with patch('cleanlang.joint_inference.clean_rows.Builder.solve_with_trace',side_effect=AssertionError('inner selection')):
   value=complete(tree,self.env,self.scope,expected,use_default=False)
  self.assertEqual(value.type,expected)
  self.assertIn(self.env.data['functions']['indexed sum']['native_binding'],value.lean)
  self.assertNotIn(self.env.data['functions']['successor indexed sum']['native_binding'],value.lean)
 def test_indexed_lambda_alternatives_do_not_depend_on_declaration_order(self):
  source='(function(k: Natural,k+0))(n)'
  self.indexed_lambda_overloads()
  first=complete(expression_tree(parse(source,'expression')),self.env,self.scope,self.env.type('Vector((n+1),Complex)',self.scope),use_default=False)
  self.setUp();self.indexed_lambda_overloads(reverse=True)
  second=complete(expression_tree(parse(source,'expression')),self.env,self.scope,self.env.type('Vector((n+1),Complex)',self.scope),use_default=False)
  self.assertEqual((first.tree,first.lean,first.type),(second.tree,second.lean,second.type))
 def test_indexed_lambda_alternatives_reject_unmatched_result(self):
  self.indexed_lambda_overloads()
  with self.assertRaises(NoSolution):
   complete(expression_tree(parse('(function(k: Natural,k+0))(n)','expression')),self.env,self.scope,self.env.type('Vector((n+2),Complex)',self.scope),use_default=False)

 def test_lambda_codomain_selection_does_not_hide_operator_input_ambiguity(self):
  self.indexed_lambda_overloads()
  notation('Notation conflicting indexed sum(k: Natural,z: Real): Vector((k+2),Complex):',
           ['Means: fun _ => 0','Infix: +','Render latex: {k}+{z}'],self.env)
  with self.assertRaises(Ambiguous):
   complete(expression_tree(parse('(function(k: Natural,k+0))(n)','expression')),
            self.env,self.scope,self.env.type('Vector(n,Complex)',self.scope),use_default=False)
 def test_module_context_selects_direct_lambda_family(self):
  self.indexed_lambda_overloads()
  notation('Notation consume indexed(n: Natural,v: Vector(n,Complex)): Real:',
           ['Means: 0','Render latex: c({n},{v})'],self.env)
  value=complete(expression_tree(parse('consume indexed(n,(function(k: Natural,k+0))(n))','expression')),
                 self.env,self.scope,use_default=False)
  self.assertEqual(value.type,self.env.type('Real'))
  self.assertIn(self.env.data['functions']['indexed sum']['native_binding'],value.lean)

 def test_scalar_fragment_matches_independent_flat_exhaustive_oracle(self):
  from test_numeral_pruning import exhaustive
  from cleanlang.numeral_inference import holes
  env=Environment();load_module(ROOT/'library/operators.clean',env);del env.numeral_default
  scope={n:Expr(n,n,env.type(t),tree=['Local',n]) for n,t in [('n','Natural'),('r','Real')]}
  sources=[f'({a})+({b})' for a in ['n','r','1','n+1','r+1'] for b in ['n','r','2','n+2','r+2']]
  sources+=['-(r+1)','(function(x: Natural,x+1))(2)','for every(x: Natural,x+1=x+1)','there exists(x: Real,x=1)']
  for source in sources:
   with self.subTest(source=source):
    tree=expression_tree(parse(source,'expression'));expected=exhaustive(tree,env,scope)
    if len(expected)==1:
     actual=complete(tree,env,scope,use_default=False)
     self.assertEqual((actual.lean,actual.type),(expected[0].lean,expected[0].type))
    else:
     with self.assertRaises(Ambiguous if expected else NoSolution if holes(tree) else CleanError):complete(tree,env,scope,use_default=False)

 def test_expected_result_constrains_direct_lambda_body(self):
  tree=expression_tree(parse('(function(x: Natural,0))(2)','expression'))
  with patch('cleanlang.joint_inference.clean_rows.Builder.solve_with_trace',side_effect=AssertionError('inner selection')):
   value=complete(tree,self.env,self.scope,self.env.type('Real'),use_default=False)
  self.assertEqual(value.tree[1][3][2],'Real')
  self.assertEqual(value.tree[2][0][2],'Natural')
 def test_indexed_result_does_not_force_a_constant_lambda_codomain(self):
  expected=self.env.type('Vector(n,Complex)',self.scope)
  with self.assertRaises(Incomplete):
   complete(expression_tree(parse('(function(x: Natural,0))(2)','expression')),self.env,self.scope,expected,use_default=False)
 def test_module_argument_supplies_direct_lambda_result(self):
  notation('Notation real consumer(x: Real): Real:', ['Means: x','Render latex: c({x})'],self.env)
  value=complete(expression_tree(parse('real consumer((function(x: Natural,0))(2))','expression')),self.env,self.scope,use_default=False)
  self.assertEqual(value.tree[2][0][1][3][2],'Real')
 def test_expected_result_does_not_resolve_operator_input_ambiguity(self):
  notation('Notation other sum(x: Natural,y: Natural): Real:', ['Means: 0','Infix: +','Render latex: {x}+{y}'],self.env)
  with self.assertRaises(Ambiguous):
   complete(expression_tree(parse('(function(x: Natural,x+1))(2)','expression')),self.env,self.scope,self.env.type('Natural'))

 def test_indexed_expectation_still_allows_independently_determined_codomain(self):
  typ=self.env.type('Vector(n,Complex)',self.scope)
  self.scope['v']=Expr('v','v',typ,tree=['Local','v'])
  notation('Notation keep vector(n: Natural,v: Vector(n,Complex),z: Real): Vector(n,Complex):', ['Means: v','Render latex: k({n},{v},{z})'],self.env)
  value=complete(expression_tree(parse('(function(x: Natural,keep vector(n,v,0)))(2)','expression')),self.env,self.scope,typ,use_default=False)
  self.assertEqual(value.type,typ)


 def test_direct_dependent_lambda_uses_checked_argument(self):
  notation('Notation indexed zero(k: Natural,z: Real): Vector(k,Complex):', ['Means: fun _ => 0','Render latex: z({k},{z})'],self.env)
  tree=expression_tree(parse('(function(k: Natural,indexed zero(k,0)))(n)','expression'))
  with patch('cleanlang.joint_inference.clean_rows.Builder.solve_with_trace',side_effect=AssertionError('inner selection')):
   value=complete(tree,self.env,self.scope,use_default=False)
  self.assertEqual(value.type,self.env.type('Vector(n,Complex)',self.scope))
  self.assertEqual(value.tree[1][0],'Lambda')
  self.assertEqual(Expressions(self.env,self.scope).elaborate(value.tree).lean,value.lean)

 def test_direct_dependent_lambda_preserves_computed_family(self):
  notation('Notation shifted zero(k: Natural,z: Real): Vector((k+1),Complex):', ['Means: fun _ => 0','Render latex: z({k},{z})'],self.env)
  values=[]
  for name in ('k','j'):
   source=f'(function({name}: Natural,shifted zero({name},0)))(n)'
   values.append(complete(expression_tree(parse(source,'expression')),self.env,self.scope,use_default=False))
  self.assertEqual(values[0].type,self.env.type('Vector((n+1),Complex)',self.scope))
  self.assertEqual(values[0].type,values[1].type)
  self.assertEqual(values[0].lean,values[1].lean)

 def test_direct_dependent_lambda_uses_enumerated_argument(self):
  notation('Notation indexed zero(k: Natural,z: Real): Vector(k,Complex):', ['Means: fun _ => 0','Render latex: z({k},{z})'],self.env)
  with patch('cleanlang.joint_inference.clean_rows.Builder.solve_with_trace',side_effect=AssertionError('inner selection')):
   value=complete(expression_tree(parse('(function(k: Natural,indexed zero(k,0)))(2)','expression')),self.env,self.scope,use_default=False)
  self.assertEqual(value.type,self.env.type('Vector(2,Complex)',self.scope))
  self.assertEqual(value.tree[2][0][2],'Natural')
  self.assertEqual(Expressions(self.env,self.scope).elaborate(value.tree).lean,value.lean)

 def test_scoped_module_later_argument_uses_literal_dimension(self):
  notation('Notation evaluate vector(k: Natural,f: Function(Real,Vector(k,Complex))): Vector(k,Complex):', ['Means: f 0','Render latex: e({k},{f})'],self.env)
  for dimension in ['2','2+1']:
   with self.subTest(dimension=dimension):
    source=f'evaluate vector({dimension},function(x: Real,0))'
    if dimension=='2':
     self.assertEqual(expression_tree(parse(source,'expression')),
      ['Call','evaluate vector',[['Decimal','2'],['Lambda','x','Real',['Decimal','0']]]])
    with patch('cleanlang.joint_inference.clean_rows.Builder.solve_with_trace',side_effect=AssertionError('inner selection')):
     value=complete(expression_tree(parse(source,'expression')),self.env,self.scope,use_default=False)
    self.assertEqual(value.type,self.env.type(f'Vector(({dimension}),Complex)',self.scope))
    self.assertEqual(value.tree[2][1][3][3],'complex vector zero')
    self.assertEqual(Expressions(self.env,self.scope).elaborate(value.tree).lean,value.lean)

 def test_dependent_scoped_prefix_checks_wrong_later_domain(self):
  notation('Notation evaluate vector(k: Natural,f: Function(Real,Vector(k,Complex))): Vector(k,Complex):', ['Means: f 0','Render latex: e({k},{f})'],self.env)
  with self.assertRaises(NoSolution):
   complete(expression_tree(parse('evaluate vector(2,function(x: Complex,0))','expression')),self.env,self.scope,use_default=False)

 def test_dependent_scoped_prefix_checks_result_expectation(self):
  notation('Notation indexed zero(k: Natural,z: Real): Vector(k,Complex):', ['Means: fun _ => 0','Render latex: z({k},{z})'],self.env)
  tree=expression_tree(parse('(function(k: Natural,indexed zero(k,0)))(2)','expression'))
  with self.assertRaises(NoSolution):
   complete(tree,self.env,self.scope,self.env.type('Vector(3,Complex)',self.scope),use_default=False)

 def test_dependent_scoped_prefix_retains_competing_same_carrier_literals(self):
  notation('Notation another two(): Natural:', ['Means: 2','Literal: 2','Render latex: two'],self.env)
  notation('Notation indexed zero(k: Natural,z: Real): Vector(k,Complex):', ['Means: fun _ => 0','Render latex: z({k},{z})'],self.env)
  tree=expression_tree(parse('(function(k: Natural,indexed zero(k,0)))(2)','expression'))
  for use_default in [True,False]:
   with self.subTest(use_default=use_default),self.assertRaises(Ambiguous):
    complete(tree,self.env,self.scope,use_default=use_default)

 def test_dependent_scoped_result_selects_across_all_prefix_rows(self):
  from cleanlang.joint_inference import scoped_calls
  notation('Notation another two(): Natural:', ['Means: 2','Literal: 2','Render latex: two'],self.env)
  notation('Notation indexed zero(k: Natural,z: Real): Vector(k,Complex):', ['Means: fun _ => 0','Render latex: z({k},{z})'],self.env)
  tree=expression_tree(parse('(function(k: Natural,indexed zero(k,0)))(2)','expression'))
  expected=self.env.type('Vector(2,Complex)',self.scope)
  original=scoped_calls.prepare_expression
  def reversed_rows(*args,**kwargs):
   rows,retain=original(*args,**kwargs)
   return tuple(reversed(rows)),retain
  value=complete(tree,self.env,self.scope,expected,use_default=False)
  with patch.object(scoped_calls,'prepare_expression',side_effect=reversed_rows):
   reordered=complete(tree,self.env,self.scope,expected,use_default=False)
  self.assertEqual(value.tree[2][0][:3],['BoundNumeral','2','Natural'])
  self.assertEqual((value.type,value.lean),(reordered.type,reordered.lean))

 def test_dependent_scoped_incomplete_competitor_is_not_discarded(self):
  from cleanlang.joint_inference import scoped_calls
  notation('Notation another two(): Natural:', ['Means: 2','Literal: 2','Render latex: two'],self.env)
  notation('Notation indexed zero(k: Natural,z: Real): Vector(k,Complex):', ['Means: fun _ => 0','Render latex: z({k},{z})'],self.env)
  tree=expression_tree(parse('(function(k: Natural,indexed zero(k,0)))(2)','expression'))
  expected=self.env.type('Vector(2,Complex)',self.scope)
  original=scoped_calls.checked_prefix_value
  def unavailable(builder,parts):
   value=original(builder,parts)
   if value.tree[0]=='BoundLiteral':raise Incomplete('unavailable competitor')
   return value
  with patch.object(scoped_calls,'checked_prefix_value',side_effect=unavailable):
   with self.assertRaisesRegex(Incomplete,'unavailable competitor'):
    complete(tree,self.env,self.scope,expected,use_default=False)

 def test_dependent_scoped_prefix_preserves_global_default_origins(self):
  load_module(ROOT/'library/logic/evidence.clean',self.env)
  notation('Notation carry(p: Proposition,f: Function(Real,Real)): Evidence((p → p)):', ['Means: fun h => h','Render latex: c({p},{f})'],self.env)
  tree=expression_tree(parse('carry(for every(x: Real,1=1),function(y: Real,0))','expression'))
  with self.assertRaises(Ambiguous):complete(tree,self.env,{},use_default=False)
  value=complete(tree,self.env,{})
  for node in [value.tree[2][0][3][2],value.tree[2][0][3][3]]:
   self.assertEqual((node[2],node[-1]),('Natural','defaulted'))
  self.assertEqual((value.tree[2][1][3][2],value.tree[2][1][3][-1]),('Real','inferred'))
  self.assertEqual(Expressions(self.env,{}).elaborate(value.tree).lean,value.lean)

 def test_dependent_scoped_application_head_retains_instantiated_family(self):
  notation('Notation vector maker(k: Natural,f: Function(Real,Real)): Function(Real,Vector(k,Complex)):', ['Means: fun _ _ => 0','Render latex: v({k},{f})'],self.env)
  source='vector maker(2,function(x: Real,0))(0)'
  value=complete(expression_tree(parse(source,'expression')),self.env,self.scope,use_default=False)
  self.assertEqual(value.type,self.env.type('Vector(2,Complex)',self.scope))
  self.assertEqual(value.tree[2][0][2],'Real')
  self.assertEqual(Expressions(self.env,self.scope).elaborate(value.tree).lean,value.lean)

 def test_dependent_scoped_prefix_resource_exhaustion_is_incomplete(self):
  notation('Notation indexed zero(k: Natural,z: Real): Vector(k,Complex):', ['Means: fun _ => 0','Render latex: z({k},{z})'],self.env)
  with self.assertRaises(Incomplete):
   complete(expression_tree(parse('(function(k: Natural,indexed zero(k,0)))(2)','expression')),self.env,self.scope,limit=1)

 def shadowed_consumer(self,local_type):
  load_module(ROOT/'library/logic/evidence.clean',self.env)
  notation('Notation h(g: Function(Real,Real)): Real:', ['Means: g 0','Render latex: h({g})'],self.env)
  self.scope['h']=Expr('h','h',self.env.type(local_type,self.scope),tree=['Local','h'])

 def test_scoped_noncallable_local_preserves_module_resolution(self):
  for local_type in ['Real','Evidence((n=n))']:
   with self.subTest(local_type=local_type):
    self.setUp();self.shadowed_consumer(local_type)
    source='h(function(x: Real,0))'
    tree=expression_tree(parse(source,'expression'))
    self.assertEqual(tree,['Call','h',[['Lambda','x','Real',['Decimal','0']]]])
    value=complete(tree,self.env,self.scope,use_default=False)
    explicit=Expressions(self.env,self.scope).parse('h(function(x: Real,(0: Real)))')
    self.assertEqual((value.type,value.lean),(explicit.type,explicit.lean))
    self.assertIn(self.env.data['functions']['h']['native_binding'],value.lean)

 def test_scoped_callable_local_preserves_precedence(self):
  for local_type in ['Function(Function(Real,Real),Real)',
                     'Evidence((for every(g: Function(Real,Real),n=n)))']:
   with self.subTest(local_type=local_type):
    self.setUp();self.shadowed_consumer(local_type)
    value=complete(expression_tree(parse('h(function(x: Real,0))','expression')),self.env,self.scope,use_default=False)
    explicit=Expressions(self.env,self.scope).parse('h(function(x: Real,(0: Real)))')
    self.assertEqual((value.type,value.lean),(explicit.type,explicit.lean))
    self.assertTrue(value.lean.startswith('(h '))
    self.assertNotIn(self.env.data['functions']['h']['native_binding'],value.lean)

 def test_scoped_callable_local_mismatch_never_retries_module(self):
  self.shadowed_consumer('Function(Function(Complex,Complex),Real)')
  with self.assertRaises(NoSolution):
   complete(expression_tree(parse('h(function(x: Real,0))','expression')),self.env,self.scope,use_default=False)

 def test_scoped_callable_local_arity_error_never_retries_module(self):
  notation('Notation acceptor(f: Function(Real,Real),g: Function(Real,Real)): Real:', ['Means: f 0','Render latex: a({f},{g})'],self.env)
  self.scope['acceptor']=Expr('acceptor','acceptor',self.env.type('Function(Function(Real,Real),Real)'),tree=['Local','acceptor'])
  with self.assertRaises(NoSolution):
   complete(expression_tree(parse('acceptor(function(x: Real,0),function(y: Real,0))','expression')),self.env,self.scope,use_default=False)

 def test_scoped_explicit_application_does_not_use_module_fallback(self):
  self.shadowed_consumer('Real')
  source='h(function(x: Real,0))(function(y: Real,0))'
  tree=expression_tree(parse(source,'expression'))
  self.assertEqual(tree,['Apply',['Call','h',[['Lambda','x','Real',['Decimal','0']]]],
                         [['Lambda','y','Real',['Decimal','0']]]])
  with self.assertRaises(NoSolution):complete(tree,self.env,self.scope,use_default=False)

 def test_scoped_grouped_name_preserves_bare_call_resolution(self):
  self.shadowed_consumer('Evidence((n=n))')
  expected=['Call','h',[['Lambda','x','Real',['Decimal','0']]]]
  values=[]
  for source in ['h(function(x: Real,0))','(h)(function(x: Real,0))']:
   tree=expression_tree(parse(source,'expression'))
   self.assertEqual(tree,expected)
   values.append(complete(tree,self.env,self.scope,use_default=False))
  self.assertEqual((values[0].type,values[0].lean),(values[1].type,values[1].lean))

 def test_scoped_noncallable_without_module_is_not_callable(self):
  self.scope['h']=Expr('h','h',self.env.type('Real'),tree=['Local','h'])
  with self.assertRaises(NoSolution):
   complete(expression_tree(parse('h(function(x: Real,0))','expression')),self.env,self.scope,use_default=False)

 def test_direct_dependent_lambda_checks_result_expectation(self):
  notation('Notation indexed zero(k: Natural,z: Real): Vector(k,Complex):', ['Means: fun _ => 0','Render latex: z({k},{z})'],self.env)
  tree=expression_tree(parse('(function(k: Natural,indexed zero(k,0)))(n)','expression'))
  with self.assertRaises(NoSolution):complete(tree,self.env,self.scope,self.env.type('Real'),use_default=False)


 def test_checked_evidence_argument_with_joint_literal(self):
  load_module(ROOT/'library/logic/evidence.clean',self.env)
  typ=self.env.type('Evidence((n=n))',self.scope)
  self.scope['h']=Expr('h','h',typ,tree=['Local','h'])
  notation('Notation keep evidence(n: Natural,h: Evidence((n=n)),z: Real): Natural:', ['Means: n','Render latex: k({n},{h},{z})'],self.env)
  value=complete(expression_tree(parse('keep evidence(n,h,0)','expression')),self.env,self.scope,use_default=False)
  self.assertEqual(value.type,self.env.type('Natural'))
  self.assertEqual(value.tree[2][2][2],'Real')

 def test_dependent_evidence_result_uses_forward_substitution(self):
  load_module(ROOT/'library/logic/evidence.clean',self.env)
  notation('Notation self equality(n: Natural): Evidence((n=n)):', ['Means: rfl','Render latex: e({n})'],self.env)
  value=complete(expression_tree(parse('self equality(n+1)','expression')),self.env,self.scope,use_default=False)
  self.assertEqual(value.type,self.env.type('Evidence(((n+1)=(n+1)))',self.scope))
  self.assertEqual(Expressions(self.env,self.scope).elaborate(value.tree).lean,value.lean)

 def test_proof_type_mismatch_is_not_proof_search(self):
  load_module(ROOT/'library/logic/evidence.clean',self.env)
  notation('Notation self equality(n: Natural): Evidence((n=n)):', ['Means: rfl','Render latex: e({n})'],self.env)
  with self.assertRaises(NoSolution):
   complete(expression_tree(parse('self equality(n+1)','expression')),self.env,self.scope,self.env.type('Evidence((n!=n))',self.scope),use_default=False)

 def test_proof_carrier_retains_lexical_dependency(self):
  load_module(ROOT/'library/logic/evidence.clean',self.env)
  from cleanlang.joint_inference.clean_rows import Builder
  owner=('binder',(7,))
  builder=Builder(self.env,self.scope,binder_ids={'n':owner})
  typ=self.env.type('Evidence((n=n))',self.scope)
  self.assertEqual(builder.dependencies(typ,normalize=False),frozenset({owner}))
  self.assertFalse(builder.witness_available(typ,frozenset()))

 def test_proof_carrier_under_quantified_binder(self):
  load_module(ROOT/'library/logic/evidence.clean',self.env)
  notation('Notation self equality(n: Natural): Evidence((n=n)):', ['Means: rfl','Render latex: e({n})'],self.env)
  notation('Notation keep evidence(n: Natural,h: Evidence((n=n)),z: Real): Natural:', ['Means: n','Render latex: k({n},{h},{z})'],self.env)
  value=complete(expression_tree(parse('for every(k: Natural,keep evidence(k,self equality(k),0)=k)','expression')),self.env,self.scope,use_default=False)
  self.assertEqual(value.type,self.env.type('Proposition'))

 def test_evidence_is_not_silently_an_inferred_type_zero_carrier(self):
  load_module(ROOT/'library/logic/evidence.clean',self.env)
  self.scope['h']=Expr('h','h',self.env.type('Evidence((n=n))',self.scope),tree=['Local','h'])
  notation('Notation value consumer(x,z):', ['Let T: Type','Let x: T','Let z: Real','Returns: Real','Means: z','Render latex: c({x},{z})'],self.env)
  with self.assertRaises(Incomplete):
   complete(expression_tree(parse('value consumer(h,0)','expression')),self.env,self.scope,use_default=False)

 def test_scoped_set_builder_recovers_implicit_domain_without_selection(self):
  load_module(ROOT/'library/topology/basic.clean',self.env)
  with patch('cleanlang.joint_inference.clean_rows.Builder.solve_with_trace',side_effect=AssertionError('independent child selection')):
   value=complete(expression_tree(parse('set of(function(x: Real,x=0))','expression')),self.env,self.scope,use_default=False)
  self.assertEqual(value.type,self.env.type('Set(Real)'))
  self.assertEqual(dict(value.inferred_args)['X'],self.env.type('Real'))

 def test_scoped_implicit_recovers_from_checked_sibling(self):
  notation('Notation consume sibling(f,x):', ['Let T: Type','Let f: Function(Natural,T)','Let x: T','Returns: T','Means: x','Render latex: c({f},{x})'],self.env)
  self.scope['r']=Expr('r','r',self.env.type('Real'),tree=['Local','r'])
  value=complete(expression_tree(parse('consume sibling(function(k: Natural,0),r)','expression')),self.env,self.scope,use_default=False)
  self.assertEqual(value.tree[2][0][3][2],'Real')

 def test_scoped_implicit_conflicting_domains_are_not_first_success(self):
  notation('Notation consume both(f,g):', ['Let T: Type','Let f,g: Function(T,Real)','Returns: Real','Means: 0','Render latex: c({f},{g})'],self.env)
  for domains in [('Real','Complex'),('Complex','Real')]:
   source=f'consume both(function(x: {domains[0]},0),function(y: {domains[1]},0))'
   with self.assertRaises(NoSolution):complete(expression_tree(parse(source,'expression')),self.env,self.scope,use_default=False)

 def test_scoped_implicit_dimension_comes_from_checked_lambda_domain(self):
  notation('Notation consume vector(f):', ['Let k: Natural','Let f: Function(Vector(k,Complex),Real)','Returns: Natural','Means: k','Render latex: c({f})'],self.env)
  value=complete(expression_tree(parse('consume vector(function(v: Vector(n,Complex),0))','expression')),self.env,self.scope,use_default=False)
  self.assertEqual(value.type,self.env.type('Natural'))
  self.assertEqual(value.tree[2][0][3][2],'Real')

 def test_scoped_implicit_does_not_guess_codomain_from_unresolved_body(self):
  notation('Notation hidden result(f):', ['Let T: Type','Let f: Function(Natural,T)','Returns: Real','Means: 0','Render latex: c({f})'],self.env)
  with self.assertRaises(Incomplete):
   complete(expression_tree(parse('hidden result(function(k: Natural,0))','expression')),self.env,self.scope,self.env.type('Real'))

 def test_scoped_implicit_keeps_body_operator_ambiguity(self):
  load_module(ROOT/'library/topology/basic.clean',self.env)
  notation('Notation other sum(x: Real,y: Real): Real:', ['Means: x+y','Infix: +','Render latex: {x}+{y}'],self.env)
  with self.assertRaises(Ambiguous):
   complete(expression_tree(parse('set of(function(x: Real,x+0=x))','expression')),self.env,self.scope,use_default=False)

 def test_scoped_implicit_unrepresentable_evidence_is_incomplete(self):
  load_module(ROOT/'library/topology/basic.clean',self.env)
  with patch('cleanlang.inferred_conversion.reify',side_effect=CleanError('unavailable witness')):
   with self.assertRaisesRegex(Incomplete,'Scoped implicit representative cannot be rechecked'):
    complete(expression_tree(parse('set of(function(x: Real,x=0))','expression')),self.env,self.scope,use_default=False)

 def test_scoped_local_evidence_uses_callable_view_without_child_selection(self):
  load_module(ROOT/'library/logic/evidence.clean',self.env)
  self.scope['h']=Expr('h','h',self.env.type('Evidence((for every(f: Function(Real,Real),n=n)))',self.scope),tree=['Local','h'])
  with patch('cleanlang.joint_inference.clean_rows.Builder.solve_with_trace',side_effect=AssertionError('independent child selection')):
   value=complete(expression_tree(parse('h(function(x: Real,0))','expression')),self.env,self.scope,use_default=False)
  self.assertEqual(value.type,self.env.type('Evidence((n=n))',self.scope))
  self.assertEqual(value.tree[2][0][3][2],'Real')
  self.assertTrue(value.lean.startswith('(h '))

 def test_scoped_evidence_application_head_can_return_an_implication(self):
  load_module(ROOT/'library/logic/evidence.clean',self.env)
  self.scope['h']=Expr('h','h',self.env.type('Evidence((for every(f: Function(Real,Real),(n=n) → (n=n))))',self.scope),tree=['Local','h'])
  self.scope['q']=Expr('q','q',self.env.type('Evidence((n=n))',self.scope),tree=['Local','q'])
  value=complete(expression_tree(parse('h(function(x: Real,0))(q)','expression')),self.env,self.scope,use_default=False)
  self.assertEqual(value.type,self.scope['q'].type)
  self.assertTrue(value.lean.startswith('((h '))

 def test_scoped_evidence_dependent_on_enumerated_lambda(self):
  load_module(ROOT/'library/logic/evidence.clean',self.env)
  self.scope['r']=Expr('r','r',self.env.type('Real'),tree=['Local','r'])
  self.scope['h']=Expr('h','h',self.env.type('Evidence((for every(f: Function(Real,Real),f(r)=f(r))))',self.scope),tree=['Local','h'])
  with patch('cleanlang.joint_inference.clean_rows.Builder.solve_with_trace',side_effect=AssertionError('inner selection')):
   value=complete(expression_tree(parse('h(function(x: Real,0))','expression')),self.env,self.scope,use_default=False)
  explicit=Expressions(self.env,self.scope).parse('h(function(x: Real,(0: Real)))')
  self.assertEqual((value.type,value.lean),(explicit.type,explicit.lean))

 def test_scoped_evidence_does_not_hide_body_operator_ambiguity(self):
  load_module(ROOT/'library/logic/evidence.clean',self.env)
  self.scope['h']=Expr('h','h',self.env.type('Evidence((for every(f: Function(Real,Real),n=n)))',self.scope),tree=['Local','h'])
  notation('Notation another sum(x: Real,y: Real): Real:', ['Means: x+y','Infix: +','Render latex: {x}+{y}'],self.env)
  with self.assertRaises(Ambiguous):
   complete(expression_tree(parse('h(function(x: Real,x+0))','expression')),self.env,self.scope,use_default=False)

if __name__=='__main__':unittest.main()

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md

# generated: gpt-6 2026-11-11 role=assisted
class ScopedProofLambdas(unittest.TestCase):
 def setUp(self):
  self.env=Environment();load_module(ROOT/'library/linear_algebra.clean',self.env)
  load_module(ROOT/'library/logic/evidence.clean',self.env)
  self.scope={'n':Expr('n','n',self.env.type('Natural'),tree=['Local','n'])}
  self.scope['h']=Expr('h','h',self.env.type('Evidence((n=n))',self.scope),tree=['Local','h'])
  notation('Notation proof with scalar(n: Natural,h: Evidence((n=n)),z: Real): Evidence((n=n)):', ['Means: h','Render latex: p({n},{h},{z})'],self.env)
  notation('Notation use universal(n: Natural,h: Evidence((for every(x: Real,n=n)))): Natural:', ['Means: n','Render latex: u({n},{h})'],self.env)
 def test_direct_lambda_against_universal_evidence(self):
  from cleanlang.proof_types import compatible_evidence
  expected=self.env.type('Evidence((for every(x: Real,n=n)))',self.scope)
  value=complete(expression_tree(parse('function(x: Real,proof with scalar(n,h,0))','expression')),self.env,self.scope,expected,use_default=False)
  self.assertTrue(compatible_evidence(value.type,expected,self.env,self.scope))
  self.assertEqual(value.tree[3][2][2][2],'Real')
  self.assertEqual(value.lean,Expressions(self.env,self.scope).elaborate(value.tree).lean)
 def test_nested_lambda_consumed_as_universal_evidence(self):
  value=complete(expression_tree(parse('use universal(n,function(y: Real,proof with scalar(n,h,0)))','expression')),self.env,self.scope,use_default=False)
  self.assertEqual(value.type,self.env.type('Natural'))
  self.assertEqual(value.lean,Expressions(self.env,self.scope).elaborate(value.tree).lean)
 def test_wrong_domain_rejected(self):
  expected=self.env.type('Evidence((for every(x: Real,n=n)))',self.scope)
  with self.assertRaises(NoSolution):
   complete(expression_tree(parse('function(x: Complex,proof with scalar(n,h,0))','expression')),self.env,self.scope,expected,use_default=False)
 def test_wrong_proof_body_rejected(self):
  expected=self.env.type('Evidence((for every(x: Real,n!=n)))',self.scope)
  with self.assertRaises(NoSolution):
   complete(expression_tree(parse('function(x: Real,proof with scalar(n,h,0))','expression')),self.env,self.scope,expected,use_default=False)
 def test_noncallable_evidence_rejected(self):
  with self.assertRaises(NoSolution):
   complete(expression_tree(parse('function(x: Real,proof with scalar(n,h,0))','expression')),self.env,self.scope,self.scope['h'].type,use_default=False)
 def test_dependent_universal_body_uses_lambda_binder(self):
  from cleanlang.proof_types import compatible_evidence
  notation('Notation self equality(k: Natural): Evidence((k=k)):', ['Means: rfl','Render latex: e({k})'],self.env)
  expected=self.env.type('Evidence((for every(k: Natural,k=k)))',self.scope)
  value=complete(expression_tree(parse('function(j: Natural,proof with scalar(j,self equality(j),0))','expression')),self.env,self.scope,expected,use_default=False)
  self.assertTrue(compatible_evidence(value.type,expected,self.env,self.scope))
  self.assertEqual(value.lean,Expressions(self.env,self.scope).elaborate(value.tree).lean)
 def test_implication_lambda_uses_supplied_evidence(self):
  from cleanlang.proof_types import compatible_evidence
  expected=self.env.type('Evidence(((n=n) → (n=n)))',self.scope)
  value=complete(expression_tree(parse('function(q: Evidence((n=n)),proof with scalar(n,q,0))','expression')),self.env,self.scope,expected,use_default=False)
  self.assertTrue(compatible_evidence(value.type,expected,self.env,self.scope))
  self.assertEqual(value.lean,Expressions(self.env,self.scope).elaborate(value.tree).lean)

# generated: gpt-6 2026-11-11 role=assisted
class ScopedProofImplicitDomains(unittest.TestCase):
 setUp=ScopedProofLambdas.setUp
 def declare(self,header,fields):
  notation(header,fields,self.env)
 def test_implicit_carrier_from_universal_lambda_domain(self):
  self.declare('Notation implicit universal(n,p):',['Let T: Type','Let n: Natural','Let p: Evidence((for every(x: T,n=n)))','Returns: Natural','Means: n','Render latex: u({n},{p})'])
  value=complete(expression_tree(parse('implicit universal(n,function(y: Real,proof with scalar(n,h,0)))','expression')),self.env,self.scope,use_default=False)
  self.assertEqual(dict(value.inferred_args)['T'],self.env.type('Real'))
  self.assertEqual(value.lean,Expressions(self.env,self.scope).elaborate(value.tree).lean)
 def test_implicit_dimension_from_universal_lambda_domain(self):
  self.declare('Notation indexed universal(p):',['Let m: Natural','Let p: Evidence((for every(x: Vector(m,Complex),m=m)))','Returns: Natural','Means: m','Render latex: u({p})'])
  value=complete(expression_tree(parse('indexed universal(function(y: Vector(n,Complex),proof with scalar(n,h,0)))','expression')),self.env,self.scope,use_default=False)
  self.assertEqual(value.type,self.env.type('Natural'))
  self.assertEqual(value.lean,Expressions(self.env,self.scope).elaborate(value.tree).lean)
  self.assertIn('m',dict(value.inferred_args))
 def test_conflicting_domains_reject_in_either_order(self):
  self.declare('Notation two universals(n,p,q):',['Let T: Type','Let n: Natural','Let p,q: Evidence((for every(x: T,n=n)))','Returns: Natural','Means: n','Render latex: u({n},{p},{q})'])
  for first,second in [('Real','Complex'),('Complex','Real')]:
   with self.subTest(first=first),self.assertRaises(NoSolution):
    complete(expression_tree(parse(f'two universals(n,function(a: {first},proof with scalar(n,h,0)),function(b: {second},proof with scalar(n,h,0)))','expression')),self.env,self.scope,use_default=False)
 def test_body_only_carrier_remains_incomplete(self):
  self.declare('Notation body universal(n,p):',['Let T: Type','Let n: Natural','Let p: Evidence((for every(x: Real,for every(y: T,n=n))))','Returns: Natural','Means: n','Render latex: u({n},{p})'])
  tree=expression_tree(parse('body universal(n,function(a: Real,function(b: Complex,proof with scalar(n,h,0))))','expression'))
  for default in [False,True]:
   with self.subTest(default=default),self.assertRaises(Incomplete):
    complete(tree,self.env,self.scope,self.env.type('Natural'),use_default=default)
 def test_recovered_domain_does_not_accept_wrong_proof(self):
  self.declare('Notation impossible universal(n,p):',['Let T: Type','Let n: Natural','Let p: Evidence((for every(x: T,n!=n)))','Returns: Natural','Means: n','Render latex: u({n},{p})'])
  with self.assertRaises(NoSolution):
   complete(expression_tree(parse('impossible universal(n,function(y: Real,proof with scalar(n,h,0)))','expression')),self.env,self.scope,use_default=False)
