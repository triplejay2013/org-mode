;;;; config ideas from https://gist.github.com/ivan/c280d6eb402b83058542ddecae4cd9f6

; Reopen the files that were open in the previous session
(desktop-save-mode 1)

; Always save desktop
(setq desktop-save t)

; Load desktop even if locked (due toe.g. unclean shutdown)
(setq desktop-load-locked-desktop t)

; Using VC, so don't create backup or autosave files
(setq make-backup-files nil)
(setq auto-save-default nil)

; Don't create lockfiles.
(setq create-lockfiles nil)

; Automatically rever files to the on-disk contents
(global-auto-revert-mode 1)

; Wrap words rather than characters
(setq-default word-wrap t)

; Open URLs in Chrome
(setq browse-url-browser-function 'browse-url-generic)
(setq browse-url-generic-program "chromium-browser")

;;; fonts and colors

; Needed for the org-headline-done below to work
(setq org-fontify-done-headline t)

(custom-set-faces
  '(default		((t (:background "#000000")))) ; dark background
  '(org-hide		((t (:foreground "#000000")))) ; Make the invisible asterisk match the background
  )

;;; END
