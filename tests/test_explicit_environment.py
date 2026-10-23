import subprocess
import sys
import tempfile
import unittest
from pathlib import Path
from cleanlang.core import Environment, CleanError, Expressions, Expr, Type
from cleanlang.modules import load_module, load_document

ROOT=Path(__file__).resolve().parents[1]

class ExplicitEnvironmentTests(unittest.TestCase):
    def setUp(self):
        self.temp=tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root=Path(self.temp.name)

    def module(self,text,env=None):
        env=env if env is not None else Environment()
        path=self.root/'module.clean';path.write_text(text)
        load_module(path,env)
        return env

    def test_empty_means_empty(self):
        env=Environment()
        self.assertEqual(env.data,{'types':{},'aliases':{},'phrases':[],'functions':{}})
        self.assertEqual(env.sources.entries,{})
        self.assertEqual(env.lean_imports,[])
        with self.assertRaisesRegex(CleanError,'Unknown type'): env.type('Natural')
        with self.assertRaisesRegex(CleanError,'Unknown function'): env.call('insertionSort',[])

    def test_no_legacy_files_or_cli_switches(self):
        for file in ['cleanlang/registry.json','build_registry.py','sources.json','imports.json','examples/extensions.json']:
            self.assertFalse((ROOT/file).exists(),file)
        result=subprocess.run([sys.executable,'-m','cleanlang','--help'],cwd=ROOT,capture_output=True,text=True)
        self.assertEqual(result.returncode,0)
        for option in ['--registry','--sources','--imports']: self.assertNotIn(option,result.stdout)

    def test_imports_do_not_leak_between_documents(self):
        imported=Environment()
        load_module(ROOT/'library/standard.clean',imported)
        fresh=Environment()
        path=self.root/'result.clean'
        path.write_text('Result missing imports:\n    Attribution: mathlib; List.length_insertionSort\n    Let xs: List(Natural)\n    Conclude: length(xs) = length(xs)\n')
        with self.assertRaises(CleanError): load_document(path,fresh)

    def test_new_type_and_phrase_need_no_python_changes(self):
        env=self.module('Type Count():\n    Means: Nat\n    Render latex: N\n\nPhrase counting numbers => Count\n')
        self.assertEqual(env.type('counting numbers'),Type('Count'))
        self.assertEqual(env.render_type(env.type('Count'),'lean'),'Nat')

    def test_explicit_source_declaration(self):
        env=self.module('Source local:\n    Kind: other\n    Label: Local notes\n    Title: Working notes\n')
        self.assertEqual(env.sources.resolve({'source':'local','reference':'Claim 1'})['source']['title'],'Working notes')

    def test_unknown_alias_target(self):
        with self.assertRaisesRegex(CleanError,'Unknown alias target'): self.module('Alias Counts: Missing\n')

    def test_bad_type_alias_expansion(self):
        with self.assertRaisesRegex(CleanError,'Unknown type'):
            self.module('Type Counts():\n    Equals: Missing\n')

    def test_generic_list_notation(self):
        env=Environment();load_module(ROOT/'library/algorithms.clean',env)
        expr=Expressions(env,{'xs':Expr('xs','xs',env.type('List(Complex)'))}).parse('length(xs)')
        self.assertEqual(expr.type,Type('Natural'))

    def test_dimension_inference(self):
        env=Environment();load_module(ROOT/'library/linear_algebra.clean',env)
        expr=Expressions(env,{'A':Expr('A','A',env.type('Matrix(2,3,Complex)'))}).parse('transpose(A)')
        self.assertEqual(str(expr.type),'Matrix(3,2,Complex)')

    def test_undeclared_type_parameter(self):
        with self.assertRaisesRegex(CleanError,'Unknown type'):
            self.module('Notation identity(x):\n    Let x: Missing\n    Returns: Missing\n    Means: x\n    Render: {x}\n')

    def test_noninferable_parameter_rejected(self):
        text=f'Import "{ROOT}/library/types.clean"\nNotation bad(x):\n    Let n: Natural\n    Let x: Natural\n    Returns: Natural\n    Means: n\n    Render: {{x}}\n'
        with self.assertRaisesRegex(CleanError,'absent from argument'): self.module(text)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
