# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang import syntax
from cleanlang.core import Environment,CleanError,normalize_layout
from cleanlang.modules import load_module
ROOT=Path(__file__).resolve().parents[1]
class DependentTypeSyntax(unittest.TestCase):
    def tree(self,s):return syntax.type_tree(syntax.parse(s,'type_ref'))
    def test_bound_type_tree(self):
        self.assertEqual(self.tree('Function(n: Natural, Vector(n,Real))'),
          ['BoundTypeApply','Function','n',['Name','Natural'],
           ['Apply','Vector',[['Name','n'],['Name','Real']]]])
    def test_head_is_not_semantically_selected_by_parser(self):
        self.assertEqual(self.tree('Mapping(n: Natural, Vector(n,Real))')[1],'Mapping')
        self.assertEqual(self.tree('Unknown(n: Natural, Other(n))')[0],'BoundTypeApply')
    def test_nested_binders_and_domain_commas(self):
        self.assertEqual(self.tree('Function(x: Matrix(n,n,Real), Function(y: Vector(n,Real), Vector(n,Real)))')[4][0],
          'BoundTypeApply')
    def test_spelling_roundtrip(self):
        s='Function(n: Natural,Function(x: Vector(n,Real),Vector(n,Real)))'
        tree=syntax.parse(s,'type_ref')
        self.assertEqual(self.tree(s),self.tree(syntax.type_spelling(tree)))
    def test_ordinary_function_type_unchanged(self):
        self.assertEqual(self.tree('Function(Natural,Real)'),
          ['Apply','Function',[['Name','Natural'],['Name','Real']]])
    def test_let_and_compact_header_envelopes(self):
        self.assertEqual(syntax.let_clause('Let f: Function(n: Natural,Vector(n,Real))'),
          ('let',['f'],'Function(n: Natural,Vector(n,Real))'))
        self.assertEqual(syntax.header('Notation use(f: Function(n: Natural,Vector(n,Real))): Natural:')[2],
          [('f','Function(n: Natural,Vector(n,Real))')])
    def test_lambda_domain(self):
        tree=syntax.expression_tree(syntax.parse('function(f: Function(n: Natural,Vector(n,Real)),f(k))','expression'))
        self.assertEqual(tree,['Lambda','f','Function(n: Natural,Vector(n,Real))',['Call','f',[['Local','k']]]])
    def test_malformed_forms_reject(self):
        for s in ['Function(n: Natural)','Function(n: Natural,Real,Real)',
                  'Function(n: Natural: Real,Real)','Function(n Natural,Real)',
                  'Function(n: ,Real)','Function(: Natural,Real)']:
            with self.subTest(s=s),self.assertRaises(CleanError):self.tree(s)
    def test_semantics_are_explicitly_unimplemented(self):
        e=Environment();load_module(ROOT/'library/types.clean',e)
        with self.assertRaisesRegex(CleanError,'parsed but not implemented'):
            e.type('Function(n: Natural,Vector(n,Real))')
    def test_multiline_document_grammar(self):
        source='''Result family:
  Attribution: test; parser; original
  Let f: Function(n: Natural,
    Vector(n,Real))
  Conclude: f = f
'''
        syntax.document(normalize_layout(source))

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
    def test_complete_proposed_graded_map_parses(self):
        source=(ROOT/'studies/dependent-functions/Proposed.clean.txt').read_text()
        syntax.document(normalize_layout(source))
