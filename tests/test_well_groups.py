# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
import unittest
from pathlib import Path
from cleanlang.core import Environment, Expr, Expressions, CleanError
from cleanlang.modules import load_module, load_document
ROOT = Path(__file__).resolve().parents[1]

class WellGroups(unittest.TestCase):
    def setUp(self):
        self.e = Environment()
        load_module(ROOT/'library/topology/well_groups.clean', self.e)
        self.local = {}
        for name, typ in [
            ('K','Type'), ('field','FieldStructure(K)'), ('other','FieldStructure(K)'),
            ('H','HomologyTheory(K,field)'), ('Q','InterlevelProblem'),
            ('R','InterlevelProblem'), ('r','Real'), ('s','Real'),
            ('nesting','Evidence((nested pair(Q.space,expanded pair(Q,r))))'),
            ('data','PerturbationCertificate(Q,r)'),
            ('C','CertifiedPerturbation(K,field,H,Q,r,nesting)'),
            ('D','CertifiedPerturbation(K,field,H,Q,r,nesting)')]:
            self.local[name] = Expr(name,name,self.e.type(typ,self.local))
    def expr(self, source):
        return Expressions(self.e,self.local).parse(source)
    def test_header_projection_substitution(self):
        self.assertEqual(self.expr('data.map').type,
                         self.e.type('ContinuousRealMap(Q.space)',self.local))
        self.assertEqual(self.expr('C.data.map').type,
                         self.e.type('ContinuousRealMap(Q.space)',self.local))
        self.assertNotEqual(self.expr('data.map').type,
                            self.e.type('ContinuousRealMap(R.space)',self.local))
    def test_fixed_target(self):
        expected = self.e.type('ModuleSubspace(K,field,(relative homology(field,H,Q.space,perturbation target(Q,r,nesting))))',self.local)
        for source in ['relative well group(field,H,Q,r,nesting)',
                       'perturbation homology image(field,H,Q,r,nesting,C)',
                       'perturbation homology image(field,H,Q,r,nesting,D)']:
            self.assertEqual(self.expr(source).type,expected)
    def test_wrong_indices(self):
        for source in ['perturbation homology image(other,H,Q,r,nesting,C)',
                       'perturbation homology image(field,H,R,r,nesting,C)',
                       'perturbation homology image(field,H,Q,s,nesting,C)',
                       'perturbation pair inclusion(Q,s,nesting,data)']:
            with self.subTest(source=source), self.assertRaises(CleanError):
                self.expr(source)
    def test_authored_compositions(self):
        for name in ['intersection of module family','perturbation target',
                     'perturbation pair inclusion','perturbation homology image','relative well group']:
            self.assertEqual(self.e.definitions[name]['implementation'],'equals')
    def test_study(self):
        e = Environment()
        self.assertEqual(len(load_document(ROOT/'studies/topology/WellGroups.clean',e)),5)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
