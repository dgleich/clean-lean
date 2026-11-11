# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Guard the evidence boundary of the isolated compatibility driver."""
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

from tools import check_joint_compatibility as checker


class CompatibilityEvidenceTests(unittest.TestCase):
    def test_declaration_module_emits_definitions(self):
        path = checker.ROOT / 'studies/topology/Common.clean'
        legacy = checker.worker(path, 'legacy')
        joint = checker.worker(path, 'joint')
        self.assertEqual(legacy['input_kind'], 'module')
        self.assertEqual(legacy['results'], 0)
        self.assertEqual(checker.compare(legacy, joint), 'same-generated-text')
        # The module has declarations: its output must differ from an empty file.
        with tempfile.TemporaryDirectory() as directory:
            empty = Path(directory) / 'empty.clean'
            empty.write_text('-- empty module\n')
            other = checker.worker(empty, 'legacy')
        self.assertEqual(other['status'], 'translated')
        self.assertNotEqual(legacy['lean_sha256'], other['lean_sha256'])

    def test_invalid_result_is_not_reclassified_as_module(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'invalid.clean'
            path.write_text('Result incomplete:\n  Conclude: unknown expression\n')
            result = checker.worker(path, 'legacy')
        self.assertEqual(result['status'], 'error')
        self.assertNotIn('lean_sha256', result)

    def test_source_mutation_invalidates_observed_translation(self):
        path = checker.ROOT / 'studies/topology/Common.clean'
        with patch.object(checker, 'snapshot', side_effect=[{'source': 'before'}, {'source': 'after'}]):
            result = checker.worker(path, 'joint')
        self.assertEqual(result['observed_status'], 'translated')
        self.assertEqual(result['status'], 'inputs-changed')
        self.assertFalse(result['inputs_stable'])
        self.assertNotEqual(checker.compare(result, result), 'same-generated-text')

    def test_identical_output_does_not_hide_different_sources(self):
        record = dict(status='translated', lean_sha256='same', inputs_stable=True)
        self.assertEqual(checker.compare(
            dict(record, snapshot={'source': 'a'}),
            dict(record, snapshot={'source': 'b'})), 'different-input-snapshots')

    def test_historical_records_without_fingerprints_are_not_a_gate(self):
        record = dict(status='translated', lean_sha256='same')
        self.assertEqual(checker.compare(record, record), 'missing-input-snapshot')

    def test_direct_external_source_is_fingerprinted(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'external.clean'
            path.write_text('-- first\n')
            before = checker.snapshot(path)
            path.write_text('-- second\n')
            after = checker.snapshot(path)
        self.assertEqual(before['implementation_sha256'], after['implementation_sha256'])
        self.assertNotEqual(before['clean_sources_sha256'], after['clean_sources_sha256'])


if __name__ == '__main__':
    unittest.main()

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
