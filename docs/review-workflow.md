:::llm 2026-10-23 role=assisted

# Reviewing Clean

Open [the local review workspace](review.html). It contains a searchable snapshot
of all authored files under `library`, `corpus`, and `examples`, with highlighting,
declaration navigation, import links, and generated Lean alongside the source.
No server, network connection, or editor extension is required. It is a read-only
viewer; source editing stays in your editor.

## A useful first pass

1. Read **library/analysis.clean**, especially `square` and `squared distance`.
   Does the definition read naturally? Is the meaning obvious without Lean?
2. Read **corpus/analysis.clean** and **corpus/linear_algebra.clean**. Look at one
   familiar theorem at a time. Check hypotheses, scope, and the conclusion.
3. Compare **library/graph_theory.clean** with **library/papers.clean**. Identify
   each definition that still needs a Lean body and the missing Clean construct.
4. Open the [typeset specimen](../generated/specimen.pdf). Mathematical meaning
   should survive the transition from authored source to typeset text.
5. Use the [Clean-to-Lean map](clean-to-lean.html) for scope and translation details,
   and the [aspirational examples](aspirational-syntax.md) for the readability goal.

For each rough edge, record a line, the current spelling, your preferred spelling,
and whether the issue is readability, meaning, or a missing language feature.
The browser has per-file notes and **Export review notes**. Storage is local to
your browser profile and may be unavailable for local files; export before moving
or rebuilding the page. Exported notes include source hashes. After a rebuild,
notes for changed source are identified as belonging to an earlier snapshot.
No notes are sent anywhere or automatically committed.

## Rebuild

From the repository root, using the Python environment with the optional BibTeX
extra if you want the BibTeX example translated too:

```sh
python3 tools/build_review.py
```

The builder rereads each source and invokes the current translator. It embeds the
result, errors, source hashes, and repository revision in `docs/review.html`.
Translation errors stay visible and do not prevent browsing the other files.
A missing optional BibTeX dependency is reported on its example, not hidden.
The builder does **not** execute Lean. The PDF is a separate generated artifact;
rebuilding this page does not regenerate it. A declaration jump also scrolls to
its Lean definition/result when that generated identity is available.

The portable HTML works over `file://` and can be copied elsewhere; repository
links (raw source, PDF, spec) require the accompanying directory structure. It
requires JavaScript for navigation and includes a no-JavaScript link to the
static reference. The source is `tools/review/index.html`; edit that template,
not the generated HTML.

## Editor support and future work

[VS Code, Emacs, and Vim setup](../editors/README.md) is available now. Coloring is
lexical. The compiler remains the authority for parsing and translation.

The next useful review features would be semantic go-to-definition, a per-result
rendered mathematical preview, source-linked diagnostics, and a side-by-side
revision comparison. Those should use compiler output; the viewer's lightweight
declaration index must not grow into a competing parser. The current viewer does
not provide a live editor, recompile on keystrokes, or prove results.

Validation: 119 Python tests, real TextMate/Oniguruma scopes, Vim runtime checks,
and browser integration checks passed. Browser checks cover searching, imports,
declaration and target jumps, note persistence/export, responsive layout, and the
no-JavaScript fallback. Emacs and the full VS Code application were unavailable;
the native Emacs check is provided but not yet run. See `tools/check_review.py` for
the optional Playwright check; no browser dependency is required to build the page.


:::llm gpt-6 2026-11-11 role=assisted

## Reviewing study drafts

The inventory includes `studies` as well as `library`, `corpus`, and `examples`.
Both `.clean` and `.clean.proposed` sources are searchable. Files ending in
`.clean.proposed`, and files under `examples/proposed`, are labeled **Proposed
syntax · no translation attempted**. Their source, outline, imports and notes
remain available, but they are never sent to the translator. An ordinary `.clean`
file that fails translation still displays its error; a neighboring draft does
not change that status.

For the topology work, open `studies/topology/Targets.clean.proposed` beside the
implemented `OpenCovers.clean` and `CoverHomology.clean` examples. For LAProof,
`studies/laproof/Paper.clean.proposed` records the pending IEEE theorem interfaces.
Imports whose targets are absent from the inventory say **not in snapshot**
instead of appearing as navigation links. This label means the viewer has no
embedded source for that path; it does not determine whether the module exists
elsewhere or whether the mathematics can be implemented.

Use `python3 tools/build_review.py --progressive` to publish the current source
inventory before all translations finish. A partial snapshot explicitly counts
pending translations. Proposed files retain their separate status throughout;
neither a completed browser build nor a translated statement certifies a proof.
:::

:::llm gpt-6 2026-11-11 role=assisted

Draft-review validation: seven progressive-inventory tests and seven lexical
review tests pass. A saved partial snapshot contains 205 sources, including 34
`.clean.proposed` files. The Chromium check passes source fidelity, draft status,
topology declaration navigation, LAProof missing-import labels and valid import
navigation, note persistence, and desktop/mobile layout. Long import paths now
wrap on narrow screens. These checks do not establish translation or proof
coverage. The full progressive rebuild remains running; its published snapshot
is explicitly incomplete. The two whole-inventory translation tests are not
rerun as part of this focused UI check.
:::
