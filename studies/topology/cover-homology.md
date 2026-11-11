:::llm gpt-6 2026-11-11 role=assisted

# Open-cover homology maps into the ambient space

The [Clean module](../../library/topology/cover_homology.clean) connects the
[certified open-cover interface](open-covers.md) to actual singular homology.
For a cover `C` of `X`, it defines

- `cover intersection map(field,H,X,C)`: H(U ∩ V) → H(U) ⊕ H(V),
  with the usual minus sign on the right inclusion;
- `cover ambient map(field,H,X,C)`: H(U) ⊕ H(V) → H(X),
  adding the two inclusion-induced maps.

Here U and V are `C.left.carrier` and `C.right.carrier`. `H` explicitly supplies
the coefficient module and homology degree. The target of the second map is the
ambient space itself, not the subtype space on U ∪ V. No equality transport or
unproved identification of those spaces is hidden in the definition.

The only new native adapter constructs the continuous subtype-to-ambient map
from `Subtype.val` and Mathlib's `continuous_subtype_val`. The homology inclusion
and both cover maps are authored as Clean `Define` blocks. The signed intersection
map reuses the previously checked inclusion-map construction.

The [result](CoverHomology.clean) uses local `Let` names for the three modules,
then states that the two maps compose to zero. Those names remain Lean `let`s in
the generated theorem statement and its independent canonical target. The native
proof uses functoriality of actual singular homology and cancellation of the two
identical composite inclusions. It does not use openness or the coverage certificate:
zero composition holds for arbitrary two subsets; exactness needs more topology.

[verify_cover_homology.py](verify_cover_homology.py) generates
[CoverHomology.lean](CoverHomology.lean) and
[CoverHomologyVerified.lean](CoverHomologyVerified.lean). It checks five independent
canonical targets (the four maps and statement) and proves the continuous map's
value formula and the zero composite. Run it from the repository root with the
pinned environment:

```sh
LAKE=/home/claude/.elan/bin/lake python3 studies/topology/verify_cover_homology.py
```

The geometric short exact chain sequence, excision, connecting map identification,
and degree-zero/augmentation treatment remain missing. These maps and their zero
composite are ingredients of Mayer–Vietoris, not a proof of exactness. No additional
language syntax is required by this construction.
:::


:::llm gpt-6 2026-11-11 role=assisted

Validation passes: five exact native targets and two proofs; legacy/joint generated
text agreement with matching unchanged source fingerprints; and all 92 regenerated
corpus proofs. The compatibility observation is retained under
`cover_homology_module` in [the report](../parameterized-literals/compatibility.json).
Reference HTML IDs/local paths and provenance checks pass. No parser, elaborator
or production inference routing changed.
:::
