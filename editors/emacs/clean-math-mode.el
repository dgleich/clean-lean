;;; clean-math-mode.el --- Lexical display of Clean mathematics -*- lexical-binding: t; -*-
;; Local prototype. Highlighting is not parsing or semantic validation.
(require 'prog-mode)
(defconst clean-math--keyword
  (regexp-opt '("Condition" "Holds when" "Let" "Define" "Assume" "Conclude" "Returns" "Equals" "Alias" "Phrase" "Import" "Result" "Theorem" "Context" "Notation" "Structure" "Type" "Source") 'words))
(defconst clean-math--metadata
  (regexp-opt '("Universe" "Constructor" "Assumption name" "Render" "Render latex" "Describe" "Describe plural" "Attribution" "Kind" "Label" "Title" "Author" "Year" "Version" "Revision" "URL" "References" "source" "reference" "relationship" "scope" "changes" "note") t))
(defvar-local clean-math--matched-face 'font-lock-comment-face)
(defun clean-math--comment (limit)
  "Find line or nested block comments, preserving embedded fields and strings."
  (let ((origin (point)) (depth 0) (quoted nil) start found
        (face 'font-lock-comment-face))
    (save-excursion
      (goto-char (point-min))
      (while (and (< (point) limit) (not found))
        (cond
         ((and (= depth 0) (not quoted) (bolp)
               (let ((case-fold-search t))
                 (looking-at "\\( *\\)Text\\(?: +\\(?:plain\\|latex\\|typst\\)\\)? *: *$")))
          (setq start (point) face 'font-lock-string-face)
          (let ((column (length (match-string 1))))
            (forward-line 1)
            (while (and (not (eobp))
                        (or (looking-at " *$") (> (current-indentation) column)))
              (forward-line 1)))
          (when (> (point) origin) (setq found (cons (max start origin) (point)))))
         ((and (= depth 0) (not quoted) (bolp)
               (let ((case-fold-search t))
                 (looking-at "\\( *\\)\"\"\"\\(?:plain\\|latex\\|typst\\)? *$")))
          (setq start (point) face 'font-lock-string-face)
          (let ((margin (match-string 1)))
            (forward-line 1)
            (if (re-search-forward (concat "^" margin "\"\"\" *$") nil t)
                (forward-line 1)
              (goto-char (point-max))))
          (when (> (point) origin) (setq found (cons (max start origin) (point)))))
         ((> depth 0)
          (cond ((looking-at "/-") (setq depth (1+ depth)) (forward-char 2))
                ((looking-at "-/") (setq depth (1- depth)) (forward-char 2)
                 (when (and (= depth 0) (> (point) origin))
                   (setq found (cons (max start origin) (point)))))
                (t (forward-char 1))))
         ((eq (char-after) ?\n) (setq quoted nil) (forward-char 1))
         ((eq (char-after) ?\") (setq quoted (not quoted)) (forward-char 1))
         (quoted (forward-char 1))
         ((and (bolp) (let ((case-fold-search t))
                        (looking-at " *\\(?:Means\\|From Lean\\|Render\\(?: latex\\)?\\) *:")))
          (end-of-line))
         ((looking-at "--")
          (setq face 'font-lock-comment-face start (point)) (end-of-line)
          (when (> (point) origin) (setq found (cons (max start origin) (point)))))
         ((looking-at "/-")
          (setq face (if (looking-at "/-[-!]") 'font-lock-doc-face 'font-lock-comment-face)
                start (point) depth 1)
          (forward-char 2))
         (t (forward-char 1))))
      (when (and (not found) (> depth 0) (> (point) origin))
        (setq found (cons (max start origin) (point)))))
    (when found
      (setq clean-math--matched-face face)
      (set-match-data (list (car found) (cdr found)))
      (goto-char (cdr found)) t)))

(defconst clean-math-font-lock-keywords
  `(("\\b[0-9]+\\b" . font-lock-constant-face)
    ("\\b\\(and\\|or\\|not\\|function\\|type\\|for\\|every\\|there\\|exists\\)\\b" . font-lock-keyword-face)
    (,(concat "^ *" clean-math--keyword) . font-lock-keyword-face)
    ("^ *\\(Result\\|Theorem\\|Context\\|Define\\|Notation\\|Condition\\|Structure\\|Type\\|Source\\) +\\(.+\\): *$"
     (1 font-lock-keyword-face t) (2 font-lock-function-name-face t))
    ("^ *\\(Notation\\|Condition\\|Define\\) +\\([^(]+\\)\\((.*\\): *$"
     (1 font-lock-keyword-face t) (2 font-lock-function-name-face t) (3 font-lock-type-face t))
    ("^ *\\(Let\\) +\\(.+?\\)\\(?: *:\\| +be +\\)\\(.+\\)$"
     (1 font-lock-keyword-face t) (2 font-lock-variable-name-face t) (3 font-lock-type-face t))
    (,(concat "^ *" clean-math--metadata " *:.*$") (0 font-lock-string-face t) (1 font-lock-keyword-face t))
    ("^ *\\(Means\\|From Lean\\) *:.*$" (0 font-lock-preprocessor-face t) (1 font-lock-keyword-face t))
    ("^ *Import\\b.*$" (0 font-lock-string-face t))
    (clean-math--comment (0 clean-math--matched-face t))
    ("\t+" (0 font-lock-warning-face t))))
;;;###autoload
(define-derived-mode clean-math-mode prog-mode "Clean Math"
  "Display Clean statements and definitions. Does not validate or rewrite layout."
  (setq-local font-lock-defaults '(clean-math-font-lock-keywords t t))
  (setq-local comment-start "-- ")
  (setq-local comment-end "")
  (setq-local indent-tabs-mode nil)
  (setq-local tab-width 2)
  ;; Leave indentation under author control; no speculative language formatter.
  (setq-local indent-line-function #'indent-relative))
;;;###autoload
(add-to-list 'auto-mode-alist '("\\.clean\\'" . clean-math-mode))
(provide 'clean-math-mode)
;;; clean-math-mode.el ends here

;; generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
