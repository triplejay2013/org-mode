;; Sage Mode config - Melpa
;; REF: https://github.com/sagemath/sage-shell-mode#installation-and-setup
(setq sage-shell:sage-root "~/.src/SageMath/")
;(setq sage-shell:sage-executable "~/.src/SageMath/sage")
(sage-shell:define-alias)
(setq sage-shell:input-history-cache-file "~/.emacs.d/.sage_shell_input_history")


;;Ob-sagemath support for babel
;;REF: https://github.com/stakemori/ob-sagemath
;; Ob-sagemath supports only evaluating with a session.
(setq org-babel-default-header-args:sage '((:session . t)
                                           (:results . "output")))
;; C-c c for asynchronous evaluating (only for SageMath code blocks).
(with-eval-after-load "org"
  (define-key org-mode-map (kbd "C-c c") 'ob-sagemath-execute-async))
;; Do not evaluate code blocks when exporting.
(setq org-export-babel-evaluate nil)
;; Show images when opening a file.
(setq org-startup-with-inline-images t)
;; Show images after evaluating code blocks.
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
