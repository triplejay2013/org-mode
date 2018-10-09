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

; Load other .el files
; https://stackoverflow.com/a/2079146
(defconst user-init-dir
	  (cond ((boundp 'user-emacs-directory)
		 user-emacs-directory)
		((boundp 'user-init-directory)
		 user-init-directory)
		(t "~/.emacs.d/")))

(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

;(load-user-file "example.el")
(load-user-file "formatting.el")
(load-user-file "gist.el")
(load-user-file "todo.el")
(load-user-file "python.el")
;(load-user-file "powerline.el")
;;; END

;; hot key issue fixes (FOR WINDOWS)
;(w32-register-hot-key t)

; Evil Mode setup
; this can be found at:
; 	https://github.com/emacs-evil/evil
(add-to-list 'load-path "~/.emacs.d/evil")
(setq evil-want-C-i-jump nil); this fixes tab issues using EVIL with org mode
(require 'evil)
(evil-mode 1)

; Powerline Setup
;; I am unhappy with this setup....want to find integration found in
;; example at (TODO): https://www.emacswiki.org/emacs/PowerLine
; REF: https://github.com/Dewdrops/powerline
(add-to-list 'load-path "~/.emacs.d/powerline")
(require 'powerline)
(powerline-center-evil-theme)

; having this at the start breaks some functionality of org. Load org 
; values first and then require it
; https://github.com/syl20bnr/spacemacs/issues/8334#issuecomment-298291766
(require 'org)

;; Quick insert src blocks
;; must be defined after (require 'org)
(define-key org-mode-map "\C-cs"
	    (lambda()(interactive)(insert "#+BEGIN_SRC C\n#+END_SRC")))

;; Define Babel languages
(org-babel-do-load-languages
  'org-babel-load-languages
  '((python . t)
    (C . t)
    (sh . t)
    (shell . t)
    ; (asm-mode . t) ; Assembly not supported?
    (java . t)))

;; REF: http://cachestocaches.com/2018/6/org-literate-programming/
; Syntax highlight in #+BEGIN_SRC blocks
(setq org-src-fonitify-natively t)
; Don't prompt before running code in org
(setq org-confirm-babel-evaluate nil)

; REF: https://stackoverflow.com/questions/18011098/emacs-org-mode-todo-list-missing-items
; Tell org mode where to find agenda files
; This fixes global TODO's not knowing where to find TODO's
(defvar dir-where-you-store-org-files "~/.emacs.d/Notebooks/")
(setq 
  org-agenda-files 
  (mapcar (lambda (x) (concat dir-where-you-store-org-files x))
	  ; Add org files to TRACK here
	  '("BSU.org" 
	  "Personal.org" 
	  "LA.org"
	  "srcBlocks.org"
	  "Church.org")))

(define-key org-mode-map "\C-ce"
	    (lambda()(interactive)(insert "#+BEGIN_EXAMPLE \n#+END_EXAMPLE")))
