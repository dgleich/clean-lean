# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Expressions,CleanError
from cleanlang.modules import load_module
from cleanlang.syntax import parse,expression_tree
ROOT=Path(__file__).resolve().parents[1]

class DiagramMaps(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.e=Environment();load_module(ROOT/'library/algebra/diagram_maps.clean',cls.e)
    def setUp(self):
        self.local={}
        for name,typ in [('K','Type'),('field','FieldStructure(K)'),('V','Type'),('E','Type'),
            ('Q','DiagramShape(V,E)'),('X','ModuleDiagram(K,field,V,E,Q)'),
            ('Y','ModuleDiagram(K,field,V,E,Q)'),('Z','ModuleDiagram(K,field,V,E,Q)'),
            ('f','ModuleDiagramMap(K,field,V,E,Q,X,Y)'),('g','ModuleDiagramMap(K,field,V,E,Q,Y,Z)'),
            ('v','V')]:
            self.local[name]=Expr(name,name,self.e.type(typ,self.local),tree=['Local',name])
    def expr(self,s):return Expressions(self.e,self.local).parse(s)
    def test_dependent_component_and_proof_fields(self):
        self.assertEqual([name for name,typ in self.e.structures['ModuleDiagramMap']['fields']],
                         ['component','commutes'])
        self.assertEqual(self.expr('f.component(v)').type,
            self.e.type('ModuleMap(K,field,(X.object(v)),(Y.object(v)))',self.local))
    def test_independent_call_tree(self):
        source='diagram composite components(K,field,V,E,Q,X,Y,Z,f,g)'
        self.assertEqual(expression_tree(parse(source,'expression')),
            ['Call','diagram composite components',[['Local',x] for x in ['K','field','V','E','Q','X','Y','Z','f','g']]])
    def test_composite_direction(self):
        result=self.expr('diagram composite components(K,field,V,E,Q,X,Y,Z,f,g)')
        self.assertEqual(result.type,self.e.type('Function(w: V,ModuleMap(K,field,(X.object(w)),(Z.object(w))))',self.local))
        with self.assertRaises(CleanError):
            self.expr('diagram composite components(K,field,V,E,Q,X,Y,Z,g,f)')
    def test_evidence_cannot_be_omitted(self):
        with self.assertRaises(CleanError):
            self.expr('certified diagram identity(K,field,V,E,Q,X)')
    def test_wrong_endpoints_rejected(self):
        with self.assertRaises(CleanError):
            self.expr('diagram map(K,field,V,E,Q,X,Z,f.component,f.commutes)')
    def test_constructions_are_authored(self):
        for name in ['diagram identity components','diagram composite components',
                     'certified diagram identity','certified diagram composition','diagram maps commute']:
            self.assertEqual(self.e.definitions[name]['implementation'],'equals')

    def test_wrong_shape_index_rejected(self):
        self.local['R']=Expr('R','R',self.e.type('DiagramShape(V,E)',self.local),tree=['Local','R'])
        with self.assertRaises(CleanError):
            self.expr('diagram composite components(K,field,V,E,R,X,Y,Z,f,g)')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
