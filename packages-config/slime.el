(req-package slime
  :autoload slime-autoloads
  :config
  ((slime-setup '(slime-asdf slime-fancy slime-indentation))
   (setq-default slime-net-config-system 'utf-8-unix)))
