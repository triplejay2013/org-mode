; Evil Mode setup
; this can be found at:
; 	https://github.com/emacs-evil/evil
(add-to-list 'load-path "~/.emacs.d/evil")
(setq evil-want-C-i-jump nil); this fixes tab issues using EVIL with org mode
(require 'evil)
(evil-mode 1)

; Makes a prettier indentation format showing less stars
(setq org-hide-leading-stars t)

; Org Mode set up (as per manual instructions)
; https://orgmode.org/manual/Installation.html#Installation
(add-to-list 'load-path "~/.src/org-mode/lisp")

; adds contributed libraries not included in Emacs
(add-to-list 'load-path "~/.src/org-mode/contrib/lisp" t)

; Suggestd org commands
; https://orgmode.org/manual/Activation.html#Activation
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)

; use font-lock globally in emacs
; (add-hook 'org-mode-hook 'turn-on-font-lock)

; avoid invisible edits
(setq-default org-catch-invisibile-edits 'smart)

; Fast access to TODO states
; REF: https://orgmode.org/manual/Fast-access-to-TODO-states.html#Fast-access-to-TODO-states
(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d)")
	(sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
	(sequence "|" "CANCELED(c)")))

(setq org-todo-keyword-faces 
      '(("CANCELED" 	:foreground "#CD424C" :weight bold) 	; red
	("WAIT"		:foreground "#CEF93D" :weight bold) 	;yellow
	("DONE"		:foreground "#7BE52C" :weight bold)	; green
	("TODO"		:foreground "#5A19D6" :weight bold))) 	; blue

;;;; config ideas from https://gist.github.com/ivan/c280d6eb402b83058542ddecae4cd9f6

; Reopen the files that were open in the previous session
(desktop-save-mode 1)

; Always save desktop
(setq desktop-save t)

; Load desktop even if locked (due toe.g. unclean shutdown)
(setq desktop-load-locked-desktop t)

; Using VC, so don't create backup or autosave files
(setq make-backup-files nil)
(setq auto-save-default nil)

; Don't create lockfiles.
(setq create-lockfiles nil)

; Automatically rever files to the on-disk contents
(global-auto-revert-mode 1)

; Wrap words rather than characters
(setq-default word-wrap t)

; Open URLs in Chrome
(setq browse-url-browser-function 'browse-url-generic)
(setq browse-url-generic-program "google-chrome")

;;; fonts and colors

; Needed for the org-headline-done below to work
(setq org-fontify-done-headline t)

(custom-set-faces
  '(default		((t (:background "#000000")))) ; dark background
  '(org-hide		((t (:foreground "#000000")))) ; Make the invisible asterisk match the background
  )

;;; END

; having this at the start breaks some functionality of org. Load org 
; values first and then require it
; https://github.com/syl20bnr/spacemacs/issues/8334#issuecomment-298291766
(require 'org)
