; Org Mode set up (as per manual instructions)
; https://orgmode.org/manual/Installation.html#Installation

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

; add certain files to config
(add-to-list 'load-path "~/.src/org-mode/lisp")
(add-to-list 'load-path "/usr/bin/mu/")

; adds contributed libraries not included in Emacs
(add-to-list 'load-path "~/.src/org-mode/contrib/lisp" t)

; Suggestd org commands
; https://orgmode.org/manual/Activation.html#Activation
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)
(global-set-key "\C-cgt" 'evil-next-buffer)
(global-set-key "\C-cgT" 'evil-prev-buffer)

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
(load-user-file "sage.el")
(load-user-file "python.el")
; requires installation: sudo apt install emacs-goodies-el
; (load-user-file "./themes/themes.el") ; unstable, needs more config

;(load-user-file "powerline.el")
;;; END

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
; don't use exports with dir as per manual
; REF: https://orgmode.org/manual/dir.html#dir
(define-key org-mode-map "\C-cs"
	    (lambda()(interactive)(insert 
"#+NAME: 
#+HEADER: :dir ./src/ :file example.txt
#+HEADER: :tangle ./src/
#+BEGIN_SRC C\n#+END_SRC")))

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
	  ; TODO Add org files to TRACK here
	  '( 
    "todo.org" ; holds most items
    "notes.org"; used by org-mode in some cases
    ; BSU class files all found in School/TermYear/File.org
    "School/Fall2018/Fall2018.org"
    "School/Spring2019/Spring2019.org"
    ; Dir/FileName.org relative location to Notebooks
	  )))

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
;(setq browse-url-browser-function 'browse-url-chromium)
; REF: https://lists.gnu.org/archive/html/emacs-orgmode/2010-07/msg00879.html
;(setq browse-url-generic-program "chromium-browser")
; REF: https://stackoverflow.com/a/4506458
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium-browser")

; LaTeX setup
; Sets up embedded latex fragments
; REF: https://orgmode.org/worg/org-tutorials/org-latex-preview.html
(setq org-latex-create-formula-image-program 'dvipng)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-custom-commands
   (quote
	(("d" todo "DELEGATED" nil)
	 ("c" todo "DONE|DEFERRED|CANCELLED" nil)
	 ("w" todo "WAITING" nil)
	 ("W" agenda ""
	  ((org-agenda-ndays 21)))
	 ("A" agenda ""
	  ((org-agenda-skip-function
		(lambda nil
		  (org-agenda-skip-entry-if
		   (quote notregexp)
		   "\\=.*\\[#A\\]")))
	   (org-agenda-ndays 1)
	   (org-agenda-overriding-header "Today's Priority #A tasks: ")))
	 ("u" alltodo ""
	  ((org-agenda-skip-function
		(lambda nil
		  (org-agenda-skip-entry-if
		   (quote scheduled)
		   (quote deadline)
		   (quote regexp)
		   "
]+>")))
	   (org-agenda-overriding-header "Unscheduled TODO entries: "))))))
 '(org-agenda-files (quote ("~/.emacs.d/Notebooks/todo.org")))
 '(org-agenda-ndays 7)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-start-on-weekday nil)
 '(org-deadline-warning-days 14)
 '(org-default-notes-file "~/.emacs.d/Notebooks/notes.org")
 '(org-fast-tag-selection-single-key (quote expert))
 '(org-remember-store-without-prompt t)
 '(org-remember-templates
   (quote
	((116 "* TODO %?
  %u" "~/.emacs.d/Notebooks/todo.org" "Tasks")
	 (110 "* %u %?" "~/.emacs.d/Notebooks/notes.org" "Notes"))))
 '(org-reverse-note-order t)
 '(package-selected-packages (quote (ob-sagemath sage-shell-mode auctex)))
 '(remember-annotation-functions (quote (org-remember-annotation)))
 '(remember-handler-functions (quote (org-remember-handler))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background "#000000"))))
 '(org-hide ((t (:foreground "#000000")))))

;; Melpa config
; REF: http://melpa.org/#/getting-started
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

; Disable MenuBar
; REF: https://www.emacswiki.org/emacs/MenuBar
(menu-bar-mode -1)

; Auto-kill active process
; REF: https://stackoverflow.com/a/2708042
(add-hook 'comint-exec-hook 
      (lambda () (set-process-query-on-exit-flag (get-buffer-process (current-buffer)) nil)))

; Hides emphasis markers (*,/,~, etc) used for formatting text
; REF: https://www.reddit.com/r/emacs/comments/6pxh92/how_to_change_font_colorcharacteristics_in_org/
(setq org-hide-emphasis-markers t)

; mu4e set up
; sudo apt install mu4e
; REF: http://www.djcbsoftware.nl/code/mu/


; OFFLINEIMAP
; REF: http://www.offlineimap.org/
; See git repo: https://github.com/OfflineIMAP/offlineimap *Install under .src*

; unscheduled TODO
; REF: https://emacs.stackexchange.com/a/16561
(setq org-agenda-custom-commands
      '(("c" . "My Custom Agendas")
        ("cu" "Unscheduled TODO"
         ((todo ""
                ((org-agenda-overriding-header "\nUnscheduled TODO")
                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled)))))
         nil
         nil)))

; Fill Paragraph
; REF: https://www.emacswiki.org/emacs/FillParagraph
(setq-default fill-column 75)
; Autofill
; REF: https://www.emacswiki.org/emacs/AutoFillMode
; Asks when buffer is opened, to turn on auto-fill mode
;(add-hook 'text-mode-hook
;          (lambda ()
;            (when (y-or-n-p "Auto Fill mode? ")
;              (turn-on-auto-fill))))
; Toggle on/off auto fill mode
(global-set-key (kbd "C-c q") 'auto-fill-mode)
; By default have auto fill turned on
(add-hook 'text-mode-hook 'turn-on-auto-fill)
