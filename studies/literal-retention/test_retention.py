# generated: gpt-6 2026-11-10 role=assisted; isolated prototype
from pathlib import Path
import tempfile,unittest
from cleanlang.core import Environment,Expr,Expressions,CleanError
from cleanlang.modules import load_module
import cleanlang
ROOT=Path(cleanlang.__file__).resolve().parents[1]
SOURCE='''Notation vector zero(n):
  Let n: Natural
  Returns: Vector(n,Complex)
  Means: fun _ => (0 : Complex)
  Literal: 0
  Render latex: 0
Notation matrix zero(m,n):
  Let m,n: Natural
  Returns: Matrix(m,n,Complex)
  Means: fun _ _ => (0 : Complex)
  Literal: 0
  Render latex: 0
'''
class ExactLiteralPrototype(unittest.TestCase):
 def load(self,source=SOURCE):
  env=Environment()
  with tempfile.TemporaryDirectory() as directory:
   p=Path(directory)/'Example.clean';p.write_text('Import "'+str(ROOT/'library/operators.clean')+'"\n'+source)
   load_module(p,env)
  return env
 def scope(self,e):return {n:Expr(n,n,e.type('Natural'),tree=['Local',n]) for n in ['n','m']}
 def test_vector_target(self):
  e=self.load();scope=self.scope(e)
  v=Expressions(e,scope).parse('(0: Vector(n,Complex))')
  self.assertEqual(v.lean,Expressions(e,scope).parse('vector zero(n)').lean)
  self.assertEqual(v.type,e.type('Vector(n,Complex)',scope))
  self.assertEqual(v.tree[:2],['BoundLiteral','0'])
  self.assertEqual([a[2] for a in v.tree[5]],[['Local','n']])
 def test_rectangular_target(self):
  e=self.load();scope=self.scope(e)
  v=Expressions(e,scope).parse('(0: Matrix(m,n,Complex))')
  self.assertEqual(v.lean,Expressions(e,scope).parse('matrix zero(m,n)').lean)
  self.assertEqual([a[2] for a in v.tree[5]],[['Local','m'],['Local','n']])
 def test_inferred_calls_do_not_enable_unannotated_zero(self):
  e=self.load();scope=self.scope(e);scope['x']=Expr('x','x',e.type('Vector(n,Complex)',scope),tree=['Local','x'])
  with self.assertRaises(CleanError):Expressions(e,scope).parse('x != 0')
 def test_leading_zeroes_and_case(self):
  e=self.load(SOURCE.replace('Literal: 0','lItErAl: 00'));v=Expressions(e,self.scope(e)).parse('(000: Vector(n,Complex))')
  self.assertEqual(v.tree[3],'vector zero')
 def test_source_parse_is_still_annotation(self):
  from cleanlang.syntax import parse,expression_tree
  self.assertEqual(expression_tree(parse('(0: Vector(n,Complex))','expression')),
   ['NumeralAnnotation','0',['Apply','Vector',[['Name','n'],['Name','Complex']]]])
 def test_define_adapter_attachment(self):
  e=self.load(SOURCE.replace('Notation','Define').replace('Means:','From Lean:'))
  self.assertEqual(Expressions(e,self.scope(e)).parse('(0: Vector(n,Complex))').tree[3],'vector zero')
 def test_renamed_carrier_has_no_display_name_dispatch(self):
  declaration='Type Pack(n: Natural):\n  Means: Fin n → Complex\n  Render latex: P({n})\n'
  e=self.load(declaration+SOURCE.replace('Vector(n,Complex)','Pack(n)'))
  value=Expressions(e,self.scope(e)).parse('(0: Pack(n))')
  self.assertEqual(value.tree[3],'vector zero')
 def test_direct_parameter_then_computed_constraint(self):
  e=self.load(SOURCE[:SOURCE.index('Notation matrix')].replace('Returns: Vector(n,Complex)','Returns: Matrix(n,(n+1),Complex)').replace('Means: fun _ =>','Means: fun _ _ =>'))
  self.assertEqual(Expressions(e,self.scope(e)).parse('(0: Matrix(n,(n+1),Complex))').tree[3],'vector zero')
 def test_duplicate_candidates(self):
  source=SOURCE+SOURCE[:SOURCE.index('Notation matrix')].replace('vector zero','other zero')
  e=self.load(source)
  with self.assertRaisesRegex(CleanError,'Ambiguous'):Expressions(e,self.scope(e)).parse('(0: Vector(n,Complex))')
 def test_exact_and_all_numerals_compete(self):
  e=self.load('Notation real zero(): Real:\n  Means: 0\n  Literal: 0\n  Render: zero\n')
  with self.assertRaisesRegex(CleanError,'Ambiguous'):Expressions(e,{}).parse('(0: Real)')
 def test_no_matching_digit(self):
  e=self.load()
  with self.assertRaises(CleanError):Expressions(e,self.scope(e)).parse('(1: Vector(n,Complex))')
 def test_undeclared_dimension_is_not_guessed(self):
  e=self.load()
  with self.assertRaises(CleanError):Expressions(e,{}).parse('(0: Vector(n,Complex))')
 def test_extra_parameter_rejected(self):
  with self.assertRaisesRegex(CleanError,'direct result occurrence'):
   self.load(SOURCE.replace('vector zero(n)','vector zero(n,k)').replace('Let n: Natural','Let n,k: Natural'))
 def test_computed_only_parameter_rejected(self):
  with self.assertRaisesRegex(CleanError,'direct result occurrence'):
   self.load(SOURCE.replace('Returns: Vector(n,Complex)','Returns: Vector((n+1),Complex)'))
 def test_invalid_literal_fields(self):
  for text in ['-1','1+1','١','0,1']:
   with self.subTest(text=text),self.assertRaises(CleanError):self.load(SOURCE.replace('Literal: 0','Literal: '+text))
 def test_attachment_rejected_outside_callable_declarations(self):
  cases=['Source x:\n  Kind: other\n  Title: x\n  Label: x\n  Literal: 0\n',
         'Type X():\n  Means: Nat\n  Render latex: X\n  Literal: 0\n',
         'Condition c(x: Real):\n  Holds when: x=x\n  Literal: 0\n']
  for source in cases:
   with self.subTest(source=source),self.assertRaises(CleanError):self.load(source)
 def test_duplicate_field_rejected(self):
  with self.assertRaisesRegex(CleanError,'Duplicate'):self.load(SOURCE.replace('Literal: 0','Literal: 0\n  Literal: 0'))
 def test_retained_selection_survives_later_competitor(self):
  from cleanlang.modules import notation
  e=self.load();scope=self.scope(e)
  original=Expressions(e,scope).parse('(0: Vector(n,Complex))')
  notation('Notation alternative zero(n):',[
   'Let n: Natural','Returns: Vector(n,Complex)','Means: fun _ => (0 : Complex)',
   'Literal: 0','Render latex: 0'],e)
  with self.assertRaisesRegex(CleanError,'Ambiguous'):
   Expressions(e,scope).parse('(0: Vector(n,Complex))')
  self.assertEqual(Expressions(e,scope).elaborate(original.tree).lean,original.lean)
 def test_substitution_changes_dimension_without_reselecting(self):
  from cleanlang.hygiene import substitute
  e=self.load();scope=self.scope(e)
  original=Expressions(e,scope).parse('(0: Vector(n,Complex))')
  changed=substitute(original.tree,{'n':scope['m']},e,scope)
  value=Expressions(e,scope).elaborate(changed)
  self.assertEqual([a[2] for a in value.tree[5]],[['Local','m']])
  self.assertEqual(value.type,e.type('Vector(m,Complex)',scope))
  self.assertEqual(value.lean,Expressions(e,scope).parse('vector zero(m)').lean)
 def test_authored_body_keeps_selected_constructor(self):
  from cleanlang.modules import notation
  from cleanlang.conversion import comparison_normal_form
  e=self.load();scope=self.scope(e)
  notation('Define selected zero(n: Natural): Vector(n,Complex):',
   ['Equals: (0: Vector(n,Complex))'],e,authored=True)
  notation('Notation competitor(n: Natural): Vector(n,Complex):',
   ['Means: fun _ => (0 : Complex)','Literal: 0','Render latex: 0'],e)
  value=Expressions(e,scope).parse('selected zero(n)')
  reduced=comparison_normal_form(value,e,scope)
  self.assertEqual(reduced.lean,Expressions(e,scope).parse('vector zero(n)').lean)
 def test_deleted_retained_constructor_rejects(self):
  e=self.load();scope=self.scope(e)
  original=Expressions(e,scope).parse('(0: Vector(n,Complex))')
  del e.data['functions']['vector zero']
  with self.assertRaisesRegex(CleanError,'Missing literal declaration'):
   Expressions(e,scope).elaborate(original.tree)
 def test_changed_retained_constructor_rejects(self):
  e=self.load();scope=self.scope(e)
  original=Expressions(e,scope).parse('(0: Vector(n,Complex))')
  e.data['functions']['vector zero']['lean']='changed target'
  with self.assertRaisesRegex(CleanError,'Changed retained literal declaration'):
   Expressions(e,scope).elaborate(original.tree)
 def test_literal_spelling_preserves_annotation(self):
  from cleanlang.syntax import condition_spelling
  e=self.load();scope=self.scope(e)
  value=Expressions(e,scope).parse('(0: Vector(n,Complex))')
  self.assertEqual(condition_spelling(value.tree),'(0: Vector(n,Complex))')
 def test_annotation_substitutes_with_actual_arguments(self):
  from cleanlang.hygiene import substitute
  from cleanlang.syntax import condition_spelling
  e=self.load();scope=self.scope(e)
  value=Expressions(e,scope).parse('(0: Vector(n,Complex))')
  changed=substitute(value.tree,{'n':scope['m']},e,scope)
  self.assertEqual(condition_spelling(changed),'(0: Vector(m,Complex))')
  self.assertEqual(changed[6].names,frozenset({'m'}))
 def test_automatic_name_uses_canonical_literal_digits(self):
  from cleanlang.conditions import source_expression
  e=self.load();scope=self.scope(e)
  value=Expressions(e,scope).parse('(000: Vector(n,Complex))')
  self.assertEqual(source_expression(value.tree),'(0: Vector(n,Complex))')
  self.assertEqual(value.tree[2],'000')
 def test_free_names_include_carrier_but_not_constructor_formals(self):
  from cleanlang.dependent_functions import tree_names
  e=self.load();scope=self.scope(e)
  value=Expressions(e,scope).parse('(0: Matrix(m,n,Complex))')
  self.assertEqual(tree_names(value.tree),{'m','n'})
 def test_json_without_checked_annotation_rejects(self):
  import json
  e=self.load();scope=self.scope(e)
  value=Expressions(e,scope).parse('(0: Vector(n,Complex))')
  restored=json.loads(json.dumps(value.tree))
  with self.assertRaisesRegex(CleanError,'annotation lost'):
   Expressions(e,scope).elaborate(restored)
 def test_changed_annotation_rejects(self):
  from cleanlang.annotations import checked
  e=self.load();scope=self.scope(e)
  value=Expressions(e,scope).parse('(0: Vector(n,Complex))')
  value.tree[6]=checked('Vector(m,Complex)',e,scope)
  with self.assertRaisesRegex(CleanError,'differs from checked carrier'):
   Expressions(e,scope).elaborate(value.tree)
 def test_changed_attachment_digits_rejects(self):
  e=self.load();scope=self.scope(e)
  value=Expressions(e,scope).parse('(0: Vector(n,Complex))')
  e.data['functions']['vector zero']['literal']['digits']='1'
  with self.assertRaisesRegex(CleanError,'Changed retained literal'):
   Expressions(e,scope).elaborate(value.tree)
 def test_beta_reduction_updates_checked_annotation(self):
  from cleanlang.conversion import comparison_normal_form
  e=self.load();scope=self.scope(e)
  value=Expressions(e,scope).parse('(function(k: Natural,(0: Vector(k,Complex))))(n)')
  normal=comparison_normal_form(value,e,scope)
  self.assertEqual(normal.lean,Expressions(e,scope).parse('vector zero(n)').lean)
 def test_changed_declared_constructor_rejects(self):
  e=self.load();e.data['functions']['vector zero']['lean']='changed target'
  with self.assertRaisesRegex(CleanError,'Changed literal'):Expressions(e,self.scope(e)).parse('(0: Vector(n,Complex))')

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
