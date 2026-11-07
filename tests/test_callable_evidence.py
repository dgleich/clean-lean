# generated: gpt-6 2026-11-07 role=assisted; experimental
import unittest,sys,tempfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,CleanError,lean
from cleanlang.modules import load_document
from cleanlang.syntax import expression_tree,parse,condition_spelling
BASE=f'''Import "{ROOT / 'library/logic/evidence.clean'}"
Source test:
  Kind: other
  Label: test
  Title: test
'''
class CallableEvidence(unittest.TestCase):
 def load(self,definitions,clauses):
  with tempfile.TemporaryDirectory() as td:
   p=Path(td)/'Test.clean';p.write_text(BASE+definitions+'\nResult specimen:\n  Attribution: test; specimen; original\n'+clauses)
   e=Environment();r=load_document(p,e);return lean(r,e,['Lean'])
 def test_condition_spelling_is_syntax_only(self):
  for source in ['for every (x: Natural,x = x)','there exists (x: Natural,x = 0)','function(x: Natural,x)','for every (h: Evidence((for every (x: Natural,x = x))),for every (n: Natural,n = n))']:
   with self.subTest(source=source):
    tree=expression_tree(parse(source,'expression'))
    self.assertEqual(expression_tree(parse(condition_spelling(tree),'expression')),tree)
 def test_parse(self):self.assertEqual(expression_tree(parse('h(n)','expression')),['Call','h',[['Local','n']]])
 def test_direct(self):self.load('', '  Assume h: for every (x: Natural,x = x)\n  Let n: Natural\n  Let p = h(n)\n  Conclude: p = p\n')
 def test_later_binder_name(self):self.load('', '  Assume h: for every (x: Natural,x = x)\n  Let x: Natural\n  Let p = h(x)\n  Conclude: p = p\n')
 def test_nested_capture(self):self.load('', '  Let n: Natural\n  Assume h: for every (x: Natural,for every (y: Natural,x+y = n))\n  Let y: Natural\n  Let k = h(y)\n  Let p = k(n)\n  Conclude: p = p\n')
 def test_wrong_domain(self):
  with self.assertRaisesRegex(CleanError,'argument mismatch'):self.load('', '  Assume h: for every (x: Natural,x = x)\n  Let z: Complex\n  Let p = h(z)\n  Conclude: p = p\n')
 def test_nonuniversal(self):
  with self.assertRaisesRegex(CleanError,'Unknown function'):self.load('', '  Let n: Natural\n  Assume h: n = n\n  Let p = h(n)\n  Conclude: p = p\n')
 def test_opaque(self):
  with self.assertRaisesRegex(CleanError,'Unknown function'):self.load('Notation opaque():\n  Returns: Proposition\n  Means: ∀ x : ℕ, x = x\n  Render latex: opaque\n', '  Let n: Natural\n  Assume h: opaque()\n  Let p = h(n)\n  Conclude: p = p\n')
 def test_projected(self):self.load('Structure Witness():\n  Let all: Evidence((for every (x: Natural,x = x)))\n  Constructor: witness\n', '  Let w: Witness\n  Let n: Natural\n  Let p = w.all(n)\n  Conclude: p = p\n')
 def test_later_type_collision(self):self.load('', '  Assume h: for every (x: Real,x = x)\n  Let z: Real\n  Let Real: Type\n  Let p = h(z)\n  Conclude: p = p\n')
 def test_wrong_equation(self):
  definitions='Define consume(g,n):\n  Let g: Function(x: Natural,Evidence((x = x)))\n  Let n: Natural\n  Returns: Evidence((n = n))\n  Equals: g(n)\n'
  with self.assertRaisesRegex(CleanError,'Dependent index mismatch'):self.load(definitions, '  Let n: Natural\n  Assume h: for every (x: Natural,x = n)\n  Let p = consume(h,n)\n  Conclude: p = p\n')
 def test_generic_projected(self):self.load('Structure Witness(T: Type):\n  Let all: Evidence((for every (x: T,x = x)))\n  Constructor: witness\n', '  Let w: Witness(Natural)\n  Let n: Natural\n  Let p = w.all(n)\n  Conclude: p = p\n')
 def test_named_generic(self):self.load('Condition reflexive(T):\n  Let T: Type\n  Holds when: for every (x: T,x = x)\n', '  Assume h: reflexive(type(Natural))\n  Let n: Natural\n  Let p = h(n)\n  Conclude: p = p\n')
 def test_proof_domain(self):self.load('', '  Assume r: for every (h: Evidence((for every (x: Natural,x = x))),for every (n: Natural,n = n))\n  Assume h: for every (x: Natural,x = x)\n  Let n: Natural\n  Let k = r(h)\n  Let p = k(n)\n  Conclude: p = p\n')
 def test_function_domain_accepts_evidence(self):self.load('', '  Assume r: for every (h: Function(x: Natural,Evidence((x = x))),for every (n: Natural,n = n))\n  Assume h: for every (x: Natural,x = x)\n  Let n: Natural\n  Let k = r(h)\n  Let p = k(n)\n  Conclude: p = p\n')
 def test_implication(self):self.load('', '  Let n: Natural\n  Assume h: n = 0 → n = n\n  Assume p: n = 0\n  Let q = h(p)\n  Conclude: q = q\n')
 def test_callable_local_precedes_module(self):
  source=self.load('Notation evidence(n: Natural): Natural:\n  Means: n+1\n  Render latex: e({n})\n','  Let n: Natural\n  Assume evidence: for every (x: Natural,x = x)\n  Let p = evidence(n)\n  Conclude: p = p\n')
  self.assertIn('(«evidence» n)',source)
 def test_noncallable_local_preserves_module_resolution(self):
  source=self.load('Notation evidence(n: Natural): Natural:\n  Means: n+1\n  Render latex: e({n})\n','  Let n: Natural\n  Assume evidence: n = n\n  Let p = evidence(n)\n  Conclude: p = p\n')
  self.assertIn('cleanNotation_evidence_',source)
  self.assertNotIn('(«evidence» n)',source)
 def test_inferred_carrier_condition(self):self.load('Condition pointwise equal(f,g):\n  Let T: Type\n  Let f,g: Function(T,T)\n  Holds when: for every (x: T,f(x) = g(x))\n','  Let T: Type\n  Let f,g: Function(T,T)\n  Let x: T\n  Assume h: pointwise equal(f,g)\n  Let p = h(x)\n  Conclude: p = p\n')
 def test_existential_result(self):self.load('', '  Assume h: for every (x: Natural,there exists (y: Natural,x = y))\n  Let n: Natural\n  Let p = h(n)\n  Conclude: p = p\n')
 def test_existential_evidence_not_callable(self):
  with self.assertRaisesRegex(CleanError,'Unknown function'):self.load('', '  Assume h: there exists (x: Natural,x = x)\n  Let n: Natural\n  Let p = h(n)\n  Conclude: p = p\n')
 def test_conjunction_evidence_not_callable(self):
  with self.assertRaisesRegex(CleanError,'Unknown function'):self.load('', '  Let n: Natural\n  Assume h: n = n and n = n\n  Assume p: n = n\n  Let q = h(p)\n  Conclude: q = q\n')
 def test_captured_local_cannot_be_rebound_by_substitution_scope(self):
  from cleanlang.core import Expr,Expressions,proof_type,NAT
  from cleanlang.modules import load_module
  from cleanlang.indices import substitute_index
  e=Environment();load_module(ROOT/'library/logic/evidence.clean',e)
  old={'n':Expr('first','n',NAT,tree=['Local','n'])}
  saved=proof_type(Expressions(e,old).parse('n = n'),e,old).args[0]
  current={'n':Expr('second','n',NAT,tree=['Local','n'])}
  with self.assertRaisesRegex(CleanError,'Captured proof scope conflict'):
   substitute_index(saved,{},e,current)
  changed=substitute_index(saved,{'n':current['n']},e,current)
  self.assertEqual(changed.lean,'(second = second)')
 def test_nested_function_domain_accepts_evidence(self):self.load('', '  Let n: Natural\n  Assume r: for every (h: Function(x: Natural,Function(y: Natural,Evidence((x+y = y+x)))),n = n)\n  Assume h: for every (x: Natural,for every (y: Natural,x+y = y+x))\n  Let p = r(h)\n  Conclude: p = p\n')
 def test_ambiguous_arrow_bindings_rejected(self):
  definitions='Type OtherFunction(A: Type,B: Type):\n  Means: (A) → (B)\n  Render latex: F({A},{B})\n'
  with self.assertRaisesRegex(CleanError,'one explicit Lean arrow'):
   self.load(definitions,'  Assume h: for every (x: Natural,x = x)\n  Let n: Natural\n  Let p = h(n)\n  Conclude: p = p\n')
 def test_local_arity_error_does_not_fall_back(self):
  definitions='Notation evidence(a: Natural,b: Natural): Natural:\n  Means: a+b\n  Render latex: e({a},{b})\n'
  with self.assertRaisesRegex(CleanError,'Function argument mismatch'):
   self.load(definitions,'  Assume evidence: for every (x: Natural,x = x)\n  Let n: Natural\n  Let p = evidence(n,n)\n  Conclude: p = p\n')
 def test_instantiated_codomain_preserves_caller_names(self):
  definitions='Condition constant law(n,value):\n  Let n: Natural\n  Let value: Function(Natural,Natural)\n  Holds when: for every (x: Natural,value(x) = n)\nStructure Constant(n: Natural):\n  Let value: Function(Natural,Natural)\n  Let law: Evidence((constant law(n,value)))\n  Constructor: constant\n'
  self.load(definitions,'  Let n,m: Natural\n  Assume h: for every (x: Natural,n = m)\n  Let c = constant(m,function(x: Natural,n),function(x: Natural,h(x)))\n  Conclude: c = c\n')
 def test_instantiated_codomain_rejects_captured_equation(self):
  definitions='Condition constant law(n,value):\n  Let n: Natural\n  Let value: Function(Natural,Natural)\n  Holds when: for every (x: Natural,value(x) = n)\nStructure Constant(n: Natural):\n  Let value: Function(Natural,Natural)\n  Let law: Evidence((constant law(n,value)))\n  Constructor: constant\n'
  with self.assertRaisesRegex(CleanError,'Dependent index mismatch'):
   self.load(definitions,'  Let n,m: Natural\n  Assume h: for every (x: Natural,m = m)\n  Let c = constant(m,function(x: Natural,n),function(x: Natural,h(x)))\n  Conclude: c = c\n')
if __name__=='__main__':unittest.main(verbosity=2)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
