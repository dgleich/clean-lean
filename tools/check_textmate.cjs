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
 has('rEsUlT determinant product:','rEsUlT','keyword.declaration.clean');
 has('Define squared distance(x, y):','squared','entity.name.function.clean');
 has('  Let μ be a Complex','μ','variable.parameter.clean');
 has('  Let μ be a Complex','Complex','entity.name.type.clean');
 has('  Assume nonzero: x ≠ 0','nonzero','entity.name.label.clean');
 has('  Conclude: x ≠ 0 and y = 2','and','keyword.operator.word.clean');
 has('  Attribution: mathlib; Matrix.det_mul; adapted','adapted','string.unquoted.metadata.clean');
 has('  Means: if p then a else b','if','meta.embedded.line.lean.clean');
 has('  Render latex: x^2 and y','and','string.unquoted.metadata.clean');
 has('  # Let x = 1','Let','comment.line.number-sign.clean');
 assert(!scopeAt('  Let x = 1 # not a comment','#').includes('comment.line.number-sign.clean'));
 has('\tLet x: Real','\t','invalid.illegal.tab.clean');
 has('Notation cos(x: Real): Real:','cos','entity.name.function.clean');
 has('Notation cos(x: Real): Real:','x: Real','meta.signature.clean');
 console.log('14 TextMate/Oniguruma scope checks passed');
})().catch(e=>{console.error(e);process.exitCode=1;});
