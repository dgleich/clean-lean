# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
import unittest,tempfile
from pathlib import Path
from cleanlang.core import Environment,CleanError,lean,latex
from cleanlang.modules import load_document
from cleanlang.conditions import source_expression
ROOT=Path(__file__).resolve().parents[1]

class ProjectedConditionNames(unittest.TestCase):
    def load(self,assumptions):
        source=f'''Import "{ROOT}/library/topology/compact_spaces.clean"
Import "{ROOT}/library/topology/interlevel.clean"
Source test:
  Kind: other
  Label: Test
  Title: Projection naming
Result example:
  Attribution: test; labels; original
  Let P,Q: InterlevelProblem
  Assume {assumptions}
  Conclude: P = P
'''
        with tempfile.TemporaryDirectory() as d:
            p=Path(d)/'sample.clean';p.write_text(source)
            e=Environment();r=load_document(p,e)
        return e,r
    def test_projection_labels_and_targets(self):
        e,r=self.load('compact space(P.space), compact space(Q.space)')
        a=[c for c in r[0].clauses if c.kind=='assume']
        self.assertEqual([(c.label,c.names) for c in a],[
          ('compactness of P.space',['compactness_of_P_u2e_space']),
          ('compactness of Q.space',['compactness_of_Q_u2e_space'])])
        self.assertIn('∀ («compactness_of_P_u2e_space» :',lean(r,e,[]))
        self.assertIn('compactness of P.space',latex(r,e))
        self.assertEqual(a[0].value.tree,['Call','compact space',[['Projection',['Local','P'],'space']]])
    def test_collisions(self):
        for source in ['compact space(P.space), compact space((P.space))',
                       'compact space(P.space), compactness of P_u2e_space: compact space(Q.space)']:
            with self.subTest(source=source),self.assertRaisesRegex(CleanError,'Duplicate'):
                self.load(source)
    def test_field_application_spelling(self):
        self.assertEqual(source_expression(['Apply',['Projection',['Local','P'],'map'],[['Local','x']]]),'P.map(x)')
        self.assertEqual(source_expression(['Projection',['Call','endpoints',[['Local','a'],['Local','b']]],'lower']),
                         'endpoints(a, b).lower')
    def test_nested_quantifier_spelling(self):
        tree=['Lambda','f','Function(Real,Real)',['Forall','x','Real',
          ['Exists','y','Real',['Operator','=', ['Call','f',[['Local','x']]],['Local','y']]]]]
        self.assertEqual(source_expression(tree),
          'function(f: Function(Real,Real), for every (x: Real, there exists (y: Real, (f(x) = y))))')

    def test_nested_forms_in_actual_assumptions(self):
        source=f'''Import "{ROOT}/library/topology/basic.clean"
Source test:
  Kind: other
  Label: Test
  Title: Naming
Structure Evaluator():
  Let map: Function(Real,Real)
  Constructor: evaluator
Condition positive(x: Real):
  Holds when: x > 0
Condition accepted(p: Function(Real,Proposition)):
  Holds when: p(0)
Result nested names:
  Attribution: test; nested labels; original
  Let E: Evaluator
  Let a: Real
  Assume positive(E.map(a)), accepted(function(x: Real,for every (y: Real,x=y)))
  Conclude: a = a
'''
        with tempfile.TemporaryDirectory() as d:
            p=Path(d)/'sample.clean';p.write_text(source)
            e=Environment();r=load_document(p,e)
        labels=[c.label for c in r[0].clauses if c.kind=='assume']
        self.assertEqual(labels,['positive(E.map(a))',
          'accepted(function(x: Real, for every (y: Real, (x = y))))'])

    def test_computed_projection_uses_normalized_argument(self):
        # Both inputs reduce to the same source local before naming.
        with self.assertRaisesRegex(CleanError,'Duplicate'):
            self.load('compact space(identity diagram(P.space).source), compact space(P.space)')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
