// Optional: NODE_PATH=/path/to/node_modules node tools/check_textmate.cjs
const fs=require('fs'),path=require('path'),assert=require('assert');
const tm=require('vscode-textmate'),onig=require('vscode-oniguruma');
(async()=>{
 const wasm=fs.readFileSync(require.resolve('vscode-oniguruma/release/onig.wasm'));
 await onig.loadWASM(wasm.buffer.slice(wasm.byteOffset,wasm.byteOffset+wasm.byteLength));
 const registry=new tm.Registry({onigLib:Promise.resolve({createOnigScanner:p=>new onig.OnigScanner(p),createOnigString:s=>new onig.OnigString(s)}),loadGrammar:async()=>JSON.parse(fs.readFileSync(path.join(__dirname,'../editors/vscode/syntaxes/clean.tmLanguage.json'),'utf8'))});
 const grammar=await registry.loadGrammar('source.clean');
 function scopeAt(line,word){const pos=line.indexOf(word);return grammar.tokenizeLine(line).tokens.find(t=>t.startIndex<=pos&&t.endIndex>pos).scopes;}
 function has(line,word,scope){assert(scopeAt(line,word).includes(scope),JSON.stringify({line,word,scopes:scopeAt(line,word)}));}
 for (const word of ['for','every','there','exists']) has('for every (x: Real, there exists (y: Real,x=y))',word,'keyword.operator.word.clean');
 has('Structure Endpoints():','Structure','keyword.declaration.clean');
 has('  Universe: 1','Universe','keyword.other.metadata.clean');
 has('  Constructor: endpoints','Constructor','keyword.other.metadata.clean');
 has('rEsUlT determinant product:','rEsUlT','keyword.declaration.clean');
 has('Define squared distance(x, y):','squared','entity.name.function.clean');
 has('  Let μ be a Complex','μ','variable.parameter.clean');
 has('  Let μ be a Complex','Complex','entity.name.type.clean');
 has('  Assume nonzero: x ≠ 0','nonzero','entity.name.label.clean');
 has('  Conclude: x ≠ 0 and y = 2','and','keyword.operator.word.clean');
 has('  Attribution: mathlib; Matrix.det_mul; adapted','adapted','string.unquoted.metadata.clean');
 has('  Means: if p then a else b','if','meta.embedded.line.lean.clean');
 has('  Render latex: x^2 and y','and','string.unquoted.metadata.clean');
 has('  -- Let x = 1','Let','comment.line.double-dash.clean');
 has('  Let x = 1 -- a comment','--','comment.line.double-dash.clean');
 has('  Means: #[1, 2]','#','meta.embedded.line.lean.clean');
 let state=grammar.tokenizeLine('/-').ruleStack;
 let block=grammar.tokenizeLine('  Let ignored: Real',state);
 assert(block.tokens.every(t=>t.scopes.includes('comment.block.clean')));
 state=grammar.tokenizeLine('-/',block.ruleStack).ruleStack;
 assert(!grammar.tokenizeLine('Let x: Real',state).tokens[0].scopes.includes('comment.block.clean'));
 has('\tLet x: Real','\t','invalid.illegal.tab.clean');
 has('Notation cos(x: Real): Real:','cos','entity.name.function.clean');
 has('Notation cos(x: Real): Real:','x: Real','meta.signature.clean');
 has('  Equals: function(x: Real,x)','function','keyword.control.clean');
 has('Condition positive(x: Real):','Condition','keyword.declaration.clean');
 has('  Assume positive(x), positive(y)','Assume','keyword.control.clean');
 has('  Holds when: x > 0','Holds when','keyword.control.clean');
 has('  Assumption name: positivity of {x}','positivity','string.unquoted.metadata.clean');
 has('  Let x: /- inline -/ Real','inline','comment.block.clean');
 has('  Let x: /- inline -/ Real -- end','--','comment.line.double-dash.clean');
 assert(!scopeAt('  Let x: /- inline -/ Real','Real').includes('comment.block.clean'));
 has('/-- A definition. -/','definition','comment.block.documentation.clean');
 for (const opener of ['Text latex:', '\"\"\"latex']) {
   let state=grammar.tokenizeLine(opener).ruleStack;
   let body=grammar.tokenizeLine('  Result fake: -- literal prose',state);
   assert(body.tokens.every(t=>t.scopes.includes('markup.raw.clean')));
   state=body.ruleStack;
   if(opener.startsWith('"')) state=grammar.tokenizeLine('"""',state).ruleStack;
   assert(!grammar.tokenizeLine('Result real:',state).tokens[0].scopes.includes('markup.raw.clean'));
 }
 console.log('TextMate/Oniguruma scope checks passed');
})().catch(e=>{console.error(e);process.exitCode=1;});

// generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
