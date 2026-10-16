"""Generate statement-level proof checks against the curated Mathlib declarations.
No proof syntax is exposed in Clean v0.1. These are validation fixtures only.
"""
import json
from pathlib import Path
from cleanlang.core import Registry,parse,lean
root=Path(__file__).parent
reg=Registry(); imports=json.loads((root/'imports.json').read_text()); items=json.loads((root/'corpus/catalog.json').read_text())
results=[]
for path in sorted((root/'corpus').glob('*.clean')): results+=parse(path.read_text(),reg)
byname={r.name:r for r in results}
out=[lean(results,reg,imports),'namespace CleanValidation']
for item in items:
    r=byname[item['name']]; params=[n for c in r.clauses for n in c.names]
    out += [f'theorem {r.name} : CleanStatements.{r.name} := by', '  intro '+' '.join(params), '  exact '+item['proof'],'']
out+=['end CleanValidation']
(root/'generated'/'VerifiedCorpus.lean').write_text('\n'.join(out)+'\n')
print('Wrote',len(items),'proof fixtures')
