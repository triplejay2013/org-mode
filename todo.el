; Fast access to TODO states
; REF: https://orgmode.org/manual/Fast-access-to-TODO-states.html#Fast-access-to-TODO-states
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAITING(w@)" "STARTED(s@)" "|" "DONE(d!)" "|" "CANCELED(c@)") ; gen purpose
      	(sequence "INPROGRESS(i)" "HELP(h@)" "|" "SUBMITTED(S!)") ; school
      	(sequence "BUG(b@)" "|" "FIXED(f!)"))) ; work
; Tracking TODO state Changes: https://www.gnu.org/software/emacs/manual/html_node/org/Tracking-TODO-state-changes.html
; Essential, @ denotes note and timestamp '!' denotes timestamp


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
; REF: https://orgmode.org/manual/Capture-templates.html
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/.emacs.d/Notebooks/todo.org" "Tasks")
         "* TODO %?\n%i\n %a\n" :clock-in t :clock-resume t)
        ("s" "School" entry (file+headline "~/.emacs.d/Notebooks/todo.org" "School")
           "* TODO %?\n %i\n %a")
        ("p" "Personal" entry (file+headline "~/.emacs.d/Notebooks/todo.org" "Personal")
          "* TODO %?\n %i\n %a")
        ("n" "Note" entry (file+headline "~/.emacs.d/Notebooks/notes.org" "Note")
           "%?\n")
        ("c" "Church" entry (file+headline "~/.emacs.d/Notebooks/todo.org" "Church")
         "* TODO %?\n%i\n%a")
        ("f" "Fincance" entry (file+headline "~/.emacs.d/Notebooks/todo.org" "Finances")
         "* TODO %?\n%i\n%a")
        ("m" "Misc" entry (file+headline "~/.emacs.d/Notebooks/todo.org" "Miscellaneous")
         "* TODO %?\n%i\n%a")
        ("w" "Work" entry (file+headline "~/.emacs.d/Notebooks/todo.org" "Work")
         "* TODO %?\n%i\n%a")
        ; Following Inspired by: http://cachestocaches.com/2016/9/my-workflow-org-agenda/
        ; Journal - Inspired by the "Journal" template from Bernt Hansen's guide, I use this template for one-off and unscheduled personal tasks. This includes my daily lunch break or whenever I go get coffee with a friend. Unlike the other templates, this created heading is placed within the diary.org file, and beneath headings corresponding to the year-month-day. I typically just leave this open while I'm away from my desk, and it's rare that I look at these directly after they're created.
        ("j" "Journal" entry (file+datetree "~/.emacs.d/Notebooks/journal.org")
         "* %?\n%U\n" :clock-in t :clock-resume t)
        ; Idea - I often have random thoughts throughout the day that have nothing to do with what I'm currently working on and likely aren't time sensitive. Whenever I have one of these ideas (whether it be inspiration for a blog post, or an idea for my work), I use this capture template.
        ("i" "Idea" entry (file+headline "~/.emacs.d/Notebooks/todo.org" "Ideas")
         "* %? :IDEA: \n%t" :clock-in t :clock-resume t)
        ; Next Task - Whenever I have something I quickly need to get done, including a one-off errand or responding to an email, I use this. It creates a heading with the NEXT keyword and (if that weren't enough) a deadline for the end of the day. I try to ensure that all of these are done before I go to bed if possible.
        ("n" "Next Task" entry (file+headline "~/.emacs.d/Notebooks/todo.org" "Next")
         "** NEXT %? \nDEADLINE: %t")
        ; Add other custom templates
        ))

; Clocking REF: http://cachestocaches.com/2016/9/my-workflow-org-agenda/
;; Set default column view headings: Task Total-Time Time-Stamp
(setq org-columns-default-format "%50ITEM(Task) %10CLOCKSUM %16TIMESTAMP_IA")

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
