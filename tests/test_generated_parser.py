# generated: gpt-6 2026-11-05 role=assisted; LLM-authored portions; see PROVENANCE.md
"""Independent syntax oracles; no binding environment chooses a parse."""
import hashlib
import unittest
from pathlib import Path
from unittest.mock import patch
from cleanlang import syntax, generated_parser
from cleanlang.core import CleanError, Environment, Expressions, normalize_layout
ROOT=Path(__file__).resolve().parents[1]

class GeneratedSyntax(unittest.TestCase):
    def expression(self,text):return syntax.expression_tree(syntax.parse(text,'expression'))

    def test_precedence_and_right_associativity(self):
        x=['Local','x'];y=['Local','y'];z=['Local','z']
        self.assertEqual(self.expression('-x^y^z + x*y'),
                         ['Operator','+',['Unary','-',['Operator','^',x,['Operator','^',y,z]]],['Operator','*',x,y]])
        self.assertEqual(self.expression('P → Q → R'),
                         ['Operator','→',['Local','P'],['Operator','→',['Local','Q'],['Local','R']]])
        self.assertEqual(self.expression('not x = y and P'),
                         ['Operator','∧',['Unary','not',['Operator','=',x,y]],['Local','P']])

    def test_unknown_multiword_call_parses_before_binding(self):
        source='previously unknown operation(x, y)'
        self.assertEqual(self.expression(source),['Call','previously unknown operation',[['Local','x'],['Local','y']]])
        with self.assertRaisesRegex(CleanError,'Unknown name'):
            Expressions(Environment(),{}).parse(source)

    def test_grouped_assumptions_nested_lambda_and_colon(self):
        parsed=syntax.parse('related(A,B), chosen: accepts(function(x: Real,x > 0))','assumptions')
        self.assertEqual(len(parsed.children),2)
        self.assertEqual(syntax.expression_tree(parsed.children[0].children[-1]),
                         ['Call','related',[['Local','A'],['Local','B']]])
        self.assertEqual(syntax.name(parsed.children[1].children[0]),'chosen')
        self.assertEqual(syntax.expression_tree(parsed.children[1].children[-1]),
                         ['Call','accepts',[['Lambda','x','Real',['Operator','>',['Local','x'],['Decimal','0']]]]])

    def test_signature_types_are_balanced_before_binding(self):
        self.assertEqual(syntax.header('Define apply(f: Function(Real,Real), x: Real): Real:'),
                         ('define','apply',[('f','Function(Real,Real)'),('x','Real')],'Real'))
        self.assertEqual(syntax.type_spelling(syntax.parse('Natural()','type_ref')),'Natural')

    def test_document_shape_and_source_locations(self):
        text='''# A comment
Condition positive(x: Real):
  Holds when: x > 0
  Assumption name: positivity of {x}

Context values:
   Let x: Real
   Assume positive(x)
   Result conclusion:
      Attribution: source; reference
      Conclude: positive(x)
'''
        nodes=syntax.document(normalize_layout(text))
        self.assertEqual([(n.kind,n.line) for n in nodes],[('declaration',2),('context',6)])
        self.assertEqual([(n.kind,n.line) for n in nodes[1].children],
                         [('context_let',7),('context_assume',8),('result',9)])
        body=nodes[0].children[0].payload
        self.assertEqual(syntax.expression_tree(body),['Operator','>',['Local','x'],['Decimal','0']])

    def test_document_validates_expression_before_binding(self):
        for body in ['unknown(', 'x + * y','f(x,,y)']:
            text=f'Result test:\n  Attribution: s; r\n  Conclude: {body}\n'
            with self.subTest(body=body),self.assertRaises(CleanError):
                syntax.document(normalize_layout(text))

    def test_result_conclusion_must_be_final(self):
        for body in ['  Let x: Real\n', '  Conclude: x = x\n  Let x: Real\n']:
            with self.assertRaises(CleanError):
                syntax.document(normalize_layout('Result test:\n'+body))

    def test_keywords_do_not_split_identifiers(self):
        for name in ['notable','ordinary','anderson','functionality']:
            self.assertEqual(self.expression(name+'(x)'),['Call',name,[['Local','x']]])
        self.assertEqual(self.expression('NOT P'),['Unary','not',['Local','P']])
        with self.assertRaises(CleanError):syntax.header('Define round and sort(x):')

    def test_opaque_lean_latex_and_templates_are_not_clean_expressions(self):
        for field in ['Means: by classical exact xs.filter (fun x => decide (p x))',
                      'Render latex: {x}\\text{{ is positive }}',
                      'Assumption name: condition: {x}, or {y}']:
            tree=syntax.parse(field,'field')
            self.assertEqual(str(tree.children[1]),field.split(':',1)[1].strip())

    def test_rejects_empty_list_items_and_semicolons(self):
        for text in ['p(x),','p(x),,p(y)','p(x);p(y)','label: : p(x)']:
            with self.subTest(text=text),self.assertRaises(CleanError):syntax.parse(text,'assumptions')

    def test_resource_failure_is_incomplete(self):
        with patch.object(syntax._PARSER,'parse',side_effect=MemoryError):
            with self.assertRaisesRegex(CleanError,'Incomplete syntax analysis'):
                syntax.parse('x','expression')

    def test_generated_source_fingerprint(self):
        digest=hashlib.sha256((ROOT/'grammar/clean.lark').read_bytes()).hexdigest()
        self.assertIn('# Grammar SHA256: '+digest,(ROOT/'cleanlang/generated_parser.py').read_text())
        self.assertEqual(generated_parser.__version__,'1.3.1')

    def test_no_runtime_dependency_on_lark(self):
        import sys
        self.assertNotIn('lark',sys.modules)

    def test_generator_rejects_grammar_and_lexer_conflicts(self):
        import importlib.util, subprocess, sys
        if importlib.util.find_spec('lark') is None:self.skipTest('Install the parser development extra')
        program = '''from lark import Lark
from lark.exceptions import GrammarError, LexError
for grammar in ['start: a | b\\na: "x"\\nb: "x"', 'start: A | B\\nA: /a+/\\nB: /[a]+/']:
    try:
        Lark(grammar, parser="lalr", strict=True)
    except (GrammarError, LexError):
        pass
    else:
        raise AssertionError("A competing parse/tokenization was silently chosen")
'''
        subprocess.run([sys.executable,'-c',program],check=True)

    def test_generation_is_reproducible(self):
        import importlib.util, subprocess, sys
        if importlib.util.find_spec('lark') is None:self.skipTest('Install the parser development extra')
        subprocess.run([sys.executable,str(ROOT/'tools/generate_parser.py'),'--check'],check=True)

    def test_unanalyzed_regex_is_not_success(self):
        import importlib.util, subprocess, sys
        if importlib.util.find_spec('interegular') is None:self.skipTest('Install the parser development extra')
        program='''from tools.generate_parser import require_lexical_analysis
try:
    require_lexical_analysis({"unsupported": r"word\\b"})
except RuntimeError as e:
    assert "Incomplete lexical analysis" in str(e)
else:
    raise AssertionError("Unanalyzed regex accepted")
'''
        subprocess.run([sys.executable,'-c',program],cwd=ROOT,check=True)

    def test_alias_type_names_are_not_expression_keywords(self):
        tree=syntax.parse('Alias Mapping: Function','alias_line')
        self.assertEqual(list(map(str,tree.children)),['Mapping','Function'])
