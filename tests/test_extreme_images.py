# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
import unittest
from pathlib import Path
from cleanlang.core import Environment,Expr,Expressions,CleanError,Result,lean
from cleanlang.modules import load_document
ROOT=Path(__file__).resolve().parents[1]

class ExtremeImages(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.e=Environment()
        cls.results=load_document(ROOT/'studies/topology/ExtremeImages.clean',cls.e)
        cls.candidate=load_document(ROOT/'studies/topology/TwoImageCandidate.clean',cls.e)
        cls.locals={}
        for name,typ in [('K','Type'),('field','FieldStructure(K)'),('H','HomologyTheory(K,field)'),
          ('P','InterlevelProblem'),('r','Real'),('s','Real'),
          ('nesting','Evidence((nested pair(P.space,expanded pair(P,r))))'),
          ('E','ExtremePerturbations(K,field,H,P,r,nesting)')]:
            cls.locals[name]=Expr(name,name,cls.e.type(typ,cls.locals))
    def expr(self,s):return Expressions(self.e,dict(self.locals)).parse(s)
    def test_authored_intersection(self):
        for name in ['intersection of module subspaces','module subspace included','extreme pair image','scalar homology']:
            self.assertEqual(self.e.definitions[name]['implementation'],'equals')
        self.assertEqual(self.e.definitions['intersection of module subspaces']['tree'][0:2],['Call','module subspace infimum'])
    def test_same_target_as_well_group(self):
        self.assertEqual(self.expr('extreme pair image(field,H,P,r,nesting,E)').type,
                         self.expr('relative well group(field,H,P,r,nesting)').type)
    def test_wrong_radius_and_swapped_evidence(self):
        for source in ['extreme pair image(field,H,P,s,nesting,E)',
          'extreme perturbations(K,field,H,P,r,nesting,E.top,E.bottom,E.bottomShift,E.topShift)']:
            with self.subTest(source=source),self.assertRaises(CleanError):self.expr(source)
    def test_statement_counts_and_candidate_status(self):
        self.assertEqual(len([r for r in self.results if isinstance(r,Result)]),4)
        self.assertEqual(len([r for r in self.candidate if isinstance(r,Result)]),1)
        target=lean(self.candidate,self.e,[])
        self.assertIn('def «interlevel_two_image_candidate» : Prop :=',target)
        self.assertNotIn('theorem interlevel_two_image_candidate',target)
        self.assertNotIn('axiom interlevel_two_image_candidate',target)
        self.assertIn('«compactness_of_P_u2e_space»',target)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
