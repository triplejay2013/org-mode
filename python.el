; Forces use of python3 in code evaluation
(setq org-babel-python-command "python3")

; Fixes some compilation issues for python
; REF: https://github.com/syl20bnr/spacemacs/issues/8797#issuecomment-297254190
(setq python-shell-completion-native-enable nil)
