; REF: https://orgmode.org/worg/org-color-themes.html
(require 'color-theme)
(setq color-theme-is-global t)
(color-theme-initialize)

(load "color-theme-colorful-obsolescence")
(load "color-theme-active")
(load "color-theme-zenburn")
(load "color-theme-tangotango")
(load "color-theme-zenash")

(setq my-color-themes (list
  'color-theme-colorful-obsolescence 
  'color-theme-active
  'color-theme-zenburn
  'color-theme-tangotango
  'color-theme-zenash
))

(defun my-theme-set-default () ; Set the first row
      (interactive)
      (setq theme-current my-color-themes)
      (funcall (car theme-current)))
     
    (defun my-describe-theme () ; Show the current theme
      (interactive)
      (message "%s" (car theme-current)))
     
   ; Set the next theme (fixed by Chris Webber - tanks)
    (defun my-theme-cycle ()            
      (interactive)
      (setq theme-current (cdr theme-current))
      (if (null theme-current)
      (setq theme-current my-color-themes))
      (funcall (car theme-current))
      (message "%S" (car theme-current)))
    
    (setq theme-current my-color-themes)
    (setq color-theme-is-global nil) ; Initialization
    (my-theme-set-default)
    (global-set-key [f4] 'my-theme-cycle)
