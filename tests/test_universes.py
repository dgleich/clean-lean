# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
import unittest
from pathlib import Path
from cleanlang.core import Environment, CleanError, Expr, Type, Expressions
from cleanlang.modules import type_declaration, load_module, universe_level
from cleanlang.structures import declare
ROOT=Path(__file__).resolve().parents[1]

class FixedUniverses(unittest.TestCase):
    def test_canonical_integers(self):
        for value in ['0','1','2','42']:
            self.assertEqual(universe_level({'universe':value}),int(value))
        for value in ['-1','+1','01','1.0','u','max u v','١','1_000','']:
            with self.subTest(value=value),self.assertRaises(CleanError):
                universe_level({'universe':value})
    def test_default_type_target_is_preserved(self):
        for meaning,level in [('Nat',0),('Type',1),('Prop',0)]:
            a,b=Environment(),Environment()
            fields=['Means: '+meaning,'Render latex: T']
            type_declaration('Type T():',fields,a)
            type_declaration('Type T():',fields+['Universe: '+str(level)],b)
            self.assertEqual(a.data,b.data)
            self.assertEqual(a.notation_definitions,b.notation_definitions)
    def test_fixed_high_type(self):
        e=Environment()
        type_declaration('Type Higher():',['Universe: 2','Means: Type 1','Render latex: H'],e)
        self.assertIn(': Type 2 :=\n  Type 1',next(iter(e.notation_definitions.values())))
    def test_alias_rejects_universe(self):
        with self.assertRaisesRegex(CleanError,'alias accepts only'):
            type_declaration('Type T():',['Equals: Real','Universe: 0'],Environment())
    def test_default_structure_target_is_preserved(self):
        a,b=Environment(),Environment()
        for e in [a,b]:load_module(ROOT/'library/types.clean',e)
        fields=['Let value: Real','Constructor: holder']
        declare('Structure Holder():',fields,a)
        declare('Structure Holder():',fields+['Universe: 0'],b)
        self.assertEqual(a.data,b.data)
        self.assertEqual(a.notation_definitions,b.notation_definitions)
    def test_imported_space_and_record(self):
        e=Environment();load_module(ROOT/'library/topology/spaces.clean',e)
        self.assertEqual(e.data['types']['TopologicalSpace']['universe'],1)
        self.assertEqual(e.data['types']['TopologicalDiagram']['universe'],1)
        self.assertIn(': Type 1 where',e.notation_definitions[e.structures['TopologicalDiagram']['key']])
        local={'X':Expr('X','X',Type('TopologicalSpace')),'Y':Expr('Y','Y',Type('TopologicalSpace'))}
        self.assertEqual(Expressions(e,local).parse('identity diagram(X)').type,Type('TopologicalDiagram'))
        with self.assertRaisesRegex(CleanError,'index mismatch'):
            Expressions(e,local).parse('topological diagram(X,Y,identity continuous map(X))')
    def test_higher_universe_does_not_enable_type_fields(self):
        e=Environment();load_module(ROOT/'library/topology/spaces.clean',e)
        with self.assertRaisesRegex(CleanError,'Carrier-type fields'):
            declare('Structure Carrier():',['Universe: 1','Let carrier: Type','Constructor: carrier'],e)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
