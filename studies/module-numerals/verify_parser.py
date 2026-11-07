# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Independent numeral syntax oracles on the isolated parser-only extension."""
from pathlib import Path
import sys
import unittest
from unittest.mock import patch
COMPILER=Path(sys.argv.pop(1)).resolve()
sys.path.insert(0,str(COMPILER))
from cleanlang import syntax
from cleanlang.core import CleanError,Environment,Expressions,normalize_layout
from cleanlang.modules import fields_map,type_declaration

class NumeralSyntax(unittest.TestCase):
    def tree(self,source):return syntax.expression_tree(syntax.parse(source,'expression'))

    def test_closed_carrier_tree_preserves_spelling(self):
        self.assertEqual(self.tree('(001: Real)'),['NumeralAnnotation','001',['Name','Real']])
        self.assertEqual(self.tree('(1: Renamed)'),['NumeralAnnotation','1',['Name','Renamed']])

    def test_operator_parse_precedes_type_lookup(self):
        a=['NumeralAnnotation','1',['Name','Real']]
        b=['NumeralAnnotation','2',['Name','Real']]
        with patch.object(Environment,'type',side_effect=AssertionError('Binding during parsing')):
            self.assertEqual(self.tree('-(1: Real) + (2: Real)'),['Operator','+',['Unary','-',a],b])

    def test_type_syntax_is_neutral(self):
        self.assertEqual(self.tree('(1: Matrix(n,n,Real))'),
            ['NumeralAnnotation','1',['Apply','Matrix',[['Name','n'],['Name','n'],['Name','Real']]]])
        self.assertEqual(self.tree('(1: Unknown((f(x))))'),
            ['NumeralAnnotation','1',['Apply','Unknown',[['ComputedIndex',['Call','f',[['Local','x']]]]]]])

    def test_nested_call_and_grouping(self):
        self.assertEqual(self.tree('f(((1: Real)),x)'),
            ['Call','f',[['NumeralAnnotation','1',['Name','Real']],['Local','x']]])
        self.assertEqual(self.tree('(1)'),['Decimal','1'])

    def test_binder_and_annotation_colons(self):
        self.assertEqual(self.tree('function(x: Real,x+(1: Real))'),
            ['Lambda','x','Real',['Operator','+',['Local','x'],['NumeralAnnotation','1',['Name','Real']]]])

    def test_ascii_validation(self):
        for text in ['(١: Real)','(１２: Real)','(1١: Real)']:
            with self.subTest(text=text),self.assertRaisesRegex(CleanError,'ASCII digits'):
                self.tree(text)
        # Unannotated syntax retains the existing NUMBER policy.
        self.assertEqual(self.tree('١'),['Decimal','١'])

    def test_unsupported_forms_reject(self):
        for text in ['(x: Real)','(-1: Real)','(1.5: Real)','(1:)', '(1::Real)','(1: Real: Real)']:
            with self.subTest(text=text),self.assertRaises(CleanError):self.tree(text)

    def test_no_integer_conversion_during_parsing(self):
        digits='9'*5000
        self.assertEqual(self.tree('('+digits+': Real)'),['NumeralAnnotation',digits,['Name','Real']])

    def test_metadata_case_duplicates_and_empty_values(self):
        self.assertEqual(fields_map(['nUmErAlS: fun n : Nat => n']),{'numerals':'fun n : Nat => n'})
        for fields in [['Numerals: n','NUMERALS: n'],['Numerals:']]:
            with self.assertRaises(CleanError):fields_map(fields)

    def test_layout_continuation(self):
        text='Result example:\n  Attribution: local; example\n  Conclude: x = (\n    1: Real\n  )\n'
        node=syntax.document(normalize_layout(text))[0]
        conclusion=node.children[-1]
        self.assertEqual(syntax.expression_tree(conclusion.payload),
            ['Operator','=', ['Local','x'],['NumeralAnnotation','1',['Name','Real']]])

    def test_binding_not_silently_accepted(self):
        with self.assertRaisesRegex(CleanError,'binding is not implemented'):
            Expressions(Environment(),{}).parse('(1: Real)')
        env=Environment()
        with self.assertRaises(CleanError):
            type_declaration('Type Real():',['Means: Real','Numerals: fun n : Nat => n','Render latex: R'],env)
        self.assertNotIn('Real',env.data['types'])

if __name__=='__main__':unittest.main()

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
