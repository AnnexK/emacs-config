(require 'req-package)


(req-package ace-window
  :bind ("M-o" . ace-window)
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?\;))
  (setq aw-dispatch-always t)
  (setq aw-dispatch-alist
		'((?x aw-delete-window "Delete window")
		  (?m aw-swap-window "Swap windows")
		  (?M aw-move-window "Move window")
		  (?c aw-copy-window "Copy window")
		  (?J aw-switch-buffer-in-window "Select buffer for current window")
		  (?u aw-switch-buffer-other-window "Select buffer for other window")
		  (?e aw-execute-command-other-window "Execute command in other window")
		  (?F aw-split-window-fair "Split window -- Fair")
		  (?v aw-split-window-vert "Split window -- Vertical")
		  (?b aw-split-window-horz "Split window -- Horizontal")
		  (?o delete-other-windows "Delete other windows")
		  (?? aw-show-dispatch-help))))

