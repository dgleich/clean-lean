"""Generated declaration spelling is deterministic, readable, and collision checked."""
import unittest
from unittest.mock import patch
from cleanlang.core import Environment, CleanError
from cleanlang.modules import add_definition

class GeneratedNameTests(unittest.TestCase):
    def test_readable_prefixes(self):
        for prefix,name,stem in [('cleanType_','Real','Real'),
                                 ('cleanNotation_','matrix power','matrix_power'),
                                 ('cleanDefine_','squared distance','squared_distance'),
                                 ('cleanDefine_','μ value','_u3bc__value')]:
            with self.subTest(name=name):
                key=add_definition(Environment(),prefix,name,' : Nat := 0')
                self.assertRegex(key, '^'+prefix+stem+'_[0-9a-f]{20}$')

    def test_independent_fingerprint(self):
        # SHA-256 of the UTF-8 bytes "Real : Type := Real"; fixed external oracle below.
        key=add_definition(Environment(),'cleanType_','Real',' : Type := Real')
        self.assertEqual(key,'cleanType_Real_3b3714aba90b969f7c2b')

    def test_stable_and_sensitive_to_meaning(self):
        one=add_definition(Environment(),'cleanDefine_','f',' : Nat := 0')
        self.assertEqual(one,add_definition(Environment(),'cleanDefine_','f',' : Nat := 0'))
        self.assertNotEqual(one,add_definition(Environment(),'cleanDefine_','f',' : Nat := 1'))
        self.assertNotEqual(add_definition(Environment(),'cleanDefine_','a b',' : Nat := 0'),
                            add_definition(Environment(),'cleanDefine_','a_b',' : Nat := 0'))

    def test_collision_is_not_silently_overwritten(self):
        env=Environment()
        with patch('cleanlang.modules.hashlib.sha256') as digest:
            digest.return_value.hexdigest.return_value='0'*64
            key=add_definition(env,'cleanDefine_','a b',' : Nat := 0')
            before=env.notation_definitions[key]
            with self.assertRaisesRegex(CleanError,'identifier collision'):
                add_definition(env,'cleanDefine_','a_b',' : Nat := 1')
            self.assertEqual(env.notation_definitions[key],before)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
