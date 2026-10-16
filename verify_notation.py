"""Generate an independently checked proof for the explicit notation example."""
from pathlib import Path
from cleanlang.core import Environment, lean
from cleanlang.modules import load_document

reg = Environment()
results = load_document(Path('examples/notation.clean'), reg)
output = lean(results, reg, [])
output += '''
example : CleanStatements.insertion_sort_preserves_length := by
  intro xs
  exact List.length_insertionSort (r := (· ≤ ·)) xs
'''
Path('generated/VerifiedNotation.lean').write_text(output)
