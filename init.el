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
