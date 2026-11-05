set nocompatible
let s:root = fnamemodify(expand('<sfile>:p'), ':h:h')
execute 'set runtimepath^=' . fnameescape(s:root . '/editors/vim')
filetype plugin on
syntax on
execute 'edit ' . fnameescape(s:root . '/library/analysis.clean')
call assert_equal('cleanmath', &filetype)
call assert_equal(1, &expandtab)
call assert_equal(2, &shiftwidth)
call setline(1, 'Define square(x):')
call setline(2, '  Means: x + x')
call setline(3, '  -- Let x: Real')
call setline(4, '  Attribution: mathlib; and')
call assert_equal('cleanMathKeyword', synIDattr(synID(1,1,1),'name'))
call assert_equal('cleanMathLean', synIDattr(synID(2,10,1),'name'))
call assert_equal('cleanMathComment', synIDattr(synID(3,6,1),'name'))
call assert_equal('cleanMathOpaque', synIDattr(synID(4,25,1),'name'))
call setline(5, 'Notation cos(x: Real): Real:')
call assert_equal('cleanMathSignature', synIDattr(synID(5,16,1),'name'))
call setline(6, '  Equals: function(x: Real,x)')
call assert_equal('cleanMathLogic', synIDattr(synID(6,11,1),'name'))
call setline(7, 'Condition positive(x: Real):')
call setline(8, '  Assumption name: positivity of {x}')
call assert_equal('cleanMathKeyword', synIDattr(synID(7,1,1),'name'))
call assert_equal('cleanMathOpaque', synIDattr(synID(8,20,1),'name'))
call setline(9, '  Let x: Real -- note')
call setline(10, '/-')
call setline(11, 'ignored')
call setline(12, '-/')
call assert_equal('cleanMathComment', synIDattr(synID(9,16,1),'name'))
call assert_equal('cleanMathBlock', synIDattr(synID(11,1,1),'name'))
call setline(13, 'Let x: /- outer /- inner -/ tail -/ Real -- end')
call assert_equal('cleanMathBlock', synIDattr(synID(13,20,1),'name'))
call assert_notequal('cleanMathBlock', synIDattr(synID(13,37,1),'name'))
call assert_equal('cleanMathComment', synIDattr(synID(13,43,1),'name'))
if len(v:errors)
 for error in v:errors | echom error | endfor
 cquit
endif
qa!

" generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
