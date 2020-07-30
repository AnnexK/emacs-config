(setq-default compile-command "scons ")
(add-to-list 'auto-mode-alist
	     '("SConstruct" . python-mode))
(add-to-list 'auto-mode-alist
	     '("SConscript" . python-mode))
