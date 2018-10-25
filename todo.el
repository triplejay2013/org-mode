; Fast access to TODO states
; REF: https://orgmode.org/manual/Fast-access-to-TODO-states.html#Fast-access-to-TODO-states
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(n)" "|" "DONE(d)" "|" "CANCELED(c)") ; gen purpose
      	(sequence "INPROGRESS(p)" "HELP(h)" "|" "SUBMITTED(s)"))) ; school


(setq org-todo-keyword-faces 
      '(("CANCELED" 		:foreground "#CD424C" :weight bold) 	; red
	("WAIT"			:foreground "#CEF93D" :weight bold) 	; yellow
	("DONE"			:foreground "#7BE52C" :weight bold)	; green
	("FIXED"		:foreground "#7BE52C" :weight bold)	; green
	("TODO"			:foreground "#7BE52C" :weight bold) 	; green
	("INPROGRESS"		:foreground "#7BE52C" :weight bold) 	; green
	("SUBMIITED"		:foreground "#5A19D6" :weight bold) 	; blue
	("HELP"		:foreground "#CEF93D" :weight bold))) 	; yellow

