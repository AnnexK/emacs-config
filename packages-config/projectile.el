(require 'req-package)
(req-package projectile
  :init
  (projectile-mode +1)
  :config
  (setq projectile-project-search-path '(("~/" . 1)))
  :bind
  (:map projectile-mode-map
	("C-c p" . projectile-command-map)))
