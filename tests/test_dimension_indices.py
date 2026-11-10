# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Expressions,CleanError,NAT
from cleanlang.modules import load_module,notation,type_declaration
from cleanlang.conversion import local_definition
from cleanlang.indices import DimensionIndex
ROOT=Path(__file__).resolve().parents[1]
class DimensionIndices(unittest.TestCase):
    def setUp(self):
        self.e=Environment();load_module(ROOT/'library/linear_algebra.clean',self.e)
        self.local={'n':Expr('n','n',NAT),'k':Expr('k','k',NAT)}
        self.local['m']=local_definition('m',self.expr('n'),self.e,self.local)
    def expr(self,s):return Expressions(self.e,self.local).parse(s)
    def typ(self,s):return self.e.type(s,self.local)
    def test_dimension_representation(self):
        d=self.typ('Vector(m,Real)').args[0]
        self.assertIsInstance(d,DimensionIndex)
        self.assertEqual((d.name,d.lean,d.tex,d.comparison_key()),('m','m','m','n'))
        self.assertEqual(d.syntax,'["Local","m"]')
    def test_alias_equality_and_hash(self):
        a,b=self.typ('Vector(n,Real)'),self.typ('Vector(m,Real)')
        self.assertEqual(a,b);self.assertEqual(hash(a),hash(b))
        self.assertNotEqual(self.e.render_type(a,'lean'),self.e.render_type(b,'lean'))
    def test_implicit_dimension_uses_last_consistent_occurrence(self):
        self.local['A']=Expr('A','A',self.typ('Matrix(n,m,Complex)'))
        term=self.expr('det(A)');key=self.e.data['functions']['det']['dependent_signature']['key']
        self.assertEqual(term.lean,'(@_root_.'+key+' (m) (A))')
    def test_different_dimensions_reject(self):
        self.local['A']=Expr('A','A',self.typ('Matrix(n,k,Complex)'))
        with self.assertRaisesRegex(CleanError,'Inconsistent'):self.expr('det(A)')
    def test_explicit_literal_substitution(self):
        notation('Define ident(n: Natural,x: Vector(n,Real)): Vector(n,Real):',['Equals: x'],self.e,authored=True)
        self.local['x']=Expr('x','x',self.typ('Vector(3,Real)'))
        self.assertEqual(self.expr('ident(3,x)').type,self.typ('Vector(3,Real)'))
        with self.assertRaises(CleanError):self.expr('ident(4,x)')
    def test_computation_matches_authored_expansion(self):
        notation('Define dimension(n: Natural): Natural:',['Equals: n'],self.e,authored=True)
        self.assertEqual(self.typ('Vector((dimension(n)),Real)'),self.typ('Vector(n,Real)'))
    def test_arithmetic_is_not_solved(self):
        self.assertNotEqual(self.typ('Vector((n+0),Real)'),self.typ('Vector(n,Real)'))
    def test_literal_alias(self):
        self.local['three']=local_definition('three',self.expr('3'),self.e,self.local)
        self.assertEqual(self.typ('Vector(three,Real)'),self.typ('Vector(3,Real)'))
    def test_negative_and_real_dimensions_reject(self):
        self.local['a']=Expr('a','a',self.typ('Real'))
        with self.assertRaises(CleanError):self.typ('Vector(a,Real)')
        for text in ['Vector(-1,Real)','Vector((-1),Real)','Vector((-n),Real)',
                     'Vector((n + (-1)),Real)']:
            with self.subTest(text=text),self.assertRaises(CleanError):self.typ(text)
    def test_determined_literal_sum_is_a_dimension_without_arithmetic_solving(self):
        dimension=self.typ('Vector((1+1),Real)').args[0]
        add=self.e.data['functions']['natural sum']['native_binding']
        numeral=self.e.data['types']['Natural']['numerals']['native_binding']
        one='(_root_.'+numeral+' (nat_lit 1))'
        self.assertEqual(dimension.lean,'(_root_.'+add+' ('+one+') ('+one+'))')
        self.assertNotEqual(self.typ('Vector((1+1),Real)'),self.typ('Vector(2,Real)'))
    def test_bound_dimension_preserves_lean_identity(self):
        result=self.expr('for every (j: Natural, for every (v: Vector(j,Real), v = v))')
        vector=self.e.data['types']['Vector']['native_binding']
        self.assertIn(f'_root_.{vector} (clean_bound_0)',result.lean)
        self.assertNotIn(f'_root_.{vector} (j)',result.lean)
    def test_dimension_from_dependent_record_field(self):
        from cleanlang.structures import declare
        declare('Structure Sized():',['Let size: Natural','Let vector: Vector(size,Real)',
          'Constructor: sized'],self.e)
        notation('Define keep vector(x):',['Let n: Natural','Let x: Vector(n,Real)',
          'Returns: Vector(n,Real)','Equals: x'],self.e,authored=True)
        self.local['S']=Expr('S','S',self.typ('Sized'))
        self.assertEqual(self.expr('keep vector(S.vector)').type,self.typ('Vector(S.size,Real)'))

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
