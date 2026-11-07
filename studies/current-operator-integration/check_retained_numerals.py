# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
from pathlib import Path
from cleanlang.core import Environment,Expressions
from cleanlang.modules import load_module
from cleanlang.numeral_inference import declare_default
from cleanlang.bound_calls import bind,UnclosedBinding
from cleanlang.syntax import parse,expression_tree
common=Path('studies/module-numerals/Common.clean.proposed')
a=Environment();load_module(common,a);declare_default('Counting',a)
b=Environment();load_module(common,b);declare_default('Real',b)
tree=expression_tree(parse('1=1','expression'))
retained=bind(tree,a,{})
assert retained[0]=='ModuleCall'
assert all(x[0]=='BoundNumeral' and x[2]=='Counting' for x in retained[2]),retained
assert Expressions(b,{}).elaborate(retained).lean==Expressions(a,{}).parse('1=1').lean
assert Expressions(b,{}).elaborate(retained).lean!=Expressions(b,{}).parse('1=1').lean
try:bind(expression_tree(parse('equal(1,1)','expression')),a,{})
except UnclosedBinding:pass
else:raise AssertionError('raw numeral escaped closure')
print('Retained operator numeral scope checks passed')

# generated: gpt-6 2026-11-07 role=assisted; LLM-authored portions; see PROVENANCE.md
