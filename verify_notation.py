"""Generate an independently checked proof for the explicit notation example."""
from pathlib import Path
from cleanlang.core import Registry, lean
from cleanlang.modules import load_document

reg = Registry()
# Demonstrate that the new example does not obtain its algorithm from JSON.
del reg.data['functions']['insertionSort']
results = load_document(Path('examples/notation.clean'), reg)
output = lean(results, reg, ['Mathlib.Data.List.Sort'])
output += '''
example : CleanStatements.insertion_sort_preserves_length := by
  intro xs
  exact List.length_insertionSort (r := (· ≤ ·)) xs
'''
Path('generated/VerifiedNotation.lean').write_text(output)
