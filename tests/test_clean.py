from support import standard_environment, statement_text
from cleanlang.modules import load_module, load_document
import json
import re
from pathlib import Path
import tempfile
import unittest
from cleanlang.core import CleanError,Environment,parse,lean,latex,Expressions,Expr,Type,PROP
ROOT=Path(__file__).resolve().parents[1]
SOURCE=statement_text(ROOT/'examples/similarity.clean')
class CleanTests(unittest.TestCase):
    def setUp(self): self.reg=standard_environment()
    def test_keywords_case_insensitive(self):
        variants=[SOURCE,SOURCE.replace('Let ','LET ').replace('Assume ','aSsUmE ').replace('Conclude:','CONCLUDE:')]
        self.assertEqual(*[lean(parse(s,self.reg),self.reg,[]) for s in variants])
    def test_type_spellings_equivalent(self):
        base=lean(parse(SOURCE,self.reg),self.reg,[])
        for phrase in ['a Matrix(n,n,Complex)','Matrices(n,n,Complex)']:
            self.assertEqual(base,lean(parse(SOURCE.replace('complex n×n matrices',phrase),self.reg),self.reg,[]))
        self.assertEqual(base,lean(parse(SOURCE.replace('A, S be complex n×n matrices','A, S: Matrix(n,n,Complex)'),self.reg),self.reg,[]))
    def test_multiplication_and_local_definition(self):
        s=lean(parse(SOURCE,self.reg),self.reg,[])
        self.assertIn('A *ᵥ x',s); self.assertIn('μ • x',s)
        self.assertIn('let y : Fin n → ℂ :=',s)
        self.assertNotIn('sorry',s); self.assertNotIn('axiom',s)
    def reject(self,s,part):
        with self.assertRaisesRegex(CleanError,part): parse(s,self.reg)
    def test_missing_attribution(self): self.reject(re.sub(r'    Attribution:.*\n','',SOURCE),'attribution missing')
    def test_type_value_rejected(self): self.reject(SOURCE.replace('Let y = inverse(S)*x','Let y = Vector(n,Complex)'),'Cannot use let x = Type')
    def test_undeclared_dimension(self): self.reject(SOURCE.replace('    Let n be a natural number\n',''),'Declare dimension n')
    def test_undeclared_name(self): self.reject(SOURCE.replace('det(S) ≠ 0','det(Q) ≠ 0'),'Unknown name: Q')
    def test_tabs(self): self.reject(SOURCE.replace('    Let n','\tLet n'),'tabs')
    def test_bad_indentation(self): self.reject(SOURCE.replace('    Let n','  Let n'),'dedent')
    def test_duplicate_names(self): self.reject(SOURCE.replace('Let y = inverse(S)*x','Let x = inverse(S)*x'),'Duplicate name')
    def test_dimensions_checked(self):
        self.reject(SOURCE.replace('complex n-vector','complex 2-vector'),'dimension')
    def test_conclusion_must_be_proposition(self): self.reject(SOURCE[:SOURCE.index('    Conclude:')]+'    Conclude: x\n','proposition')
    def test_assumption_must_be_proposition(self): self.reject(SOURCE.replace('Assume nonzero: x ≠ 0','Assume nonzero: x'),'proposition')
    def test_define_alias(self):
        self.assertEqual(lean(parse(SOURCE,self.reg),self.reg,[]),lean(parse(SOURCE.replace('Let y =','DEFINE y ='),self.reg),self.reg,[]))
    def test_extension_canonicalization(self):
        load_module(ROOT/'examples/modules/square-matrices.clean',self.reg)
        r=parse(statement_text(ROOT/'examples/extension.clean'),self.reg)
        self.assertEqual(str(r[0].clauses[1].value),'Matrix(n,n,Complex)')
    def test_ambiguous_phrase(self):
        self.reg.data['phrases'].append({'pattern':'complex number','type':'Real'})
        self.reject(SOURCE,'Ambiguous type phrase')
    def test_alias_cycle(self):
        self.reg.data['types']['Cycle']={'args':[],'canonical':'Cycle'}
        with self.assertRaisesRegex(CleanError,'Cyclic'): self.reg.type('Cycle')
    def test_no_implicit_truth(self):
        s=lean(parse(SOURCE,self.reg),self.reg,[])
        self.assertIn('def similarity_transforms_eigenvector : Prop',s)
        self.assertNotIn('theorem similarity_transforms_eigenvector',s)
    def test_periods_and_escaping(self):
        s=latex(parse(SOURCE,self.reg),self.reg)
        self.assertIn('be a natural number.\nLet $',s)
        r=parse(SOURCE,self.reg); r[0].attribution['note']='A & B_1 50%'
        s=latex(r,self.reg); self.assertIn(r'A \& B\_1 50\%',s)
    def test_corpus_counts_and_unique_sources(self):
        catalog=json.loads((ROOT/'corpus/catalog.json').read_text())
        for cat in ('linear_algebra','graph_theory','analysis','algorithms'):
            rs=load_document(ROOT/'corpus'/f'{cat}.clean',Environment())
            self.assertGreaterEqual(len(rs),20)
            entries=[x for x in catalog if x['category']==cat]
            self.assertEqual(len(rs),len(entries))
            self.assertEqual(len(entries),len(set(x['source_declaration'] for x in entries)))
    def test_conclude_is_last(self): self.reject(SOURCE+'    Let z: Real\n','Conclude must be last')
    def test_logical_precedence(self):
        env={x:Expr(x,x,PROP) for x in ['p','q','r']}
        self.assertEqual(Expressions(self.reg,env).parse('p and q or r').lean,'((p ∧ q) ∨ r)')
    def test_unary_minus_and_power(self):
        env={'x':Expr('x','x',Type('Real'))}
        parser=Expressions(self.reg,env)
        self.assertEqual(parser.parse('-x^2').lean,'(-(x ^ 2))')
        self.assertEqual(parser.parse('(-x)^2').lean,'((-x) ^ 2)')
        self.assertIn('(-x)',parser.parse('(-x)^2').tex)
    def test_negation_preserves_grouping(self):
        env={x:Expr(x,x,PROP) for x in ['p','q']}
        tx=Expressions(self.reg,env).parse('not (p and q)').tex
        self.assertEqual(tx,r'\text{not }(p \text{ and } q)')
    def test_forward_reference_rejected(self):
        self.reject(SOURCE.replace('Let y = inverse(S)*x','Let y = z'),'Unknown name: z')
    def test_assumption_order_after_definition(self):
        source=SOURCE.replace('    Conclude:','    Assume hy: y ≠ 0\n    Conclude:')
        code=lean(parse(source,self.reg),self.reg,[])
        self.assertLess(code.index('let y :'),code.index('∀ (hy :'))
    def test_english_logic_in_latex_keeps_lean_semantics(self):
        env={x:Expr(x,x,PROP) for x in ['p','q']}
        for op,word in [('and','and'),('or','or'),('↔','if and only if'),('→','implies')]:
            expr=Expressions(self.reg,env).parse('p '+op+' q')
            self.assertIn('\\text{ '+word+' }',expr.tex)
        s=latex(parse(SOURCE,self.reg),self.reg)
        self.assertIn(r'\text{ and }',s)
        self.assertNotIn(r'\land',s)
        self.assertIn('μ • x',lean(parse(SOURCE,self.reg),self.reg,[]))
    def test_typed_objects_render_as_english(self):
        s=latex(parse(SOURCE,self.reg),self.reg)
        self.assertIn('Let $n$ be a natural number.',s)
        self.assertIn('Let $A$ and $S$ be',s)
        self.assertNotIn(r'Let $n$ \in',s)
    def test_english_result_title_generates_lean_identifier(self):
        source=SOURCE.replace('similarity transforms eigenvector','determinant left swap')
        r=parse(source,self.reg)[0]
        self.assertEqual(r.title,'determinant left swap')
        self.assertEqual(r.name,'determinant_left_swap')
        self.assertIn(r'\begin{cleanresult}{determinant left swap}',latex([r],self.reg))
        self.assertIn('def determinant_left_swap : Prop',lean([r],self.reg,[]))
    def test_legacy_underscore_title_is_equivalent(self):
        readable=parse(SOURCE,self.reg)
        legacy=parse(SOURCE.replace('similarity transforms eigenvector','similarity_transforms_eigenvector'),self.reg)
        self.assertEqual(lean(readable,self.reg,[]),lean(legacy,self.reg,[]))
        self.assertEqual(latex(readable,self.reg),latex(legacy,self.reg))
    def test_normalized_result_title_collision(self):
        other=SOURCE.replace('similarity transforms eigenvector','similarity_transforms_eigenvector')
        self.reject(SOURCE+'\n'+other,'Duplicate result name')
    def test_title_capitalization_and_spacing(self):
        source=SOURCE.replace('similarity transforms eigenvector','Determinant   left swap')
        r=parse(source,self.reg)[0]
        self.assertEqual(r.name,'Determinant_left_swap')
        self.assertEqual(r.title,'Determinant left swap')
    def attribution(self,text):
        return re.sub(r'    Attribution:.*',lambda _: '    '+text,SOURCE)
    def test_compact_attribution_equals_block(self):
        compact='Attribution: mathlib; Matrix.det_mul_left_comm; specialized; scope: complex matrices'
        block='Attribution:\n        source: mathlib\n        declaration: Matrix.det_mul_left_comm\n        relationship: specialized\n        scope: complex matrices'
        a=parse(self.attribution(compact),self.reg)[0]
        b=parse(self.attribution(block),self.reg)[0]
        self.assertEqual(a.attribution,b.attribution)
        self.assertEqual(latex([a],self.reg),latex([b],self.reg))
    def test_unspecified_relationship_stays_unspecified(self):
        r=parse(self.attribution('Attribution: mathlib; Matrix.det_mul_left_comm'),self.reg)[0]
        self.assertNotIn('relationship',r.attribution)
        self.assertNotIn('scope',r.attribution)
    def test_optional_named_fields_without_relationship(self):
        r=parse(self.attribution('Attribution: mathlib; Matrix.det_mul_left_comm; scope: matrices; note: example'),self.reg)[0]
        self.assertEqual(r.attribution['scope'],'matrices')
        self.assertNotIn('relationship',r.attribution)
    def test_unknown_source_and_declaration(self):
        self.reject(self.attribution('Attribution: missing; theorem'),'Unknown attribution source')
        self.reject(self.attribution('Attribution: mathlib; Mathrix.det_mul_left_comm'),'Unknown declaration')
    def test_duplicate_attribution_fields(self):
        self.reject(self.attribution('Attribution: mathlib; Matrix.det_mul_left_comm; direct; relationship: adapted'),'Duplicate attribution field')
        self.reject(self.attribution('Attribution: mathlib; Matrix.det_mul_left_comm; source: stewart2001'),'Duplicate attribution field')
    def test_compact_quoted_semicolon(self):
        r=parse(self.attribution('Attribution: mathlib; Matrix.det_mul_left_comm; note: "two cases; same conclusion"'),self.reg)[0]
        self.assertEqual(r.attribution['note'],'two cases; same conclusion')
    def test_invalid_compact_fields(self):
        for suffix in [';', '; ; direct', '; scope:', '; mystery', '; scope: example; adapted']:
            with self.assertRaises(CleanError): parse(self.attribution('Attribution: mathlib; Matrix.det_mul_left_comm'+suffix),self.reg)
    def test_duplicate_attribution_clause(self):
        self.reject(SOURCE.replace('    Let n','    Attribution: mathlib; Matrix.det_mul_left_comm\n    Let n'),'Duplicate attribution clause')
    def test_short_citation_has_no_repeated_provenance_dump(self):
        r=parse(self.attribution('Attribution: mathlib; Matrix.det_mul_left_comm; specialized'),self.reg)
        s=latex(r,self.reg)
        self.assertIn('[Mathlib]',s)
        self.assertNotIn('scope:',s)
        self.assertNotIn('relationship:',s)
        self.assertNotIn('source:',s)
        self.assertNotIn('Matrix.det_mul_left_comm',s)
    def test_reference_alias_conflict(self):
        self.reject(self.attribution('Attribution: mathlib; Matrix.det_mul_left_comm; location: other'),'only one reference')
if __name__=='__main__': unittest.main()
