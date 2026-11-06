# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
import unittest
from pathlib import Path
from cleanlang.core import Environment,Expr,Expressions,CleanError,lean
from cleanlang.modules import load_module,load_document
ROOT=Path(__file__).resolve().parents[1]
class RelativeHomology(unittest.TestCase):
    def setUp(self):
        self.e=Environment();load_module(ROOT/'library/topology/relative_homology.clean',self.e)
        self.local={}
        for n,t in [('K','Type'),('field','FieldStructure(K)'),('other','FieldStructure(K)'),
                    ('H','HomologyTheory(K,field)'),('X','TopologicalSpace'),('Y','TopologicalSpace'),
                    ('Q','TopologicalPair(X)'),('C','ModuleChainComplex(K,field)'),
                    ('D','ModuleChainComplex(K,field)'),('f','ChainMap(K,field,C,D)')]:
            self.local[n]=Expr(n,n,self.e.type(t,self.local))
    def expr(self,s):return Expressions(self.e,self.local).parse(s)
    def test_chain_module_imports_standalone(self):
        e=Environment();load_module(ROOT/'library/algebra/chains.clean',e)
        self.assertEqual(e.data['types']['ModuleChainComplex']['universe'],1)
        self.assertIn('Mathlib.Algebra.Category.ModuleCat.Abelian',e.lean_imports)
    def test_relative_construction_is_authored(self):
        for name in ['pair chain inclusion','relative chains','relative homology']:
            self.assertEqual(self.e.definitions[name]['implementation'],'equals')
        self.assertEqual(self.e.definitions['relative chains']['tree'][0:2],['Call','chain cokernel'])
        self.assertEqual(self.e.definitions['relative homology']['tree'][0:2],['Call','chain homology'])
    def test_dependent_quotient_projection(self):
        actual=self.expr('chain cokernel projection(field,C,D,f)')
        self.assertEqual(actual.type,self.e.type('ChainMap(K,field,D,(chain cokernel(field,C,D,f)))',self.local))
    def test_wrong_complex_direction(self):
        with self.assertRaises(CleanError):self.expr('chain cokernel(field,D,C,f)')
    def test_field_structure_remains_explicit(self):
        with self.assertRaises(CleanError):self.expr('chain cokernel(other,C,D,f)')
        with self.assertRaises(CleanError):self.expr('relative homology(other,H,X,Q)')
    def test_pair_ambient_remains_explicit(self):
        with self.assertRaises(CleanError):self.expr('relative chains(field,H,Y,Q)')
    def test_relative_homology_is_a_module(self):
        self.assertEqual(self.expr('relative homology(field,H,X,Q)').type,
                         self.e.type('CoefficientModule(K,field)',self.local))
    def test_study(self):
        e=Environment();r=load_document(ROOT/'studies/topology/Relative.clean',e)
        self.assertEqual(len(r),4)
        target=lean(r,e,[])
        self.assertNotIn('sorry',target)
        self.assertNotIn('CleanPapers',target)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
