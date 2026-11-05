# generated: gpt-6 2026-11-05 role=assisted; LLM-authored portions; see PROVENANCE.md
import tempfile
import unittest
from pathlib import Path
from cleanlang.core import CleanError, Environment, lean, latex, normalize_layout
from cleanlang.modules import load_document, load_module
from cleanlang.literate import Prose, scan
from cleanlang.syntax import document

ROOT=Path(__file__).resolve().parents[1]
IMPORT=f'Import "{ROOT}/library/linear_algebra.clean"\nImport "{ROOT}/library/sources.clean"\n'
RESULT='''Result determinant product:
  Attribution: mathlib; Matrix.det_mul; specialized
  Let n: Natural
  Let A,B: Matrix(n,n,Complex)
  Conclude: det(A*B) = det(A)*det(B)
'''

class LiterateTests(unittest.TestCase):
    def load(self, source):
        with tempfile.TemporaryDirectory() as tmp:
            path=Path(tmp)/'paper.clean';path.write_text(source)
            env=Environment();return load_document(path,env),env

    def nodes(self,source): return document(normalize_layout(source))

    def test_independent_payload_oracle_and_equivalent_forms(self):
        forms=['Text latex:\n  \\section{Matrices}\n  x -- prose\n',
               '"""latex\n\\section{Matrices}\nx -- prose\n"""\n']
        for source in forms:
            nodes=self.nodes(source)
            self.assertEqual(len(nodes),1)
            self.assertEqual(nodes[0].kind,'prose')
            self.assertEqual(nodes[0].payload,Prose('latex','\\section{Matrices}\nx -- prose',1))
        a,ea=self.load(forms[0]);b,eb=self.load(forms[1])
        self.assertEqual(lean(a,ea,[]),lean(b,eb,[]))
        self.assertEqual(latex(a,ea),latex(b,eb))

    def test_default_plain_and_module_documentation(self):
        for source in ['Text:\n  Explanation.\n','"""\nExplanation.\n"""\n','/-! Explanation. -/\n']:
            self.assertEqual(self.nodes(source)[0].payload,Prose('plain','Explanation.',1))

    def test_keywords_and_dialects_ignore_case(self):
        self.assertEqual(self.nodes('tExT LaTeX:\n  x')[0].payload.dialect,'latex')
        self.assertEqual(self.nodes('"""TyPsT\nx\n"""')[0].payload.dialect,'typst')

    def test_text_body_preserves_indentation_and_blank_paragraphs(self):
        source='Text:\n    first\n\n      indented\n    last\n'
        self.assertEqual(self.nodes(source)[0].payload.body,'first\n\n  indented\nlast')

    def test_prose_does_not_execute_clean_or_comment_syntax(self):
        body='Result pretend:\n-- visible\n/- unclosed\n"quotes" # %'
        source='"""latex\n'+body+'\n"""\n'
        self.assertEqual(self.nodes(source)[0].payload.body,body)
        body='/-! not a module doc -/\n"""latex\nResult pretend:'
        self.assertEqual(self.nodes('Text:\n  '+body.replace('\n','\n  '))[0].payload.body,body)

    def test_ordinary_comments_and_opaque_fields_do_not_start_prose(self):
        masked,records,_=scan('/-\nText:\n  ignored\n/-! nested -/\n-/\nMeans: /-- Lean doc -/ x\n')
        self.assertFalse(records)
        self.assertEqual(masked[-1],'Means: /-- Lean doc -/ x')

    def test_nested_documentation_preserves_payload(self):
        self.assertEqual(self.nodes('/-! Outer /- nested -/ prose. -/')[0].payload.body,
                         'Outer /- nested -/ prose.')

    def test_result_doc_attaches_across_blank_lines_and_comments(self):
        results,env=self.load(IMPORT+'/-- Product law. -/\n\n-- note\n'+RESULT)
        self.assertEqual(results[0].documentation.body,'Product law.')
        output=lean(results,env,[])
        self.assertIn('/--\nProduct law.\n\nsource:',output)
        self.assertIn('Product law.',latex(results,env))
        self.assertEqual(results[0].line,6)

    def test_definition_doc_does_not_change_generated_name(self):
        source=IMPORT+'Define square(x: Real): Real:\n  Equals: x*x\n'+RESULT
        a,ea=self.load(source)
        b,eb=self.load(source.replace('Define square','/-- The square. -/\nDefine square'))
        key=ea.definitions['square']['key']
        self.assertEqual(key,eb.definitions['square']['key'])
        self.assertEqual(ea.notation_definitions,eb.notation_definitions)
        self.assertIn('/--\nThe square.\n-/\nnoncomputable def '+key,lean(b,eb,[]))
        self.assertIn('The square.',latex(b,eb))

    def test_authored_order_survives_document_loader(self):
        source=IMPORT+'Text:\n  Before.\n'+RESULT+'"""latex\n\\section{After}\n"""\n'
        results,env=self.load(source)
        self.assertEqual([x.body if isinstance(x,Prose) else x.name for x in results.events],
                         ['Before.','determinant_product','\\section{After}'])
        tex=latex(results,env)
        self.assertLess(tex.index('Before.'),tex.index('begin{cleanresult}'))
        self.assertLess(tex.index('end{cleanresult}'),tex.index('\\section{After}'))

    def test_context_prose_and_docs_preserve_scope(self):
        source=IMPORT+'Context matrices:\n  Text:\n    Introduction.\n  Let n: Natural\n  Let A,B: Matrix(n,n,Complex)\n  Text:\n    Shared matrices.\n  /-- Product law. -/\n'+''.join('  '+line+'\n' for line in RESULT.splitlines() if not line.startswith('  Let'))
        results,env=self.load(source)
        self.assertEqual(results[0].documentation.body,'Product law.')
        self.assertEqual(len(results[0].contexts),1)
        self.assertIn('Shared matrices.',latex(results,env))

    def test_imported_prose_is_not_inlined_into_paper(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp)
            (root/'library.clean').write_text('Text:\n  Library narrative.\n')
            (root/'paper.clean').write_text('Import "library.clean"\nText:\n  Paper narrative.\n')
            env=Environment();results=load_document(root/'paper.clean',env)
            self.assertNotIn('Library narrative.',latex(results,env))
            self.assertIn('Library narrative.',lean(results,env,[]))

    def test_typst_is_preserved_and_latex_fails_explicitly(self):
        results,env=self.load('"""typst\n= A heading\n#figure([])\n"""')
        self.assertIn('```typst\n= A heading',lean(results,env,[]))
        with self.assertRaisesRegex(CleanError,'Typst text cannot'):
            latex(results,env)

    def test_plain_tex_escaping_and_lean_delimiter_sanitization(self):
        results,env=self.load('Text:\n  100% & $x$ /- text -/\n')
        self.assertIn(r'100\% \& \$x\$',latex(results,env))
        self.assertIn('/ - text - /',lean(results,env,[]))

    def test_invalid_placements_and_delimiters(self):
        for source in ['Text:\nx','Text:\n x','Text html:\n  x',
                       '"""html\nx\n"""','"""latex\nx',
                       '/-- orphan -/','/-- a -/\n/-- b -/\n'+RESULT,
                       '/-- doc -/\nText:\n  prose',
                       '/-- doc -/\nImport "x.clean"',
                       '/-! prose -/ Result x:', 'Let x: /-- doc -/ Real',
                       RESULT.replace('  Conclude:', '  Text:\n    bad\n  Conclude:'),
                       '\ue000T1', '"""\n\tbad\n"""']:
            with self.subTest(source=source),self.assertRaises(CleanError):self.nodes(source)

    def test_no_section_declaration(self):
        with self.assertRaises(CleanError):self.nodes('Section: Matrices\n')

    def test_docs_on_source_or_erased_alias_are_errors(self):
        for source in [IMPORT+'/-- doc -/\nSource x:\n  Kind: other\n  Label: x\n  Title: x\n'+RESULT,
                       IMPORT+'/-- doc -/\nType Scalar():\n  Equals: Real\n'+RESULT]:
            with self.assertRaisesRegex(CleanError,'one generated Lean definition'):self.load(source)
