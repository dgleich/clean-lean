# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,parse,lean,latex,CleanError
from cleanlang.modules import load_module,load_document,type_declaration
ROOT=Path(__file__).resolve().parents[1]

class AliasDescriptions(unittest.TestCase):
    def setUp(self):
        self.e=Environment()
        load_module(ROOT/'library/logic/elements.clean',self.e)
        self.e.sources.declare('mathlib',{'kind':'other','label':'mathlib','title':'Test source'},ROOT)
    def declare(self,name='Chosen',extra=None):
        type_declaration('Type '+name+'(A: Type,S: Set(A)):',
          ['Equals: Element(A,S)']+(extra if extra is not None else
          ['Describe: a chosen element of ${S}$','Describe plural: chosen elements of ${S}$']),self.e)
    def source(self,typ='Chosen(A,S)',names='x'):
        return 'Result identity:\n  Attribution: mathlib; Eq.refl\n  Let A: Type\n  Let S: Set(A)\n  Let '+names+': '+typ+'\n  Conclude: x = x\n'
    def test_let_parse_is_unchanged(self):
        from cleanlang.syntax import let_clause
        self.assertEqual(let_clause('Let x: Selected(A,S)'),('let',['x'],'Selected(A,S)'))
    def test_description_is_frozen_per_authored_alias(self):
        rs=load_document(ROOT/'studies/alias-descriptions/Statements.clean',Environment())
        self.assertEqual(rs[0].clauses[-1].value,rs[2].clauses[-1].value)
        self.assertEqual(rs[0].clauses[-1].descriptions['prose'],'a selected element of $S$')
        self.assertEqual(rs[2].clauses[-1].descriptions['prose'],'an eligible element of $S$')
    def test_target_matches_expanded_type_exactly(self):
        self.declare()
        self.assertEqual(lean(parse(self.source(),self.e),self.e,[]),
                         lean(parse(self.source('Element(A,S)'),self.e),self.e,[]))
    def test_plural_selected_by_number_of_names(self):
        self.declare();r=parse(self.source(names='x,y'),self.e)[0]
        from cleanlang.core import _latex_clauses
        self.assertEqual(_latex_clauses([r.clauses[-1]],self.e),['Let $x$ and $y$ be chosen elements of $S$.'])
    def test_missing_plural_falls_back_to_semantic_type(self):
        self.declare(extra=['Describe: a chosen element of ${S}$'])
        from cleanlang.core import _latex_clauses
        r=parse(self.source(names='x,y'),self.e)[0]
        self.assertEqual(_latex_clauses([r.clauses[-1]],self.e),
          _latex_clauses([parse(self.source('Element(A,S)',names='x,y'),self.e)[0].clauses[-1]],self.e))
    def test_unknown_template_parameter_rejected(self):
        with self.assertRaisesRegex(CleanError,'rendering parameter'):
            self.declare(extra=['Describe: a member of {T}'])
    def test_alias_cannot_override_lean_or_math_rendering(self):
        for extra in [['Means: Nat'],['Render latex: Q'],['Universe: 1']]:
            with self.assertRaisesRegex(CleanError,'Type alias accepts'):
                self.declare(extra=extra)
    def test_outer_alias_without_description_does_not_inherit_inner_label(self):
        self.declare();type_declaration('Type Outer(A: Type,S: Set(A)):',['Equals: Chosen(A,S)'],self.e)
        r=parse(self.source('Outer(A,S)'),self.e)[0]
        self.assertNotIn('prose',r.clauses[-1].descriptions)
    def test_phrase_uses_its_declared_alias(self):
        self.declare();self.e.data['phrases'].append({'pattern':'chosen members','type':'Chosen(A,S)'})
        r=parse(self.source('chosen members'),self.e)[0]
        self.assertEqual(r.clauses[-1].descriptions['prose'],'a chosen element of $S$')
    def test_context_pruning_does_not_gain_semantic_dependencies(self):
        type_declaration('Type Tagged(A: Type,S: Set(A)):',
          ['Equals: A','Describe: an element marked by ${S}$'],self.e)
        source='''Context objects:
  Let A: Type
  Let S: Set(A)
  Let x: Tagged(A,S)
  Result identity:
    Attribution: mathlib; Eq.refl
    Conclude: x = x
'''
        r=parse(source,self.e)[0]
        self.assertEqual([n for c in r.clauses for n in c.names],['A','x'])
        self.assertEqual(r.clauses[-1].descriptions,{})
        self.assertIn('prose',r.contexts[0].clauses[-1].descriptions)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
