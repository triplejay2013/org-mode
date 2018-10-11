; Org Mode set up (as per manual instructions)
; https://orgmode.org/manual/Installation.html#Installation

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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

;; Quick insert of example blocks
(define-key org-mode-map "\C-ce"
	    (lambda()(interactive)(insert "#+BEGIN_EXAMPLE \n#+END_EXAMPLE")))

;; Define Babel languages
(org-babel-do-load-languages
  'org-babel-load-languages
  '((python . t)
    (C . t)
    (sh . t)
    (latex . t)
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

; Exporting Config
; REF: https://orgmode.org/manual/Project-alist.html
; REF: https://stackoverflow.com/a/9560430
(setq org-publish-project-alist
      '(("html"
	 :base-directory "~/.emacs.d/Notebooks/"
	 :base-extension "org"
	 :publishing-directory "~/.emacs.d/Notebooks/exports"
	 :publishing-function org-publish-org-to-html)
	("pdf"
	 :base-directory "~/.emacs.d/Notebooks/"
	 :base-extension "org"
	 :publishing-directory "~/.emacs.d/Notebooks/exports/"
	 :publishing-function org-publish-org-to-pdf)
	("all" :components ("html" "pdf"))))

; Tell org mode to use chrome
; REF: http://ergoemacs.org/emacs/emacs_set_default_browser.html
(setq browse-url-browser-function 'browse-url-chromium)
; REF: https://lists.gnu.org/archive/html/emacs-orgmode/2010-07/msg00879.html
(setq browse-url-generic-program "chromium-browser")

; LaTeX setup
; Sets up embedded latex fragments
; REF: https://orgmode.org/worg/org-tutorials/org-latex-preview.html
(setq org-latex-create-formula-image-program 'dvipng)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   (quote
	("~/.emacs.d/Notebooks/LA.org" "~/.emacs.d/Notebooks/BSU.org" "~/.emacs.d/Notebooks/Personal.org" "~/.emacs.d/Notebooks/srcBlocks.org" "~/.emacs.d/Notebooks/Church.org")))
 '(package-selected-packages (quote (auctex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background "#000000"))))
 '(org-hide ((t (:foreground "#000000")))))
