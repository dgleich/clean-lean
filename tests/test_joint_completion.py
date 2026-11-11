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

 def test_direct_dependent_lambda_unknown_argument_remains_incomplete(self):
  notation('Notation indexed zero(k: Natural,z: Real): Vector(k,Complex):', ['Means: fun _ => 0','Render latex: z({k},{z})'],self.env)
  with self.assertRaises(Incomplete):
   complete(expression_tree(parse('(function(k: Natural,indexed zero(k,0)))(2)','expression')),self.env,self.scope,use_default=False)

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

 def test_scoped_evidence_dependent_on_selected_lambda_remains_incomplete(self):
  load_module(ROOT/'library/logic/evidence.clean',self.env)
  self.scope['r']=Expr('r','r',self.env.type('Real'),tree=['Local','r'])
  self.scope['h']=Expr('h','h',self.env.type('Evidence((for every(f: Function(Real,Real),f(r)=f(r))))',self.scope),tree=['Local','h'])
  with self.assertRaisesRegex(Incomplete,'unresolved selected value'):
   complete(expression_tree(parse('h(function(x: Real,0))','expression')),self.env,self.scope,use_default=False)

 def test_scoped_evidence_does_not_hide_body_operator_ambiguity(self):
  load_module(ROOT/'library/logic/evidence.clean',self.env)
  self.scope['h']=Expr('h','h',self.env.type('Evidence((for every(f: Function(Real,Real),n=n)))',self.scope),tree=['Local','h'])
  notation('Notation another sum(x: Real,y: Real): Real:', ['Means: x+y','Infix: +','Render latex: {x}+{y}'],self.env)
  with self.assertRaises(Ambiguous):
   complete(expression_tree(parse('h(function(x: Real,x+0))','expression')),self.env,self.scope,use_default=False)

if __name__=='__main__':unittest.main()

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
