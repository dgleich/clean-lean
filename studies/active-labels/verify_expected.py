# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Check prospective native target shapes; does not compare specialized Clean output."""
from pathlib import Path
import os,re,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
# Refresh and kernel-check the exact foundation used by this preview.
subprocess.run([sys.executable,str(HERE/'verify_arithmetic.py')],cwd=ROOT,check=True)
source=(HERE/'Arithmetic.lean').read_text()
def emitted(prefix,name):
 matches=re.findall(r'\b'+prefix+re.escape(name.replace(' ','_'))+r'_[0-9a-f]+\b',source)
 values=set(matches)
 if len(values)!=1:raise ValueError('Expected exactly one binding for '+name)
 return next(iter(values))
f=lambda name:emitted(r'clean(?:Notation|Define|Constructor)_',name)
keys={k:emitted('cleanType_',n) for k,n in [('TYPE','Type'),('NAT','Natural'),('VERTEX','Vertex'),('SET','Set'),('EL','Element'),('EQUIVALENCE','Equivalence')]}
keys.update({k:f(n) for k,n in [('LE','natural at most'),('ADD','natural sum'),('EQ','equal'),('AT','interval labels at'),('SUR','surviving interval labels'),('SUBPATH','subpath vertex'),('RESTRICT','restricted interval labels'),('GFORWARD','restrict element'),('GBACKWARD','restore element'),('GEQUIV','subtype restriction equivalence'),('VALUE','element value'),('EVAL','equivalence forward')]})
keys.update(NUM=emitted('cleanNumeral_','Natural'),LABELS=emitted('cleanStructure_','IntervalLabels'),SUPPORT=emitted('cleanStructure_','SubtypeRestrictionSupport'))
keys.update(OLD='ActiveOracle.old',NEW='ActiveOracle.new',FORWARD='ActiveOracle.forward',BACKWARD='ActiveOracle.backward')
expected=(HERE/'ActiveOracle.lean.in').read_text()
for key,value in keys.items():expected=re.sub(r'\b'+key+r'\b',value,expected)
proofs='''
theorem expected_left : ActiveOracle.leftStatement := by
 intro I n a m h L v support x
 apply Subtype.ext
 rfl
theorem expected_right : ActiveOracle.rightStatement := by
 intro I n a m h L v support y
 apply Subtype.ext
 apply Subtype.ext
 rfl
theorem expected_existence : ActiveOracle.existsStatement := by
 exact Arithmetic.active_labels_exist
'''
with tempfile.TemporaryDirectory(prefix='clean-active-expected-') as directory:
 path=Path(directory)/'Expected.lean';path.write_text(source+expected+proofs)
 subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Independent specialized target shapes and three native proofs checked; specialized Clean comparison remains pending.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
