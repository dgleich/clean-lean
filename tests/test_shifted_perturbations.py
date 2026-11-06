# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
import unittest
from pathlib import Path
from cleanlang.core import Environment, Expr, Expressions, CleanError
from cleanlang.modules import load_module,load_document
ROOT=Path(__file__).resolve().parents[1]

class ShiftedPerturbations(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.e=Environment();load_module(ROOT/'library/topology/shifted_perturbations.clean',cls.e)
        cls.bindings={}
        for n,t in [('K','Type'),('field','FieldStructure(K)'),('H','HomologyTheory(K,field)'),
                    ('P','InterlevelProblem'),('t','Real'),('u','Real'),('r','Real'),
                    ('nesting','Evidence((nested pair(P.space,expanded pair(P,r))))'),
                    ('C','CertifiedPerturbation(K,field,H,P,r,nesting)'),
                    ('represents','Evidence((C.data.map=shifted perturbation(P,t)))'),
                    ('wrong','Evidence((C.data.map=shifted perturbation(P,u)))')]:
            cls.bindings[n]=Expr(n,n,cls.e.type(t,cls.bindings))
    def expr(self,s):return Expressions(self.e,dict(self.bindings)).parse(s)
    def test_shift_sign(self):
        self.assertEqual(self.e.definitions['shifted perturbation']['tree'],
          ['Call','translate real map',[['Projection',['Local','P'],'space'],
           ['Projection',['Local','P'],'map'],['Unary','-',['Local','t']]]])
    def test_authored_operations(self):
        for name in ['translate real map','shifted perturbation','shifted pair image']:
            self.assertEqual(self.e.definitions[name]['implementation'],'equals')
    def test_fixed_target(self):
        image=self.expr('shifted pair image(field,H,P,r,nesting,t,C,represents)')
        well=self.expr('relative well group(field,H,P,r,nesting)')
        self.assertEqual(image.type,well.type)
    def test_wrong_shift_evidence(self):
        with self.assertRaises(CleanError):
            self.expr('shifted pair image(field,H,P,r,nesting,t,C,wrong)')
    def test_study(self):
        self.assertEqual(len(load_document(ROOT/'studies/topology/ShiftedPerturbations.clean',self.e)),6)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
