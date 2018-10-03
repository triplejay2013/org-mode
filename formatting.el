; Allows use of tab as a space character
; REF: http://ergoemacs.org/emacs/emacs_tabs_space_indentation_setup.html
;; make tab key always call a indent command
;(setq-default tab-always-indent t)
;; make tab key call indent command or insert tab character,
;; depending on cursor position
(setq-default tab-always-indent nil)
;; make tab key do indent first then completion
;(setq-default tab-always-indent 'complete)

;; set default tab char's display width to 4 spaces (default is 8)
(setq-default tab-width 4)

;; set current bufer's tab char's display width to 4 spaces
(setq tab-width 4)

; Makes a prettier indentation format showing less stars
(setq org-hide-leading-stars t)

; use font-lock globally in emacs
; (add-hook 'org-mode-hook 'turn-on-font-lock)

; avoid invisible edits
; (setq-default org-catch-invisibile-edits 'smart)

;; Set maximum indentation for description lists
; (setq org-list-description-max-indent 5)

;; prevent demoting heading also shifting text inside sections
; (setq org-adapt-indentation nil)
