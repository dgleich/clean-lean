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
call setline(3, '  # Let x: Real')
call setline(4, '  Attribution: mathlib; and')
call assert_equal('cleanMathKeyword', synIDattr(synID(1,1,1),'name'))
call assert_equal('cleanMathLean', synIDattr(synID(2,10,1),'name'))
call assert_equal('cleanMathComment', synIDattr(synID(3,6,1),'name'))
call assert_equal('cleanMathOpaque', synIDattr(synID(4,25,1),'name'))
call setline(5, 'Notation cos(x: Real): Real:')
call assert_equal('cleanMathSignature', synIDattr(synID(5,16,1),'name'))
if len(v:errors)
 for error in v:errors | echom error | endfor
 cquit
endif
qa!
