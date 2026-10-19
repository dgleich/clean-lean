;;; Run: emacs --batch -Q -l tools/check_emacs.el
(require 'ert)
(load (expand-file-name "../editors/emacs/clean-math-mode.el"
                        (file-name-directory load-file-name)) nil t)
(ert-deftest clean-math-highlights ()
  (with-temp-buffer
    (insert "rEsUlT sample:\n  Let μ be Complex\n  Means: if p then x else y\n  # Let z: Real\n")
    (clean-math-mode)
    (font-lock-ensure)
    (should-not indent-tabs-mode)
    (goto-char (point-min))
    (should (eq (get-text-property (point) 'face) 'font-lock-keyword-face))
    (search-forward "Complex")
    (should (eq (get-text-property (1- (point)) 'face) 'font-lock-type-face))
    (search-forward "then")
    (should (eq (get-text-property (1- (point)) 'face) 'font-lock-preprocessor-face))
    (search-forward "Let z")
    (should (eq (get-text-property (1- (point)) 'face) 'font-lock-comment-face))))
(ert-run-tests-batch-and-exit)
