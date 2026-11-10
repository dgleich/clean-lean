# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest,tempfile
from unittest.mock import patch
from cleanlang.core import Environment,Expr,Expressions
from cleanlang.modules import load_module
from cleanlang import structures
ROOT=Path(__file__).resolve().parents[1]
SOURCE='''Structure Choice():
  Universe: 1
  Let carrier: Type
  Let value: carrier
  Let count: Natural
  Constructor choice
Structure Tower():
  Universe: 1
  Let carrier: Type
  Let object: carrier
  Let selected: Evidence((object=object))
  Let witness: Evidence((selected=selected))
  Constructor tower
Structure Indexed():
  Let bound: Natural
  Let point: Vertex(bound)
  Let mark: Function(Vertex(bound),Natural)
  Let unused: Function(Natural,Natural)
  Let law: Evidence((mark(point)=mark(point)))
  Constructor indexed
'''.replace('  Constructor ','  Constructor: ')
class ProjectionDependencies(unittest.TestCase):
 def setUp(self):
  self.e=Environment()
  with tempfile.TemporaryDirectory() as d:
   p=Path(d)/'Records.clean';p.write_text('Import "'+str(ROOT/'library/logic/proof_equality.clean')+'"\n'+SOURCE);load_module(p,self.e)
  self.s={n:Expr(n,n,self.e.type(t),tree=['Local',n]) for n,t in [('c','Choice'),('t','Tower'),('i','Indexed')]}
 def expr(self,text):return Expressions(self.e,self.s).parse(text)
 def test_independent_later_field_has_same_explicit_target(self):
  calls=[];original=structures.substitute_type
  def record(typ,*args,**kwargs):
   calls.append(typ);return original(typ,*args,**kwargs)
  with patch.object(structures,'substitute_type',record):value=self.expr('c.count')
  self.assertEqual(value.type,self.e.type('Natural'))
  self.assertEqual(value.tree,['Projection',['Local','c'],'count'])
  key=self.e.structures['Choice']['key']
  self.assertEqual(value.lean,f'(@_root_.{key}.«count» (c))')
  self.assertEqual(calls,[self.e.type('Natural')])
 def test_carrier_field_is_still_required(self):
  value=self.expr('c.value')
  self.assertEqual(value.type,self.e.type('c.carrier',self.s))
  self.assertEqual(self.e.render_type(value.type,'lean',self.s),'('+self.expr('c.carrier').lean+')')
 def test_transitive_proof_dependencies(self):
  value=self.expr('t.witness')
  self.assertEqual(value.type,self.e.type('Evidence((t.selected=t.selected))',self.s))
  self.assertIn(self.e.structures['Tower']['key'],self.e.render_type(value.type,'lean',self.s))
 def test_function_and_value_indices_are_kept(self):
  value=self.expr('i.law')
  self.assertEqual(value.type,self.e.type('Evidence((i.mark(i.point)=i.mark(i.point)))',self.s))
 def test_changed_caller_is_checked_fresh(self):
  old=self.expr('c.value')
  self.s['c']=Expr('other','c',self.e.type('Choice'),tree=['Local','c'])
  current=self.expr('c.value')
  self.assertNotEqual(old.lean,current.lean)
  self.assertIn('other',self.e.render_type(current.type,'lean',self.s))

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
