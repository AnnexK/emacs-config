(req-package treemacs
  :ensure t
  :defer t
  :config
  (defun my/treemacs-toggle ()
	(interactive)
	(save-selected-window (treemacs)))
  :bind
  (:map global-map
		("C-c t t" . my/treemacs-toggle)
		("C-c t s" . treemacs-select-window)))
