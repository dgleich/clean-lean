# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
import tempfile
import unittest
from pathlib import Path
from cleanlang import syntax
from cleanlang.core import Environment, Expr, ProofType, CleanError, lean
from cleanlang.modules import load_document, load_module
ROOT=Path(__file__).resolve().parents[1]
PRELUDE=f'''Import "{ROOT}/library/topology/basic.clean"
Import "{ROOT}/library/topology/pairs.clean"
Source tests:
  Kind: other
  Label: Tests
  Title: Evidence tests
'''
RESULT='''Result example:
  Attribution: tests; example; original
  Let X: Type
  Let S,T: Set(X)
  Assume inclusion: S ⊆ T
  Let Q = certified inclusion(X,S,T,inclusion)
  Conclude: Q.source = S
'''
class Evidence(unittest.TestCase):
    def load(self,source=RESULT,extra=''):
        with tempfile.TemporaryDirectory() as d:
            p=Path(d)/'test.clean';p.write_text(PRELUDE+extra+'\n'+source)
            e=Environment();r=load_document(p,e);return e,r
    def test_root_tree(self):
        self.assertEqual(syntax.type_tree(syntax.parse('(S ⊆ T)','type_ref')),
            ['ComputedIndex',['Operator','⊆',['Local','S'],['Local','T']]])
    def test_assumption_passes_explicit_proof(self):
        e,r=self.load();s=lean(r,e,[])
        self.assertIn('∀ («inclusion» : (S ⊆ T)),',s)
        self.assertIn('(S) (T) («inclusion»)',s)
    def test_direct_type_equals_alias(self):
        e=Environment();load_module(ROOT/'library/topology/pairs.clean',e)
        local={}
        for n,t in [('X','Type'),('S','Set(X)'),('T','Set(X)')]:local[n]=Expr(n,n,e.type(t,local))
        a=e.type('(S ⊆ T)',local)
        self.assertIsInstance(a,ProofType)
        self.assertEqual(a,e.type('Evidence((S ⊆ T))',local))
        for t in ['(S)','Set((S ⊆ T))','Set(Evidence((S ⊆ T)))']:
            with self.subTest(t=t),self.assertRaises(CleanError):e.type(t,local)
    def test_typed_evidence_parameter(self):
        self.load(RESULT.replace('Assume inclusion: S ⊆ T','Let inclusion: (S ⊆ T)'))
    def test_wrong_proof_and_forward_reference(self):
        for old,new in [('Assume inclusion: S ⊆ T','Assume inclusion: T ⊆ S'),
                        ('Assume inclusion: S ⊆ T\n',''),
                        ('inclusion)','S)'),
                        ('Assume inclusion: S ⊆ T','Assume subset inclusion: S ⊆ T')]:
            with self.subTest(new=new),self.assertRaises(CleanError):self.load(RESULT.replace(old,new))
    def test_duplicate_binding(self):
        with self.assertRaises(CleanError):self.load(RESULT.replace('Let Q =','Let inclusion: Real\n  Let Q ='))
    def test_binder_assumption_still_legal_but_not_a_value(self):
        source=RESULT.replace('Assume inclusion: S ⊆ T','Assume all: for every (x: X, x=x)\n  Assume inclusion: S ⊆ T')
        self.load(source)
        with self.assertRaisesRegex(CleanError,'named Condition'):
            self.load(source.replace('Let Q =','Let h = all\n  Let Q ='))
    def test_named_condition_and_sequential_assumptions(self):
        extra='''Condition included(X: Type,S: Set(X),T: Set(X)):
  Holds when: S ⊆ T
Condition checked(X: Type,S: Set(X),T: Set(X),h: (included(X,S,T))):
  Holds when: S = S
'''
        source=RESULT.replace('Assume inclusion: S ⊆ T',
            'Assume inclusion: S ⊆ T, included: included(X,S,T), included(X,T,T), checked(X,S,T,included)')
        self.load(source,extra)
    def test_record_projection_substitution(self):
        self.load(RESULT.replace('Conclude:','Let f = certified inclusion map(X,Q)\n  Conclude:'))
    def test_study(self):
        e=Environment();r=load_document(ROOT/'studies/topology/Evidence.clean',e)
        self.assertEqual(len(r),4)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
