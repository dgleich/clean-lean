# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Syntax and semantic oracles for named values in type applications."""
import unittest
from pathlib import Path
from cleanlang import syntax
from cleanlang.core import Environment, Expr, Type, LocalType, ValueIndex, Expressions, CleanError, lean, latex
from cleanlang.modules import load_module, load_document, type_declaration, notation
ROOT=Path(__file__).resolve().parents[1]

class ValueIndices(unittest.TestCase):
    def setUp(self):
        self.e=Environment();load_module(ROOT/'library/topology/indexed.clean',self.e)
        X=LocalType('X',(), 'X')
        self.locals={'X':Expr('X','X',Type('Type')),
                     't':Expr('t','t',Type('Topology',(X,))),
                     'x':Expr('x','x',X),'y':Expr('y','y',X),
                     'S':Expr('S','S',Type('Set',(X,))),
                     'T':Expr('T','T',Type('Set',(X,)))}
    def test_ascii_and_unicode_comparisons_normalize_identically(self):
        for ascii_op, unicode_op in [('<=','≤'),('>=','≥'),('!=','≠')]:
            a=syntax.expression_tree(syntax.parse('x'+ascii_op+'y','expression'))
            b=syntax.expression_tree(syntax.parse('x'+unicode_op+'y','expression'))
            self.assertEqual(a,b)

    def test_neutral_syntax_has_no_type_lookup(self):
        for source,expected in [
            ('IntervalBasis(Z)',['Apply','IntervalBasis',[['Name','Z']]]),
            ('Path(X,x,y)',['Apply','Path',[['Name','X'],['Name','x'],['Name','y']]]),
            ('Matrix(n,3,Complex)',['Apply','Matrix',[['Name','n'],['Numeral','3'],['Name','Complex']]]),
            ('Function(X,Element(X,S))',['Apply','Function',[['Name','X'],['Apply','Element',[['Name','X'],['Name','S']]]]])]:
            self.assertEqual(syntax.type_tree(syntax.parse(source,'type_ref')),expected)
    def test_structural_errors(self):
        for source in ['Path(X,,y)','Path(X,x,y,)','Path(X,x,y','Path(X,x+1,y)','IntervalBasis(bottom zigzag(P))']:
            with self.subTest(source=source),self.assertRaises(CleanError):syntax.parse(source,'type_ref')
    def test_binding_and_explicit_target(self):
        t=self.e.type('Path(X,t,x,y)',self.locals)
        self.assertEqual(t,Type('Path',(LocalType('X',(), 'X'),ValueIndex('t','t','t'),ValueIndex('x','x','x'),ValueIndex('y','y','y'))))
        key=self.e.data['types']['Path']['native_binding']
        self.assertEqual(self.e.render_type(t,'lean'),f'(_root_.{key} (X) (t) (x) (y))')
    def test_prose_equivalence(self):
        a=self.e.type('Path(X,t,x,y)',self.locals)
        b=self.e.type('a path from x to y in X with topology t',self.locals)
        self.assertEqual(a,b)
        self.assertEqual(self.e.type('an element of S in X',self.locals),self.e.type('Element(X,S)',self.locals))
    def test_prose_preserves_capture_case(self):
        with self.assertRaises(CleanError):self.e.type('a path from X to y in X with topology t',self.locals)
    def test_bad_dependencies_parse_then_fail(self):
        for source in ['Path(X,missing,x,y)','Path(X,S,x,y)','Path(X,t,S,y)','Path(X,t,x)','Element(X,x)', 'Element(X,0)']:
            syntax.parse(source,'type_ref')
            with self.subTest(source=source),self.assertRaises(CleanError):self.e.type(source,self.locals)
    def test_no_expression_indices_yet(self):
        syntax.parse('Element(X,inverse(S))','type_ref')
        with self.assertRaisesRegex(CleanError,'previously declared name'):
            self.e.type('Element(X,inverse(S))',self.locals)
    def test_no_guessing_among_phrases(self):
        self.e.data['phrases'].append({'pattern':r'element of (?P<S>\w+) in (?P<X>\w+)', 'type':'Real'})
        with self.assertRaisesRegex(CleanError,'Ambiguous'):
            self.e.type('an element of S in X',self.locals)
    def test_canonical_application_cannot_be_hijacked_by_phrase(self):
        self.e.data['phrases'].append({'pattern':r'Element\(.*\)','type':'Real'})
        self.assertEqual(self.e.type('Element(X,S)',self.locals).name,'Element')
    def test_different_ambient_indices_are_rejected(self):
        a=self.e.type('Element(X,S)',self.locals);b=self.e.type('Element(X,T)',self.locals)
        self.assertNotEqual(a,b)
        same=Expressions(self.e,{'a':Expr('a','a',a),'b':Expr('b','b',a)}).parse('a=b')
        self.assertEqual(same.type,Type('Proposition'))
        with self.assertRaisesRegex(CleanError,'No declared meaning for operator ='):
            Expressions(self.e,{'a':Expr('a','a',a),'b':Expr('b','b',b)}).parse('a=b')
    def test_nested_quantifier_capture(self):
        e=Expressions(self.e,self.locals).parse('for every (z: X, there exists (p: Path(X,t,z,z), p=p))')
        key=self.e.data['types']['Path']['native_binding']
        self.assertIn(f'_root_.{key} (X) (t) (clean_bound_0) (clean_bound_0)',e.lean)
        self.assertNotIn(f'_root_.{key} (X) (t) (z) (z)',e.lean)
    def test_ordered_declaration_dependencies(self):
        with self.assertRaises(CleanError):type_declaration('Type Bad(S: Set(X), X: Type):',['Means: Unit','Render latex: bad'],self.e)
        with self.assertRaises(CleanError):type_declaration('Type Bad(S: Set(S)):',['Means: Unit','Render latex: bad'],self.e)
    def test_alias_preserves_indices(self):
        type_declaration('Type Member(X: Type, S: Set(X)):', ['Equals: Element(X,S)'],self.e)
        self.assertEqual(self.e.type('Member(X,S)',self.locals),self.e.type('Element(X,S)',self.locals))
    def test_callable_preserves_indexed_parameter(self):
        notation('Notation forget(S,x):',['Let X: Type','Let S: Set(X)','Let x: Element(X,S)',
            'Returns: X','Means: x.val','Render latex: {x}'],self.e)
        locals={**self.locals,'a':Expr('a','a',self.e.type('Element(X,S)',self.locals))}
        self.assertEqual(Expressions(self.e,locals).parse('forget(S,a)').type,LocalType('X',(), 'X'))
    def test_real_study_parses_and_renders(self):
        e=Environment();rs=load_document(ROOT/'studies/topology/ValueIndices.clean',e)
        self.assertEqual(len(rs),4)
        self.assertIn('a path from $x$ to $y$',latex(rs,e))
        key=e.data['types']['Path']['native_binding']
        self.assertIn(f'_root_.{key} (X) (t) (clean_bound_0) (clean_bound_0)',lean(rs,e,[]))

# generated: gpt-6 2026-11-06 role=assisted; LLM-authored portions; see PROVENANCE.md
