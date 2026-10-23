from support import standard_environment, statement_text
from cleanlang.modules import load_module, load_document
import unittest
from cleanlang.core import Environment,parse,lean,latex,CleanError

SOURCE='''Context complex square matrices:
    Let n: Natural
    Let A, B, C: Matrix(n,n,Complex)

    Result determinant product:
        Attribution: mathlib; Matrix.det_mul; specialized
        Conclude: det(A*B) = det(A)*det(B)

    Result determinant transpose:
        Attribution: mathlib; Matrix.det_transpose; specialized
        Conclude: det(transpose(A)) = det(A)
'''
class ContextTests(unittest.TestCase):
    def setUp(self): self.reg=standard_environment()
    def test_only_required_parameters_are_generalized(self):
        a,b=parse(SOURCE,self.reg)
        self.assertEqual([n for c in a.clauses for n in c.names],['n','A','B'])
        self.assertEqual([n for c in b.clauses for n in c.names],['n','A'])
    def test_flattening_matches_explicit_statement(self):
        flat='''Result determinant transpose:
    Attribution: mathlib; Matrix.det_transpose; specialized
    Let n: Natural
    Let A: Matrix(n,n,Complex)
    Conclude: det(transpose(A)) = det(A)
'''
        b=parse(SOURCE,self.reg)[1]
        self.assertEqual(lean([b],self.reg,[]),lean(parse(flat,self.reg),self.reg,[]))
    def test_assumptions_are_never_pruned(self):
        s=SOURCE.replace('    Result determinant product:', '    Assume nonzero: det(C) ≠ 0\n\n    Result determinant product:',1)
        a,b=parse(s,self.reg)
        for r in (a,b):
            self.assertIn('C',[n for c in r.clauses for n in c.names])
            self.assertIn('nonzero',[n for c in r.clauses for n in c.names])
    def test_unused_definitions_are_pruned_but_dependencies_kept(self):
        s=SOURCE.replace('    Result determinant product:', '    Let D = A*B\n    Let E = C*C\n\n    Result determinant product:',1).replace('det(A*B) = det(A)*det(B)','det(D) = det(A)*det(B)')
        r=parse(s,self.reg)[0]
        names=[n for c in r.clauses for n in c.names]
        self.assertIn('D',names); self.assertNotIn('C',names); self.assertNotIn('E',names)
    def test_standalone_export_restores_context(self):
        r=parse(SOURCE,self.reg)[1]; tex=latex([r],self.reg)
        self.assertIn('\\begin{cleancontext}',tex)
        self.assertIn('Using Context (\\cleancontextref{',tex)
        self.assertIn('\\else\n',tex)
        self.assertIn('Let $A$ be a matrix',tex.split('\\else\n')[1])
    def test_referenced_context_emitted_once(self):
        tex=latex(parse(SOURCE,self.reg),self.reg)
        self.assertEqual(tex.count('\\begin{cleancontext}'),1)
        self.assertEqual(tex.count('Using Context ('),2)
    def test_nested_contexts_explicitly_cited(self):
        s='''Context dimensions:
    Let n: Natural
    Context matrices:
        Let A: Matrix(n,n,Complex)
        Result determinant transpose:
            Attribution: mathlib; Matrix.det_transpose
            Conclude: det(transpose(A)) = det(A)
'''
        r=parse(s,self.reg)[0]
        self.assertEqual(len(r.contexts),2)
        self.assertIn(' and Context (',latex([r],self.reg))
        self.assertEqual([n for c in r.clauses for n in c.names],['n','A'])
    def test_context_closes_on_dedent(self):
        s=SOURCE+'''\nResult outside:
    Attribution: mathlib; Matrix.det_transpose
    Conclude: det(transpose(A)) = det(A)
'''
        with self.assertRaisesRegex(CleanError,'Unknown name'): parse(s,self.reg)
    def test_shadowing_rejected(self):
        s=SOURCE.replace('        Conclude:', '        Let A: Real\n        Conclude:',1)
        with self.assertRaisesRegex(CleanError,'duplicate name'): parse(s,self.reg)
    def test_context_declarations_must_precede_results(self):
        with self.assertRaisesRegex(CleanError,'Expected Context name'): parse(SOURCE+'    Let x: Real\n',self.reg)
    def test_empty_context_rejected(self):
        with self.assertRaisesRegex(CleanError,'must contain a result'): parse('Context empty:\n    Let x: Real\n',self.reg)
    def test_original_line_numbers_preserved(self):
        r=parse(SOURCE,self.reg)[0]
        self.assertEqual(r.line,5)
        self.assertEqual(r.clauses[0].line,2)
if __name__=='__main__': unittest.main()

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
