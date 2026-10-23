import tempfile
import unittest
from pathlib import Path
from cleanlang.core import Environment, CleanError, lean
from cleanlang.modules import load_module, signature_fields

ROOT=Path(__file__).resolve().parents[1]
IMPORT=f'Import "{ROOT}/library/types.clean"\n'

class CompactSignatureTests(unittest.TestCase):
    def load(self,source):
        env=Environment()
        with tempfile.TemporaryDirectory() as folder:
            path=Path(folder)/'sample.clean';path.write_text(IMPORT+source)
            load_module(path,env)
        return env

    def equivalent(self,compact,expanded,name):
        a,b=self.load(compact),self.load(expanded)
        self.assertEqual(a.data['functions'][name],b.data['functions'][name])
        self.assertEqual(a.notation_definitions,b.notation_definitions)
        self.assertEqual(lean([],a,[]),lean([],b,[]))
        return a

    def test_normalization_before_type_resolution(self):
        self.assertEqual(signature_fields('Notation apply(f: Function(Real,Real), x: Real): Real:',
                         ['Means: f x', 'Render: apply({f},{x})']),
            ('apply', ['f','x'], ['Let f: Function(Real,Real)', 'Let x: Real', 'Returns: Real',
                                'Means: f x', 'Render: apply({f},{x})']))

    def test_cosine_signature_and_target(self):
        body='  Means: Real.cos x\n  Render latex: \\cos({x})\n'
        env=self.equivalent('Notation cosine(x: Real): Real:\n'+body,
            'Notation cosine(x):\n  Let x: Real\n  Returns: Real\n'+body,'cosine')
        self.assertEqual(env.data['functions']['cosine']['signature_tree'],
            ['Signature','cosine',[['Parameter','x','Real','explicit']],'Real'])

    def test_define_body_tree_and_target(self):
        env=self.equivalent('Define doubled(x: Real): Real:\n  Equals: x+x\n',
            'Define doubled(x):\n  Equals: x+x\n  Returns: Real\n  Let x be a Real\n','doubled')
        self.assertEqual(env.definitions['doubled']['tree'],['Operator','+',['Local','x'],['Local','x']])

    def test_nested_types_and_multiline_header(self):
        body='  Equals: f(x)\n'
        env=self.equivalent('Define apply(\n  f: Function(Real,Real),\n  x: Real\n): Real:\n'+body,
            'Define apply(f,x):\n  Let f: Function(Real,Real)\n  Let x: Real\n  Returns: Real\n'+body,'apply')
        self.assertEqual(env.data['functions']['apply']['signature_tree'][2][0],
            ['Parameter','f','Function(Real,Real)','explicit'])

    def test_multiline_notation(self):
        self.equivalent('Notation c(\n  x: Real\n): Real:\n  Means: Real.cos x\n  Render: c({x})\n',
            'Notation c(x):\n  Let x: Real\n  Returns: Real\n  Means: Real.cos x\n  Render: c({x})\n','c')

    def test_nullary_and_nested_return(self):
        self.equivalent('Define zero(): Real:\n  Equals: 0\n',
            'Define zero():\n  Returns: Real\n  Equals: 0\n','zero')
        self.equivalent('Define identity(f: Function(Real,Real)): Function(Real,Real):\n  Equals: f\n',
            'Define identity(f):\n  Let f: Function(Real,Real)\n  Returns: Function(Real,Real)\n  Equals: f\n','identity')

    def test_case_and_prose(self):
        self.equivalent('dEfInE same(x: a Real): a Real:\n  Equals: x\n',
            'Define same(x):\n  Let x be a Real\n  Returns: a Real\n  Equals: x\n','same')

    def test_inline_adapter(self):
        self.equivalent('Define cos(x: Real): Real:\n  From Lean: Real.cos x\n',
            'Define cos(x):\n  Let x: Real\n  Returns: Real\n  From Lean: Real.cos x\n','cos')

    def test_invalid_headers_and_mixing(self):
        cases=[
            'Define f(x: Real): Real:\n  Let y: Real\n  Equals: x',
            'Define f(x: Real): Real:\n  Returns: Real\n  Equals: x',
            'Define f(x: Real, y): Real:\n  Equals: x',
            'Define f(x, y: Real): Real:\n  Equals: x',
            'Define f(x: Real):\n  Returns: Real\n  Equals: x',
            'Define f(x): Real:\n  Equals: x',
            'Define f(x: Real,): Real:\n  Equals: x',
            'Define f(x: Real,, y: Real): Real:\n  Equals: x',
            'Define f(x: Real, x: Real): Real:\n  Equals: x',
            'Define f(x::Real)::Real:\n  Equals: x',
            'Define f(x: Real): Real\n  Equals: x',
            'Define f(x: Real): :\n  Equals: x',
            'Define f(A: Matrix(n,n,Complex)): Matrix(n,n,Complex):\n  Equals: A',
            'Define f(x: Real): Proposition:\n  Equals: x',
        ]
        for case in cases:
            with self.subTest(case=case),self.assertRaises(CleanError):self.load(case)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
