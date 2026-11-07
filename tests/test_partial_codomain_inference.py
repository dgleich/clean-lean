# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Caller names survive codomain matching while other arguments remain uninferred."""
import tempfile,unittest
from pathlib import Path
from cleanlang.core import Environment,CleanError,lean
from cleanlang.modules import load_document
ROOT=Path(__file__).resolve().parents[1]
DEFINITION='''Notation retain with law(n,f,h,z):
  Let T: Type
  Let n: Natural
  Let f: Function(Natural,Natural)
  Let h: Function(x: Natural,Evidence((f(x) = n)))
  Let z: T
  Returns: T
  Means: z
  Render latex: {z}
'''
class PartialCodomainInference(unittest.TestCase):
 def load(self,equation,definitions=DEFINITION,argument="function(x: Natural,h(x))",hypothesis=None):
  hypothesis=hypothesis or "for every(x: Natural,"+equation+")"
  source=f'''Import "{ROOT/'library/logic/evidence.clean'}"
Source local:
  Kind: other
  Label: local
  Title: codomain inference
'''+definitions+f'''
Result retained:
  Attribution: local; retained; original
  Let n,m: Natural
  Let z: Real
  Assume h: {hypothesis}
  Conclude: retain with law(m,function(x: Natural,n),{argument},z) = z
'''
  with tempfile.TemporaryDirectory() as td:
   p=Path(td)/'Specimen.clean';p.write_text(source);e=Environment();results=load_document(p,e)
  return lean(results,e,['Lean'])
 def test_later_inference_does_not_capture_valid_caller_name(self):
  self.load('n = m')
 def test_later_inference_rejects_captured_equation(self):
  with self.assertRaisesRegex(CleanError,'Dependent index mismatch'):
   self.load('m = m')

 def test_universal_evidence_argument(self):
  self.load('n = m',argument='h')
 def test_nested_pattern_keeps_outer_caller_name(self):
  definition=DEFINITION.replace('Function(x: Natural,Evidence((f(x) = n)))','Function(x: Natural,Function(y: Natural,Evidence((f(x) = n))))')
  self.load('n = m',definitions=definition,argument='function(x: Natural,function(y: Natural,h(x)(y)))',hypothesis='for every(x: Natural,for every(y: Natural,n = m))')
 def test_nested_pattern_rejects_wrong_equation(self):
  definition=DEFINITION.replace('Function(x: Natural,Evidence((f(x) = n)))','Function(x: Natural,Function(y: Natural,Evidence((f(x) = n))))')
  with self.assertRaisesRegex(CleanError,'Dependent index mismatch'):
   self.load('m = m',definitions=definition,argument='function(x: Natural,function(y: Natural,h(x)(y)))',hypothesis='for every(x: Natural,for every(y: Natural,m = m))')
 def test_infer_type_from_codomain_before_later_parameter(self):
  definition=DEFINITION.replace('Let T: Type','Let T,U: Type').replace('Let z: T','Let z: U').replace('Returns: T','Returns: U').replace('Function(Natural,Natural)','Function(x: Natural,T)').replace('Evidence((f(x) = n))','Evidence((f(x) = f(x)))')
  # T is inferred from f's result before h is matched; the caller n is preserved.
  self.load('n = n',definitions=definition)

# generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
