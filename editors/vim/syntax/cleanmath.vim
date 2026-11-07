" Lexical display only. Mathematical names are case-sensitive; keyword spelling is not.
if exists('b:current_syntax') | finish | endif
syntax case match
syntax sync fromstart
syntax match cleanMathNumber '\<\d\+\>'
syntax match cleanMathOperator '[+*/^=<>−-]\|[↔→≤≥≠∧∨¬∈⊆∪∩∣]'
syntax match cleanMathDelimiter '[().,:;]'
syntax match cleanMathLogic '\c\<\%(and\|or\|not\|function\|type\|for\|every\|there\|exists\)\>'
syntax match cleanMathSignature '(.*\ze:\s*$' contained
syntax match cleanMathKeyword '\c^ *\%(Condition\|Holds when\|Let\|Define\|Assume\|Conclude\|Returns\|Equals\|Alias\|Phrase\|Result\|Theorem\|Context\|Notation\|Condition\|Structure\|Type\|Source\)\>' containedin=ALLBUT,cleanMathComment,cleanMathOpaque,cleanMathLean,cleanMathImport,cleanMathText,cleanMathTriple,cleanMathDoc
syntax match cleanMathDeclaration '\c^ *\%(Result\|Theorem\|Context\|Define\|Notation\|Condition\|Structure\|Type\|Source\)\>.*:$' contains=cleanMathKeyword,cleanMathDelimiter,cleanMathSignature
syntax match cleanMathTypedLet '\c^ *Let\>.*\%(:\|\<be\>\).*' contains=cleanMathKeyword,cleanMathDelimiter
syntax match cleanMathMetadataKey '\c^ *\%(Universe\|Constructor\|Assumption name\|Render\%( latex\)\?\|Describe\%( plural\)\?\|Attribution\|Kind\|Label\|Title\|Author\|Year\|Version\|Revision\|URL\|References\|source\|reference\|relationship\|scope\|changes\|note\)\s*:' contained
syntax match cleanMathOpaque '\c^ *\%(Universe\|Constructor\|Assumption name\|Render\%( latex\)\?\|Describe\%( plural\)\?\|Attribution\|Kind\|Label\|Title\|Author\|Year\|Version\|Revision\|URL\|References\|source\|reference\|relationship\|scope\|changes\|note\)\s*:.*$' contains=cleanMathMetadataKey
syntax match cleanMathLean '\c^ *\%(Means\|From Lean\)\s*:.*$'
syntax match cleanMathImport '\c^ *Import\>.*$'
syntax region cleanMathQuote start='"' end='"' oneline containedin=ALLBUT,cleanMathComment,cleanMathBlock,cleanMathLean,cleanMathOpaque,cleanMathText,cleanMathTriple,cleanMathDoc
syntax match cleanMathComment '--.*$' containedin=ALLBUT,cleanMathQuote,cleanMathLean,cleanMathRender,cleanMathBlock,cleanMathText,cleanMathTriple,cleanMathDoc
syntax region cleanMathBlock start='/-' end='-/' contains=cleanMathBlock containedin=ALLBUT,cleanMathQuote,cleanMathLean,cleanMathRender,cleanMathComment,cleanMathText,cleanMathTriple,cleanMathDoc
syntax match cleanMathRender '\c^ *Render\%( latex\)\?\s*:.*$'
syntax region cleanMathText start='\c^\z( *\)Text\%( \+\%(plain\|latex\|typst\)\)\? *: *$' end='^\%(\z1 \+\)\@!\ze *\S'
syntax region cleanMathTriple start='\c^\z( *\)"""\%(plain\|latex\|typst\)\? *$' end='^\z1""" *$'
syntax region cleanMathDoc matchgroup=cleanMathDoc start='^ */-[-!]' end='-/' contains=cleanMathBlock
highlight default link cleanMathText String
highlight default link cleanMathTriple String
highlight default link cleanMathDoc SpecialComment
highlight default link cleanMathRender String
highlight default link cleanMathBlock Comment
syntax match cleanMathTab '\t' containedin=ALL
highlight default link cleanMathSignature Type
highlight default link cleanMathDeclaration Function
highlight default link cleanMathTypedLet Type
highlight default link cleanMathKeyword Keyword
highlight default link cleanMathMetadataKey Keyword
highlight default link cleanMathLogic Keyword
highlight default link cleanMathNumber Number
highlight default link cleanMathOperator Operator
highlight default link cleanMathDelimiter Delimiter
highlight default link cleanMathOpaque String
highlight default link cleanMathLean Special
highlight default link cleanMathImport Include
highlight default link cleanMathComment Comment
highlight default link cleanMathTab Error
let b:current_syntax = 'cleanmath'

" generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
