:::llm gpt-6 2026-11-07 role=assisted

# Reproducing historical patch studies

Patch studies now use `tools/study_checkout.py` to export compiler, library, tests
and generator files from the immutable baseline
`fa2c297cf833bfc1f126606eaeac2cb53849c453`. This is the last recorded compiler before
integration of the seven binding repairs. The driver overlays current tracked
study files and then applies its explicitly listed patches. The ordinary compiler
can evolve without causing historical patches to apply twice or onto a different
base. There is no runtime compatibility layer in the language implementation.

Study files come from the tracked worktree so intermediate work can be checked
before committing; stage new study inputs before running a default driver.
The pinned compiler's tests and corpus generators remain historical tests, not
validation of a later production compiler. A study's reported checks apply only
to its explicitly constructed compiler stack.

The helper requires the pinned commit to exist locally. A shallow checkout that
omits it fails with an instruction to fetch repository history. It does not
silently substitute HEAD. Dependencies are reused through the existing local
`.lake` symlink; the helper does not fetch or upgrade them.

The eleven affected drivers cover carrier fields, retained calls, proof bindings,
annotations, operator variants, local type identity, native type bindings,
qualified globals and the combined operator study. Their mathematical checks and
patch order do not change.

`python tools/check_study_checkout.py` verifies the baseline compiler/grammar/test
and generator bytes, current study overlay, dependency path, rejection of a
nonempty destination, and application of all eight composition patches. The
combined driver remains the native end-to-end check. Full language conformance
and production integration require their own validation.
:::
