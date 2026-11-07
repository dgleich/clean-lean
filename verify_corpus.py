"""Generate statement-level proof checks against the curated Mathlib declarations.
No proof syntax is exposed in Clean v0.1. These are validation fixtures only.
"""
import json
from pathlib import Path
from cleanlang.core import Environment,lean
from cleanlang.modules import load_document
from cleanlang.__main__ import combine
root=Path(__file__).parent
environments=[]; items=json.loads((root/'corpus/catalog.json').read_text())
results=[]
for path in sorted((root/'corpus').glob('*.clean')):
    env=Environment(); results+=load_document(path,env); environments.append(env)
reg=combine(environments)
byname={r.name:r for r in results}
# Declared numeral adapters denote Nat casts; zero and one require their
# Mathlib cast laws rather than an assumption of definitional equality.
numerals=[spec['numerals']['native_binding'] for spec in reg.data['types'].values() if 'numerals' in spec]
normalize='  try simp only ['+', '.join(numerals+['Nat.cast_zero','Nat.cast_one'])+'] at *'
out=[lean(results,reg,[]),'namespace CleanValidation']
for item in items:
    r=byname[item['name']]; params=[n for c in r.clauses for n in c.names]
    out += [f'theorem {r.name} : CleanStatements.{r.name} := by', '  intro '+' '.join(params), normalize, '  exact '+item['proof'],'']
out+=['end CleanValidation']
(root/'generated'/'VerifiedCorpus.lean').write_text('\n'.join(out)+'\n')
print('Wrote',len(items),'proof fixtures')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
