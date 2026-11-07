# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Check statement visibility and exact native targets across late declarations."""
from pathlib import Path
import ast,os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
from cleanlang.syntax import document
from cleanlang.core import normalize_layout
e=Environment();results=load_document(HERE/'Statements.clean',e)
assert len(results)==2
assert results[0].conclusion.tree==['Operator','=', ['Local','x'],['Local','x']]
assert results[1].conclusion.tree==['Operator','≥',['Call','absolute value',[['Local','x']]],['Call','scalar zero',[]]]
assert 'T' not in results[0].environment.data['types']
assert 'absolute value' not in results[0].environment.data['functions']
assert 'absolute value' in results[1].environment.data['functions']
assert [node.kind for node in document(normalize_layout((HERE/'Statements.clean').read_text()))]==[
 'import_stmt','declaration','result','declaration','import_stmt','result']
generated=lean(results,e,[]);(HERE/'Generated.lean').write_text(generated)
(HERE/'Statements.tex').write_text(latex(results,e))
parsed=ast.parse((ROOT/'tools/check_basic_targets.py').read_text())
comparison=next(ast.literal_eval(n.value) for n in parsed.body if isinstance(n,ast.Assign)
 and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
zero=e.data['functions']['scalar zero']['lean'].split()[0]
wrapper=e.data['functions']['absolute value']['lean'].split()[0]
native='import Lean\n'+generated+comparison+f'''
noncomputable def expected_absolute (x : Real) : Real := abs x
same_basic_target {wrapper} expected_absolute
noncomputable def expected_zero : Real := 0
same_basic_target {zero} expected_zero

def expected_arbitrary_equality : Prop := ∀ (T : Type) (x : T), x = x
same_basic_target CleanStatements.arbitrary_equality expected_arbitrary_equality

def expected_absolute_nonnegative : Prop := ∀ (x : Real), {wrapper} x ≥ {zero}
same_basic_target CleanStatements.absolute_value_nonnegative expected_absolute_nonnegative

theorem arbitrary_equality_checked : CleanStatements.arbitrary_equality := by
 intro T x
 rfl

theorem absolute_nonnegative_checked : CleanStatements.absolute_value_nonnegative := by
 intro x
 change abs x ≥ 0
 exact abs_nonneg x
'''
(HERE/'Verified.lean').write_text(native)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(HERE/'Verified.lean')],cwd=ROOT,check=True)
print('Four exact sequential-scope targets and two proofs passed')

# generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
