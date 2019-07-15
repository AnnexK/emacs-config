(require 'slime)
(require 'slime-autoloads)

(slime-setup '(slime-asdf
	       slime-fancy
	       slime-indentation))
(setq-default slime-net-coding-system 'utf-8-unix)
