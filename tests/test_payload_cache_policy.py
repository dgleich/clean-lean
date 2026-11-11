# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
import json,unittest
from dataclasses import replace
from cleanlang.core import Expr,Type,CleanError
from cleanlang.indices import ComputedIndex
from cleanlang.retained_codec import dumps,loads

class PayloadCaches(unittest.TestCase):
 def test_shared_checked_children_do_not_expand_payload(self):
  value=Expr('x','x',Type('Real'),tree=['Local','x'])
  plain=dumps(value)
  # The semantic expression is fixed; only the disposable child-cache DAG grows.
  for _ in range(24):
   value=Expr('x','x',Type('Real'),tree=['Local','x'],checked_args=(value,value))
  self.assertEqual(dumps(value),plain)
  restored=loads(dumps(value));self.assertIsNone(restored.checked_args)
  self.assertNotIn('checked_args',json.loads(plain)['value']['fields'])
 def test_index_cache_is_not_persisted(self):
  syntax=dumps(['Local','x'])
  value=ComputedIndex('x','x','x',syntax,resolved=['Local','different'])
  encoded=dumps(value);restored=loads(encoded)
  self.assertNotIn('resolved',json.loads(encoded)['value']['fields'])
  self.assertIsNone(restored.resolved)
  self.assertEqual(restored.syntax,syntax)
  self.assertEqual(dumps(replace(value,resolved=None)),encoded)
 def test_removed_fields_are_not_accepted_as_hidden_authority(self):
  doc=json.loads(dumps(Expr('x','x',Type('Real'),tree=['Local','x'])))
  doc['value']['fields']['checked_args']=None
  with self.assertRaises(CleanError):loads(json.dumps(doc))
 def test_older_schema_rejected(self):
  doc=json.loads(dumps(['Local','x']))
  for version in (1,2,3):
   doc['version']=version
   with self.assertRaises(CleanError):loads(json.dumps(doc))

if __name__=='__main__':unittest.main()

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
