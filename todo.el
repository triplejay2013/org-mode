; Fast access to TODO states
; REF: https://orgmode.org/manual/Fast-access-to-TODO-states.html#Fast-access-to-TODO-states
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)" "|" "CANCELED(c)") ; gen purpose
	(sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)") ; coding/work
      	(sequence "INPROGRESS(p)" "NEEDHELP(h)" "|" "SUBMITTED(s)"))) ; school


(setq org-todo-keyword-faces 
      '(("CANCELED" 		:foreground "#CD424C" :weight bold) 	; red
	("WAIT"			:foreground "#CEF93D" :weight bold) 	; yellow
	("DONE"			:foreground "#7BE52C" :weight bold)	; green
	("NEXT"			:foreground "#CEF93D" :weight bold)	; yellow
	("TODO"			:foreground "#5A19D6" :weight bold) 	; blue
	("REPORT"		:foreground "#CD424C" :weight bold) 	; red
	("BUG"			:foreground "#CD424C" :weight bold) 	; red
	("KNOWNCAUSE"		:foreground "#7BE52C" :weight bold) 	; green
	("FIXED"		:foreground "#5A19D6" :weight bold) 	; blue
	("INPROGRESS"		:foreground "#7BE52C" :weight bold) 	; green
	("SUBMIITED"		:foreground "#5A19D6" :weight bold) 	; blue
	("NEEDHELP"		:foreground "#CEF93D" :weight bold))) 	; yellow

