# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
import copy,json,unittest
from pathlib import Path
from cleanlang.core import Environment,Expr,Expressions,CleanError
from cleanlang.modules import load_module,type_declaration,notation
from cleanlang.annotations import Annotation
from cleanlang.conditions import source_expression,lean_name
from cleanlang.syntax import expression_spelling,condition_spelling
from cleanlang.conversion import comparison_normal_form
from cleanlang.bound_calls import bind
ROOT=Path(__file__).resolve().parents[2]
class ClassifiedValues(unittest.TestCase):
 def setUp(self):
  self.e=Environment();load_module(ROOT/'library/topology/spaces.clean',self.e)
  self.classifier('Large',1);self.local={}
 def classifier(self,name,k):
  type_declaration('Type '+name+'():',[f'Universe: {k+1}',f'Classifies: {k}',f'Means: Type {k}','Render latex: C'],self.e)
 def expr(self,source):return Expressions(self.e,self.local).parse(source)
 def test_explicit_higher_type(self):
  v=self.expr('type(TopologicalSpace : Large)')
  self.assertEqual(v.type,self.e.type('Large'));self.assertEqual(v.tree[0],'BoundTypeValue')
  self.assertIsInstance(v.tree[1],Annotation);self.assertIsInstance(v.tree[2],Annotation)
  self.assertEqual(v.lean,self.e.render_type(self.e.type('TopologicalSpace'),'lean'))
 def test_unannotated_unique_level(self):
  self.assertEqual(self.expr('type(TopologicalSpace)').type,self.e.type('Large'))
  self.assertEqual(self.expr('type(Real)').type,self.e.type('Type'))
 def test_aliases_deduplicate(self):
  type_declaration('Type Alias():',['Equals: Large'],self.e)
  self.assertEqual(self.expr('type(TopologicalSpace)').type,self.e.type('Large'))
  self.assertEqual(self.expr('type(TopologicalSpace : Alias)').tree,self.expr('type(TopologicalSpace : Large)').tree)
 def test_ambiguity_rejects_both_orders(self):
  self.classifier('Another',1)
  for _ in range(2):
   with self.assertRaisesRegex(CleanError,'Ambiguous carrier classifier'):self.expr('type(TopologicalSpace)')
   self.e.data['types']=dict(reversed(list(self.e.data['types'].items())))
  self.assertEqual(self.expr('type(TopologicalSpace : Large)').type,self.e.type('Large'))
  with self.assertRaisesRegex(CleanError,'Ambiguous carrier classifier'):
   Expressions(self.e,{}).parse('type(TopologicalSpace)',expected=self.e.type('Large'))
 def test_missing_classifier(self):
  del self.e.data['types']['Large']
  with self.assertRaisesRegex(CleanError,'No declared classifier'):self.expr('type(TopologicalSpace)')
 def test_wrong_level(self):
  for s in ('type(Real : Large)','type(TopologicalSpace : Type)'):
   with self.assertRaises(CleanError):self.expr(s)
 def test_ordinary_bundle_is_not_classifier(self):
  with self.assertRaisesRegex(CleanError,'declared carrier classifier'):self.expr('type(Real : TopologicalSpace)')
 def test_proof_is_not_a_carrier(self):
  with self.assertRaisesRegex(CleanError,'Proof types'):self.expr('type((0 = 0) : Type)')
 def test_carrier_alias_normalizes_names(self):
  type_declaration('Type Scalar():',['Equals: Real'],self.e)
  self.assertEqual(source_expression(self.expr('type(Scalar)').tree),'type(Real)')
 def test_bound_value_does_not_reselect(self):
  v=self.expr('type(TopologicalSpace)');self.classifier('Another',1)
  again=Expressions(self.e,self.local).elaborate(v.tree)
  self.assertEqual(again.type,v.type);self.assertEqual(again.lean,v.lean)
  with self.assertRaises(CleanError):self.expr('type(TopologicalSpace)')
 def test_changed_snapshot_rejects(self):
  v=self.expr('type(TopologicalSpace : Large)')
  for field,value in [('classifies',0),('universe',3),('native_binding','changed')]:
   env=copy.deepcopy(self.e);env.data['types']['Large'][field]=value
   with self.assertRaises(CleanError):Expressions(env,{}).elaborate(v.tree)
 def test_changed_native_body_rejects(self):
  v=self.expr('type(TopologicalSpace : Large)');key=self.e.classifier_info(v.type)[0]
  self.e.notation_definitions[key]+='-- changed\n'
  with self.assertRaises(CleanError):Expressions(self.e,{}).elaborate(v.tree)
 def test_missing_local_carrier_rejects_replay(self):
  self.local['A']=Expr('A','A',self.e.type('Large'),tree=['Local','A'])
  value=self.expr('type(A : Large)')
  with self.assertRaisesRegex(CleanError,'Unbound carrier references: A'):
   Expressions(self.e,{}).elaborate(value.tree)
 def test_carrier_annotation_cannot_hide_a_free_reference(self):
  self.local['A']=Expr('A','A',self.e.type('Large'),tree=['Local','A'])
  value=self.expr('type(A : Large)');tree=list(value.tree)
  tree[1]=Annotation('A',tree[1].typ,())
  with self.assertRaisesRegex(CleanError,'Untracked carrier references'):
   Expressions(self.e,{}).elaborate(tree)
 def test_classifier_annotation_must_be_closed(self):
  value=self.expr('type(TopologicalSpace : Large)');tree=list(value.tree)
  tree[2]=Annotation(str(tree[2]),tree[2].typ,{'unused'})
  with self.assertRaisesRegex(CleanError,'must be closed'):Expressions(self.e,{}).elaborate(tree)
 def test_malformed_retention_rejects(self):
  v=self.expr('type(Real)')
  for tree in [v.tree[:4],json.loads(json.dumps(v.tree)),[*v.tree[:4],'unknown']]:
   with self.assertRaises(CleanError):Expressions(self.e,{}).elaborate(tree)
 def test_renderers_and_name_encoding(self):
  v=self.expr('type(TopologicalSpace : Large)')
  for render in (source_expression,expression_spelling,condition_spelling):
   self.assertEqual(render(v.tree),'type(TopologicalSpace : Large)')
  self.assertNotEqual(lean_name(source_expression(v.tree)),lean_name('type(TopologicalSpace)'))
 def test_explicit_latex_preserves_classifier_annotation(self):
  explicit=self.expr('type(TopologicalSpace : Large)');implicit=self.expr('type(TopologicalSpace)')
  self.assertEqual(explicit.tex,r'\left('+implicit.tex+' : C'+r'\right)')
 def test_computed_index_preserves_selected_classifier(self):
  from cleanlang.indices import index_value,substitute_index
  from cleanlang.dependent_functions import index_tree
  notation('Notation marker(T):',['Let T: Large','Returns: Natural','Means: 0','Render latex: m({T})'],self.e)
  self.local['A']=Expr('A','A',self.e.type('Large'),tree=['Local','A'])
  value=index_value(self.expr('marker(type(A : Large))'),self.e,self.local)
  result=substitute_index(value,{'A':self.e.type('TopologicalSpace')},self.e,{})
  self.assertEqual(index_tree(result)[2][0][0],'BoundTypeValue')
  self.assertIn('type(TopologicalSpace : Large)',result.name)
 def test_binding_is_idempotent(self):
  v=self.expr('type(TopologicalSpace : Large)');self.assertEqual(bind(v.tree,self.e,{}),v.tree)
 def test_explicit_generic_call_with_type_expression(self):
  notation('Define keep(A,x):',['Let A: Large','Let x: A','Returns: A','Equals: x'],self.e,authored=True)
  self.local['X']=Expr('X','X',self.e.type('TopologicalSpace'),tree=['Local','X'])
  v=self.expr('keep(type(TopologicalSpace : Large),X)')
  self.assertEqual(v.type,self.local['X'].type)
  self.assertEqual(comparison_normal_form(v,self.e,self.local).tree,['Local','X'])
 def test_authored_carrier_function_is_an_explicit_argument(self):
  notation('Define topology carrier():',['Returns: Large','Equals: type(TopologicalSpace : Large)'],self.e,authored=True)
  notation('Define keep(A,x):',['Let A: Large','Let x: A','Returns: A','Equals: x'],self.e,authored=True)
  self.local['X']=Expr('X','X',self.e.type('TopologicalSpace'),tree=['Local','X'])
  self.classifier('Another',1)
  value=self.expr('keep(topology carrier(),X)')
  self.assertEqual(value.type,self.local['X'].type)
  self.assertEqual(comparison_normal_form(value,self.e,self.local).tree,['Local','X'])
 def test_reify_selected_implicit_classifier_when_ambiguous(self):
  notation('Define keep(A,x):',['Let A: Large','Let x: A','Returns: A','Equals: x'],self.e,authored=True)
  notation('Define again(x):',['Let A: Large','Let x: A','Returns: A','Equals: keep(A,x)'],self.e,authored=True)
  self.local['X']=Expr('X','X',self.e.type('TopologicalSpace'),tree=['Local','X'])
  self.classifier('Another',1)
  v=self.expr('again(X)');self.assertEqual(comparison_normal_form(v,self.e,self.local).tree,['Local','X'])
 def test_inferred_carrier_in_result_index(self):
  type_declaration('Type Indexed(T: Large):',['Means: Nat','Render latex: I({T})'],self.e)
  notation('Notation tag(x):',['Let A: Large','Let x: A','Returns: Indexed(A)','Means: 0','Render latex: t({x})'],self.e)
  self.classifier('Another',1)
  self.local['X']=Expr('X','X',self.e.type('TopologicalSpace'),tree=['Local','X'])
  value=self.expr('tag(X)')
  expected=self.e.type('Indexed((type(TopologicalSpace : Large)))',self.local)
  self.assertEqual(value.type,expected)
 def test_inferred_carrier_in_computed_result_index(self):
  notation('Notation marker(T):',['Let T: Large','Returns: Natural','Means: 0','Render latex: m({T})'],self.e)
  notation('Notation tag vector(x):',['Let A: Large','Let x: A','Returns: Vector((marker(A)),Real)','Means: fun _ => 0','Render latex: t({x})'],self.e)
  self.classifier('Another',1)
  self.local['X']=Expr('X','X',self.e.type('TopologicalSpace'),tree=['Local','X'])
  value=self.expr('tag vector(X)')
  expected=self.e.type('Vector((marker(type(TopologicalSpace : Large))),Real)',self.local)
  self.assertEqual(value.type,expected)
 def test_hygiene_substitutes_only_carrier_annotation(self):
  from cleanlang.type_values import substitute
  self.local['A']=Expr('A','A',self.e.type('Large'),tree=['Local','A'])
  value=self.expr('type(A : Large)')
  tree=substitute(value.tree,{'A':self.e.type('TopologicalSpace')},self.e,{})
  self.assertEqual(tree[2:],value.tree[2:]);self.assertEqual(str(tree[1]),'TopologicalSpace')
  self.assertEqual(Expressions(self.e,{}).elaborate(tree).type,self.e.type('Large'))
if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
