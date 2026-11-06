# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Expressions,CleanError,lean
from cleanlang.modules import load_module,load_document
ROOT=Path(__file__).resolve().parents[1]
class ChainSquares(unittest.TestCase):
    def setUp(self):
        self.e=Environment();load_module(ROOT/'library/topology/pair_chain_squares.clean',self.e)
        self.local={}
        for name,typ in [('K','Type'),('field','FieldStructure(K)'),('H','HomologyTheory(K,field)'),
                         ('X','TopologicalSpace'),('Y','TopologicalSpace'),('Q','PairInclusion(X)'),
                         ('C','ModuleChainComplex(K,field)'),('D','ModuleChainComplex(K,field)'),
                         ('E','ModuleChainComplex(K,field)'),('F','ModuleChainComplex(K,field)'),
                         ('f','ChainMap(K,field,C,D)'),('g','ChainMap(K,field,E,F)'),
                         ('p','ChainMap(K,field,C,E)'),('q','ChainMap(K,field,D,F)'),
                         ('h','(compose chain maps(field,C,D,F,q,f) = compose chain maps(field,C,E,F,g,p))'),
                         ('S','ChainSquare(K,field,C,D,E,F)'),('n','Natural')]:
            self.local[name]=Expr(name,name,self.e.type(typ,self.local))
    def expr(self,s):return Expressions(self.e,self.local).parse(s)
    def test_constructor_checks_all_maps(self):
        self.assertEqual(self.expr('chain square(K,field,C,D,E,F,f,g,p,q,h)').type,self.local['S'].type)
        with self.assertRaises(CleanError):self.expr('chain square(K,field,C,D,E,F,f,g,q,p,h)')
    def test_wrong_commutativity_evidence(self):
        t=self.e.type('(compose chain maps(field,C,E,F,g,p) = compose chain maps(field,C,D,F,q,f))',self.local)
        self.local['wrong']=Expr('wrong','wrong',t)
        with self.assertRaises(CleanError):self.expr('chain square(K,field,C,D,E,F,f,g,p,q,wrong)')
    def test_quotient_endpoints(self):
        actual=self.expr('square quotient map(field,C,D,E,F,S)')
        self.assertEqual(actual.type,self.e.type('ChainMap(K,field,(chain cokernel(field,C,D,S.source)),(chain cokernel(field,E,F,S.target)))',self.local))
    def test_square_stores_actual_evidence(self):
        fields=self.e.structures['ChainSquare']['fields']
        self.assertEqual([n for n,_ in fields],['source','target','left','right','commutes'])
        self.assertEqual(self.expr('chain square(K,field,C,D,E,F,f,g,p,q,h).commutes').lean,'h')
    def test_pair_corners_are_actual_singular_chains(self):
        t=self.e.type('PairChainSquare(K,field,H,X,Q)',self.local)
        self.assertEqual(t.name,'ChainSquare')
        self.assertIn('Q.source.relative',str(t))
        self.assertIn('Q.target.ambient',str(t))
    def test_wrong_ambient_pair(self):
        with self.assertRaises(CleanError):self.expr('ambient chain map(field,H,Y,Q)')
    def test_homology_map_keeps_degree_and_ambient(self):
        t=self.expr('square homology map(field,C,D,E,F,S,n)').type
        self.assertEqual(t,self.e.type('ModuleMap(K,field,(chain homology(field,chain cokernel(field,C,D,S.source),n)),(chain homology(field,chain cokernel(field,E,F,S.target),n)))',self.local))
    def test_authored_interfaces(self):
        for name in ['square quotient map','square homology map','ambient chain map','relative subset chain map','square represents pair inclusion']:
            self.assertEqual(self.e.definitions[name]['implementation'],'equals')
    def test_study(self):
        e=Environment();r=load_document(ROOT/'studies/topology/ChainSquares.clean',e)
        self.assertEqual(len(r),2)
        self.assertNotIn('sorry',lean(r,e,[]))

    def test_wrong_degree_cannot_supply_a_class(self):
        self.local['m']=Expr('m','m',self.e.type('Natural'))
        self.local['x']=Expr('x','x',self.e.type('ModuleElement(K,field,(chain homology(field,C,n)))',self.local))
        with self.assertRaises(CleanError):
            self.expr('module map value(field,chain homology(field,C,n),chain homology(field,D,n),induced chain homology map(field,C,D,f,m),x)')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
