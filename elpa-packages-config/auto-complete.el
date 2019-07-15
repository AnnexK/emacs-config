(require 'auto-complete-config)

(ac-config-default)
(global-auto-complete-mode t)
(setq-default ac-auto-start t)
(setq-default ac-auto-show-menu t)

(defvar *sources* (list 'lisp-mode
			'ac-source-semantic
			'ac-source-functions
			'ac-source-variables
			'ac-source-dictionary
			'ac-source-words-in-all-buffer
			'ac-source-files-in-current-dir))

(let (source)
  (dolist (source *sources*)
    (add-to-list 'ac-sources source)))
(add-to-list 'ac-modes 'lisp-mode)
