; Fast access to TODO states
; REF: https://orgmode.org/manual/Fast-access-to-TODO-states.html#Fast-access-to-TODO-states
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(n)" "|" "DONE(d)" "|" "CANCELED(c)") ; gen purpose
      	(sequence "INPROGRESS(p)" "HELP(h)" "|" "SUBMITTED(s)") ; school
      	(sequence "BUG(b)" "|" "FIXED(f)"))) ; work


(setq org-todo-keyword-faces 
      '(("CANCELED" 		:foreground "#CD424C" :weight bold) 	; red
	("WAITING"			:foreground "#CEF93D" :weight bold) 	; yellow
	("DONE"			:foreground "#7BE52C" :weight bold)	; green
	("FIXED"		:foreground "#7BE52C" :weight bold)	; green
	("TODO"			:foreground "#5A19D6" :weight bold) 	; blue
	("INPROGRESS"		:foreground "#7BE52C" :weight bold) 	; green
	("SUBMIITED"		:foreground "#5A19D6" :weight bold) 	; blue
	("HELP"		:foreground "#CEF93D" :weight bold))) 	; yellow


; Set up for Org-Capture: https://orgmode.org/manual/Setting-up-capture.html#Setting-up-capture
(setq org-default-notes-file "~/.emacs.d/Notebooks/notes.org")
(define-key global-map "\C-cc" 'org-capture)

; Search Capture-templates
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/.emacs.d/Notebooks/todo.org" "Tasks")
         "* TODO %?\n %i\n %a"))
      ; Add other custom templates
      )


; REF: http://newartisans.com/2007/08/using-org-mode-as-a-day-planner/
; Capture is based off of remember, these are remember configurations.
(add-hook 'remember-mode-hook 'org-remember-apply-template)

(custom-set-variables
 '(org-agenda-files (quote ("~/.emacs.d/Notebooks/todo.org")))
 '(org-default-notes-file "~/.emacs.d/Notebooks/notes.org")
 '(org-agenda-ndays 7)
 '(org-deadline-warning-days 14)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-start-on-weekday nil)
 '(org-reverse-note-order t)
 '(org-fast-tag-selection-single-key (quote expert))
 '(org-agenda-custom-commands
   (quote (("d" todo "DELEGATED" nil)
	   ("c" todo "DONE|DEFERRED|CANCELLED" nil)
	   ("w" todo "WAITING" nil)
	   ("W" agenda "" ((org-agenda-ndays 21)))
	   ("A" agenda ""
	    ((org-agenda-skip-function
	      (lambda nil
		(org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]")))
	     (org-agenda-ndays 1)
	     (org-agenda-overriding-header "Today's Priority #A tasks: ")))
	   ("u" alltodo ""
	    ((org-agenda-skip-function
	      (lambda nil
		(org-agenda-skip-entry-if (quote scheduled) (quote deadline)
					  (quote regexp) "\n]+>")))
	     (org-agenda-overriding-header "Unscheduled TODO entries: "))))))
 '(org-remember-store-without-prompt t)
 '(org-remember-templates
   (quote ((116 "* TODO %?\n  %u" "~/.emacs.d/Notebooks/todo.org" "Tasks")
	   (110 "* %u %?" "~/.emacs.d/Notebooks/notes.org" "Notes"))))
 '(remember-annotation-functions (quote (org-remember-annotation)))
 '(remember-handler-functions (quote (org-remember-handler))))
