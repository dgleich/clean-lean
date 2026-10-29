;;; clean-math-mode.el --- Lexical display of Clean mathematics -*- lexical-binding: t; -*-
;; Local prototype. Highlighting is not parsing or semantic validation.
(require 'prog-mode)
(defconst clean-math--keyword
  (regexp-opt '("Let" "Define" "Assume" "Conclude" "Returns" "Equals" "Alias" "Phrase" "Import" "Result" "Theorem" "Context" "Notation" "Type" "Source") 'words))
(defconst clean-math--metadata
  (regexp-opt '("Render" "Render latex" "Describe" "Describe plural" "Attribution" "Kind" "Label" "Title" "Author" "Year" "Version" "Revision" "URL" "References" "source" "reference" "relationship" "scope" "changes" "note") t))
(defconst clean-math-font-lock-keywords
  `(("\\b[0-9]+\\b" . font-lock-constant-face)
    ("\\b\\(and\\|or\\|not\\|function\\)\\b" . font-lock-keyword-face)
    (,(concat "^ *" clean-math--keyword) . font-lock-keyword-face)
    ("^ *\\(Result\\|Theorem\\|Context\\|Define\\|Notation\\|Type\\|Source\\) +\\(.+\\): *$"
     (1 font-lock-keyword-face t) (2 font-lock-function-name-face t))
    ("^ *\\(Notation\\|Define\\) +\\([^(]+\\)\\((.*\\): *$"
     (1 font-lock-keyword-face t) (2 font-lock-function-name-face t) (3 font-lock-type-face t))
    ("^ *\\(Let\\) +\\(.+?\\)\\(?: *:\\| +be +\\)\\(.+\\)$"
     (1 font-lock-keyword-face t) (2 font-lock-variable-name-face t) (3 font-lock-type-face t))
    (,(concat "^ *" clean-math--metadata " *:.*$") (0 font-lock-string-face t) (1 font-lock-keyword-face t))
    ("^ *\\(Means\\|From Lean\\) *:.*$" (0 font-lock-preprocessor-face t) (1 font-lock-keyword-face t))
    ("^ *Import\\b.*$" (0 font-lock-string-face t))
    ("^ *#.*$" (0 font-lock-comment-face t))
    ("\t+" (0 font-lock-warning-face t))))
;;;###autoload
(define-derived-mode clean-math-mode prog-mode "Clean Math"
  "Display Clean statements and definitions. Does not validate or rewrite layout."
  (setq-local font-lock-defaults '(clean-math-font-lock-keywords t t))
  (setq-local indent-tabs-mode nil)
  (setq-local tab-width 2)
  ;; Leave indentation under author control; no speculative language formatter.
  (setq-local indent-line-function #'indent-relative))
;;;###autoload
(add-to-list 'auto-mode-alist '("\\.clean\\'" . clean-math-mode))
(provide 'clean-math-mode)
;;; clean-math-mode.el ends here

;; generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
