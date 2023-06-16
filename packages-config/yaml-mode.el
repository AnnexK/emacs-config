(require 'req-package)

(req-package yaml-mode
  :hook ((yaml-mode . (lambda ()
			(define-key yaml-mode-map "\C-m" 'newline-and-indent)))))
