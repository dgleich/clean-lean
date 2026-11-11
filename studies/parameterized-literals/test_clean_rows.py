# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr
from cleanlang.modules import load_module,notation,type_declaration
from cleanlang.syntax import expression_tree,parse
from clean_rows import Builder
from constraint_model import Atom,Carrier,Ambiguous,Underdetermined,Incomplete,NoSolution

ROOT=Path(__file__).resolve().parents[2]
class CleanRows(unittest.TestCase):
 def setUp(self):
  self.e=Environment();load_module(ROOT/'library/linear_algebra.clean',self.e)
  self.scope={n:Expr(n,n,self.e.type('Natural'),tree=['Local',n]) for n in ('m','n')}
  for n,t in [('x','Vector(n,Complex)'),('A','Matrix(m,n,Real)'),('r','Real')]:
   self.scope[n]=Expr(n,n,self.e.type(t,self.scope),tree=['Local',n])
 def test_group_classifier_is_not_reparsed_sequentially(self):
  type_declaration('Type Small():',['Universe: 1','Classifies: 0','Means: Type','Render latex: S'],self.e)
  notation('Notation count types(Small,T):',
   ['Let Small,T: Small','Returns: Natural','Means: 0','Render latex: 0'],self.e)
  variables,_=Builder(self.e,{}).telescope(self.e.data['functions']['count types'],())
  self.assertEqual([(n,v.sort) for n,v in variables.items()],[('Small','type'),('T','type')])
 def test_missing_checked_signature_is_incomplete(self):
  del self.e.data['functions']['unequal']['checked_signature']
  with self.assertRaisesRegex(Incomplete,'Missing checked'):self.solve('x != 0')
 def test_constructor_telescope_uses_checked_descriptor(self):
  from cleanlang.structures import declare
  declare('Structure Cell(T: Type):',['Let entry: T','Constructor: cell'],self.e)
  variables,_=Builder(self.e,{}).telescope(self.e.data['functions']['cell'],())
  self.assertEqual([(n,v.sort) for n,v in variables.items()],[('T','type'),('entry','index')])
 def record(self):
  from cleanlang.structures import declare
  declare('Structure VectorCell(n: Natural):',
   ['Let entry: Vector(n,Complex)','Constructor: vector cell'],self.e)
 def test_scalar_constructor_constrains_zero(self):
  from cleanlang.structures import declare
  declare('Structure ScalarCell():',['Let entry: Real','Constructor: scalar cell'],self.e)
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('scalar cell(0)','expression')))
  self.assertEqual(value.type,self.e.type('ScalarCell'))
  self.assertEqual(value.tree[2][0][2],'Real')
 def test_constructor_recovers_dimension_without_vector_local(self):
  self.record();scope={'n':self.scope['n']}
  value=Builder(self.e,scope).materialize(expression_tree(parse('vector cell(n,0)','expression')))
  self.assertEqual(value.type,self.e.type('VectorCell(n)',scope))
  self.assertEqual(value.tree[2][1][5],[['n','explicit',['Local','n']]])
 def test_constructor_compares_normalized_index_but_retains_spelling(self):
  self.record()
  self.scope['k']=Expr('k','k',self.e.type('Natural'),tree=['Local','k'],
   local_normal=self.scope['n'],local_expand=True)
  target=self.e.type('VectorCell(n)',self.scope)
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('vector cell(k,0)','expression')),target)
  self.assertEqual(value.type,target)
  self.assertEqual(value.tree[2][1][5],[['n','explicit',['Local','k']]])
 def test_constructor_rejects_different_expected_dimension(self):
  self.record()
  with self.assertRaises(NoSolution):
   Builder(self.e,self.scope).solve(expression_tree(parse('vector cell(n,0)','expression')),
    self.e.type('VectorCell(m)',self.scope))
 def test_constructor_declaration_order_does_not_select_index_spelling(self):
  self.record();tree=expression_tree(parse('vector cell(n,0)','expression'))
  first=Builder(self.e,self.scope).materialize(tree)
  self.e.data['functions']=dict(reversed(list(self.e.data['functions'].items())))
  second=Builder(self.e,self.scope).materialize(tree)
  self.assertEqual(first.lean,second.lean)
 def test_literal_dimension_supplies_checked_zero_argument(self):
  self.record();tree=expression_tree(parse('vector cell(2,0)','expression'))
  value=Builder(self.e,{}).materialize(tree)
  self.assertEqual(value.type,self.e.type('VectorCell(2)'))
  dimension=value.tree[2][0]
  self.assertEqual(dimension[:3],['BoundNumeral','2','Natural'])
  self.assertEqual(dimension[4],'inferred')
  self.assertEqual(value.tree[2][1][5],[['n','explicit',dimension]])
 def test_annotated_dimension_and_inferred_dimension_have_same_target(self):
  self.record()
  values=[Builder(self.e,{}).materialize(expression_tree(parse(s,'expression')))
   for s in ['vector cell(2,0)','vector cell((2:Natural),0)']]
  self.assertEqual(values[0].lean,values[1].lean)
 def test_literal_dimension_is_context_forced_without_default(self):
  self.record();tree=expression_tree(parse('vector cell(2,0)','expression'))
  value=Builder(self.e,{}).materialize(tree,use_default=False)
  self.assertEqual(value.tree[2][0][4],'inferred')
  self.assertEqual(value.tree[2][1][7],'inferred')
 def test_literal_dimension_rejects_conflicting_expected_index(self):
  self.record()
  with self.assertRaises(NoSolution):
   Builder(self.e,{}).materialize(expression_tree(parse('vector cell(2,0)','expression')),
    self.e.type('VectorCell(3)'))
 def test_literal_dimension_replays_selected_native_arguments(self):
  from cleanlang.core import Expressions
  from cleanlang.retained_codec import dumps,loads
  self.record()
  value=Builder(self.e,{}).materialize(expression_tree(parse('vector cell(2,0)','expression')))
  from cleanlang.numerals import identity
  self.e.numeral_default=('Real',tuple(identity('Real',self.e)))
  replay=Expressions(self.e,{}).elaborate(loads(dumps(value.tree)))
  self.assertEqual(value.lean,replay.lean)
 def test_literal_dimension_enumeration_order_is_irrelevant(self):
  self.record();tree=expression_tree(parse('vector cell(2,0)','expression'))
  first=Builder(self.e,{}).materialize(tree)
  self.e.data['types']=dict(reversed(list(self.e.data['types'].items())))
  self.e.data['functions']=dict(reversed(list(self.e.data['functions'].items())))
  self.assertEqual(first.lean,Builder(self.e,{}).materialize(tree).lean)
 def solve(self,source,**kw):
  return Builder(self.e,self.scope).solve(expression_tree(parse(source,'expression')),**kw)
 def literal(self,result):return [key for kind,_,key in result[0] if kind=='literal']
 def test_operand_order_recovers_same_caller_dimension(self):
  left=self.solve('x != 0');right=self.solve('0 != x')
  key=self.e.data['functions']['complex vector zero']['native_binding']
  self.assertEqual(self.literal(left),[key]);self.assertEqual(self.literal(right),[key])
  self.assertEqual(left[1],right[1])
  expected=Carrier(self.e.data['types']['Vector']['native_binding'],
   (Atom(repr('n'),'index'),Carrier(self.e.data['types']['Complex']['native_binding'])))
  self.assertEqual(left[1][0],expected)
 def test_rectangular_recovery_keeps_both_dimensions(self):
  result=self.solve('A = 0')
  self.assertEqual(self.literal(result),[self.e.data['functions']['real matrix zero']['native_binding']])
  self.assertEqual(result[1][0].arguments[:2],(Atom(repr('m'),'index'),Atom(repr('n'),'index')))
 def test_named_call_uses_the_same_signature_constraints(self):
  self.assertEqual(self.solve('unequal(x,0)')[1],self.solve('x != 0')[1])
 def test_expected_carrier_determines_bare_zero(self):
  result=self.solve('0',expected=self.scope['x'].type)
  self.assertEqual(self.literal(result),[self.e.data['functions']['complex vector zero']['native_binding']])
 def test_unresolved_family_is_not_discarded(self):
  with self.assertRaises(Underdetermined):self.solve('0',use_default=False)
 def test_default_restricts_all_zeros_simultaneously(self):
  result=self.solve('0 = 0');native=self.e.data['types']['Natural']['numerals']['native_binding']
  self.assertEqual([key for kind,_,key in result[0] if kind=='numeral'],[native,native])
 def test_wrong_digit_has_no_vector_interpretation(self):
  with self.assertRaises(NoSolution):self.solve('x != 1')
 def test_equivalent_constructor_bodies_remain_ambiguous(self):
  notation('Notation another(n: Natural): Vector(n,Complex):',
   ['Means: fun _ => (0 : Complex)','Literal: 0','Render latex: 0'],self.e)
  with self.assertRaises(Ambiguous):self.solve('x != 0')
 def test_candidate_enumeration_order_does_not_choose_meaning(self):
  first=self.solve('x != 0')
  self.e.data['functions']=dict(reversed(list(self.e.data['functions'].items())))
  self.e.data['types']=dict(reversed(list(self.e.data['types'].items())))
  self.assertEqual(self.solve('x != 0'),first)
 def test_renamed_nominal_carrier_has_no_math_name_dispatch(self):
  type_declaration('Type Parcel(k: Natural):',['Means: Fin k → Complex','Render latex: P({k})'],self.e)
  notation('Notation blank(k: Natural): Parcel(k):',
   ['Means: fun _ => (0 : Complex)','Literal: 0','Render latex: 0'],self.e)
  self.scope['p']=Expr('p','p',self.e.type('Parcel(n)',self.scope),tree=['Local','p'])
  self.assertEqual(self.literal(self.solve('p != 0')),[self.e.data['functions']['blank']['native_binding']])
 def test_row_exhaustion_is_incomplete(self):
  tree=expression_tree(parse('x != 0','expression'))
  with self.assertRaises(Incomplete):Builder(self.e,self.scope,limit=1).solve(tree)
 def test_binder_region_is_explicitly_incomplete(self):
  with self.assertRaises(Incomplete):self.solve('function(t: Real,t+0)')
 def test_computed_formal_competitor_is_not_dropped(self):
  notation('Notation shifted(m: Natural): Matrix(m,(m+1),Complex):',
   ['Means: fun _ _ => (0 : Complex)','Literal: 0','Render latex: 0'],self.e)
  with self.assertRaises(Incomplete):self.solve('x != 0')
 def test_expected_result_does_not_resolve_operator_input_tie(self):
  notation('Notation alternative(x: Real,y: Real): Complex:',
   ['Means: 0','Infix: +','Render latex: {x}+{y}'],self.e)
  with self.assertRaises(Ambiguous):self.solve('r+0',expected=self.e.type('Real'))

 def test_materialized_vector_literal_retains_constructor_and_dimension(self):
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('x != 0','expression')))
  self.assertEqual(value.tree[3][0],'BoundLiteral')
  self.assertEqual(value.tree[3][3],'complex vector zero')
  self.assertEqual(value.tree[3][5][0][2],['Local','n'])
  self.assertEqual(value.tree[3][7],'inferred')
 def test_materialized_target_is_independent_of_candidate_order(self):
  tree=expression_tree(parse('0 != x','expression'))
  first=Builder(self.e,self.scope).materialize(tree)
  self.e.data['functions']=dict(reversed(list(self.e.data['functions'].items())))
  self.e.data['types']=dict(reversed(list(self.e.data['types'].items())))
  second=Builder(self.e,self.scope).materialize(tree)
  self.assertEqual(first.lean,second.lean)
  self.assertEqual(first.tree,second.tree)
 def test_materialization_does_not_hide_an_unresolved_default(self):
  with self.assertRaises(Underdetermined):Builder(self.e,self.scope).materialize(expression_tree(parse('0','expression')),use_default=False)
 def test_zero_times_vector_keeps_scalar_and_matrix_interpretations(self):
  with self.assertRaises(Ambiguous):self.solve('0*x = x')

 def test_default_origin_is_retained_and_visible(self):
  tree=expression_tree(parse('0','expression'))
  builder=Builder(self.e,self.scope);trace=builder.solve_with_trace(tree)
  self.assertEqual(trace.defaulted_positions,(0,))
  value=builder.materialize(tree)
  self.assertEqual(value.tree[4],'defaulted')
  self.assertIn(r'\mathbb{N}',value.tex)
 def test_simultaneous_defaults_are_both_retained(self):
  tree=expression_tree(parse('0 = 0','expression'))
  builder=Builder(self.e,self.scope);trace=builder.solve_with_trace(tree)
  self.assertEqual(trace.defaulted_positions,(0,1))
  value=builder.materialize(tree)
  self.assertEqual([value.tree[i][4] for i in (2,3)],['defaulted','defaulted'])
 def test_context_forced_numeral_is_not_marked_defaulted(self):
  tree=expression_tree(parse('r+0','expression'))
  builder=Builder(self.e,self.scope);trace=builder.solve_with_trace(tree)
  self.assertEqual(trace.defaulted_positions,());self.assertIsNone(trace.default_carrier)
  self.assertEqual(builder.materialize(tree).tree[3][4],'inferred')
 def test_expected_carrier_precedes_any_default(self):
  tree=expression_tree(parse('0','expression'));builder=Builder(self.e,self.scope)
  expected=self.e.type('Real');trace=builder.solve_with_trace(tree,expected)
  self.assertEqual(trace.defaulted_positions,())
  value=builder.materialize(tree,expected)
  self.assertEqual(value.type,expected);self.assertEqual(value.tree[4],'inferred')
 def test_annotated_literal_is_not_a_default_position(self):
  tree=expression_tree(parse('0 = (0: Natural)','expression'));builder=Builder(self.e,self.scope)
  self.assertEqual(builder.solve_with_trace(tree).defaulted_positions,())
  value=builder.materialize(tree)
  self.assertEqual(value.tree[2][4],'inferred');self.assertEqual(len(value.tree[3]),4)
 def test_default_does_not_prefer_numerals_over_exact_constructor(self):
  notation('Notation another natural zero(): Natural:',
   ['Means: 0','Literal: 0','Render latex: 0'],self.e)
  with self.assertRaises(Ambiguous):
   Builder(self.e,self.scope).materialize(expression_tree(parse('0','expression')))
 def test_retained_default_survives_new_default_and_codec(self):
  from cleanlang.numerals import identity
  from cleanlang.retained_codec import dumps,loads
  from cleanlang.core import Expressions
  value=Builder(self.e,self.scope).materialize(expression_tree(parse('0','expression')))
  saved=dumps(value.tree)
  self.e.numeral_default=('Real',tuple(identity('Real',self.e)))
  replay=Expressions(self.e,self.scope).elaborate(loads(saved))
  self.assertEqual(replay.lean,value.lean);self.assertEqual(replay.tex,value.tex)
  self.assertEqual(replay.tree[4],'defaulted')

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
