# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Direct dependent value inference must retain checked caller bindings."""
from pathlib import Path
import tempfile
import unittest
from cleanlang.core import Environment,Expr,Expressions,CleanError,Type,lean
from cleanlang.modules import load_module
from cleanlang.conversion import comparison_normal_form
ROOT=Path(__file__).resolve().parents[1]

RECOVER='''Define recovered field(M):
  Let K: Type
  Let field: FieldStructure(K)
  Let M: CoefficientModule(K,field)
  Returns: FieldStructure(K)
  Equals: field

Define retain field(field):
  Let K: Type
  Let field: FieldStructure(K)
  Returns: FieldStructure(K)
  Equals: field
'''
CALLABLE='''Define callable field(f):
  Let K: Type
  Let field: FieldStructure(K)
  Let f: Function(x: FieldStructure(K),CoefficientModule(K,field))
  Returns: FieldStructure(K)
  Equals: field
'''
class InferredValues(unittest.TestCase):
 def load(self,extra=''):
  with tempfile.TemporaryDirectory() as d:
   p=Path(d)/'Module.clean';p.write_text('Import "'+str(ROOT/'library/algebra/chains.clean')+'"\n'+extra)
   e=Environment();load_module(p,e)
  return e
 def scope(self,e,entries=None):
  scope={}
  for name,typ in (entries or [('F','Type'),('field','FieldStructure(F)'),('other','FieldStructure(F)'),('M','CoefficientModule(F,field)'),('N','CoefficientModule(F,field)'),('P','CoefficientModule(F,other)')]):
   scope[name]=Expr(name,name,e.type(typ,scope),tree=['Local',name])
  return scope
 def test_signature_and_target(self):
  e=self.load();s=self.scope(e)
  self.assertEqual(e.data['functions']['same module']['signature_tree'],['Signature','same module',[
   ['Parameter','K','Type','implicit'],['Parameter','field','FieldStructure(K)','implicit'],
   ['Parameter','M','CoefficientModule(K,field)','explicit'],['Parameter','N','CoefficientModule(K,field)','explicit']],'Proposition'])
  expression=Expressions(e,s).parse('M=N');key=e.data['functions']['same module']['native_binding']
  self.assertEqual(expression.tree,['Operator','=', ['Local','M'],['Local','N']])
  self.assertEqual(expression.lean,f'(@_root_.{key} (F) (field) (M) (N))')
  self.assertEqual(expression.lean,Expressions(e,s).parse('same module(M,N)').lean)
  e.operator_overloads['='].reverse()
  self.assertEqual(expression.lean,Expressions(e,s).parse('M=N').lean)
 def test_distinct_fields_rejected(self):
  e=self.load();s=self.scope(e)
  with self.assertRaisesRegex(CleanError,'No declared meaning'):Expressions(e,s).parse('M=P')
  with self.assertRaisesRegex(CleanError,'Inconsistent dependent argument'):Expressions(e,s).parse('same module(M,P)')
 def test_recovered_value_conversion_and_same_named_caller(self):
  e=self.load(RECOVER);s=self.scope(e)
  value=Expressions(e,s).parse('recovered field(M)')
  self.assertEqual(value.type,s['field'].type)
  self.assertEqual(comparison_normal_form(value,e,s).tree,['Local','field'])
 def test_computed_value_and_first_occurrence(self):
  e=self.load(RECOVER);s=self.scope(e)
  s['Q']=Expr('Q','Q',e.type('CoefficientModule(F,(retain field(field)))',s),tree=['Local','Q'])
  value=Expressions(e,s).parse('same module(Q,M)')
  actual=Expressions(e,s).parse('retain field(field)')
  key=e.data['functions']['same module']['native_binding']
  self.assertEqual(value.lean,f'(@_root_.{key} (F) ({actual.lean}) (Q) (M))')
  self.assertEqual(comparison_normal_form(Expressions(e,s).parse('recovered field(Q)'),e,s).tree,['Local','field'])
 def test_dependent_callable_and_binder_escape(self):
  e=self.load(CALLABLE);s=self.scope(e)
  s['f']=Expr('f','f',e.type('Function(x: FieldStructure(F),CoefficientModule(F,field))',s),tree=['Local','f'])
  self.assertEqual(comparison_normal_form(Expressions(e,s).parse('callable field(f)'),e,s).tree,['Local','field'])
  s['g']=Expr('g','g',e.type('Function(x: FieldStructure(F),CoefficientModule(F,x))',s),tree=['Local','g'])
  with self.assertRaisesRegex(CleanError,'cannot escape'):Expressions(e,s).parse('callable field(g)')
 def test_absent_and_nondirect_indices_reject(self):
  with self.assertRaisesRegex(CleanError,'direct argument-type index'):
   self.load('''Notation absent(x):
  Let K: Type
  Let field: FieldStructure(K)
  Let x: K
  Returns: FieldStructure(K)
  Means: field
  Render latex: {x}
''')
  with self.assertRaisesRegex(CleanError,'direct argument-type index'):
   self.load(RECOVER+'''Notation hidden(M):
  Let K: Type
  Let field: FieldStructure(K)
  Let M: CoefficientModule(K,(retain field(field)))
  Returns: FieldStructure(K)
  Means: field
  Render latex: {M}
''')
 def test_distinct_overloads_remain_ambiguous(self):
  e=self.load('''Condition competing(M,N):
  Let K: Type
  Let field: FieldStructure(K)
  Let M,N: CoefficientModule(K,field)
  Infix: =
  From Lean: N = M
''');s=self.scope(e)
  for _ in range(2):
   with self.assertRaisesRegex(CleanError,'Ambiguous'):Expressions(e,s).parse('M=N')
   e.operator_overloads['='].reverse()

 def test_changed_scope_and_poisoned_inference_are_rechecked(self):
  e=self.load(RECOVER);s=self.scope(e)
  old=Expressions(e,s).parse('recovered field(M)')
  old.inferred_args=(('field','poison'),)
  s['M']=Expr('Mnew','M',s['P'].type,tree=['Local','M'])
  current=comparison_normal_form(old,e,s)
  self.assertEqual(current.tree,['Local','other'])
  self.assertNotIn('poison',current.lean)
 def test_wrong_dependent_type_is_rejected(self):
  e=self.load();s=self.scope(e)
  # Deliberately inconsistent external scope: keep the module index but change
  # the referenced field's checked type. The implicit term must be rechecked.
  s['field']=Expr('wrong','field',e.type('Real'),tree=['Local','field'])
  with self.assertRaises(CleanError):Expressions(e,s).parse('same module(M,N)')
 def test_bound_call_survives_a_new_competing_operator(self):
  from cleanlang.bound_calls import bind
  from cleanlang.modules import notation
  e=self.load();s=self.scope(e)
  tree=bind(Expressions(e,s).parse('M=N').tree,e,s)
  before=Expressions(e,s).elaborate(tree)
  notation('Notation later(M,N):',['Let K: Type','Let field: FieldStructure(K)',
   'Let M,N: CoefficientModule(K,field)','Returns: Proposition','Infix: =',
   'Means: N = M','Render latex: {M}={N}'],e)
  with self.assertRaisesRegex(CleanError,'Ambiguous'):Expressions(e,s).parse('M=N')
  self.assertEqual(Expressions(e,s).elaborate(tree).lean,before.lean)

 def test_callable_binder_must_remain_fresh(self):
  with self.assertRaisesRegex(CleanError,'binder must be fresh'):
   self.load("""Define shadowed field(M,f):
  Let K: Type
  Let field: FieldStructure(K)
  Let M: CoefficientModule(K,field)
  Let f: Function(field: FieldStructure(K),CoefficientModule(K,field))
  Returns: FieldStructure(K)
  Equals: field
""")

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
