;;; python --- Configuration file for Python source code

;;; Commentary:
;;; LSP config for Python

;;; Code:
(require 'projectile)
(require 'pyvenv)
(require 'flycheck)

(flycheck-define-checker python-ruff
  "A Python syntax and style checker using the ruff utility.
To override the path to the ruff executable, set
`flycheck-python-ruff-executable'.
See URL `http://pypi.python.org/pypi/ruff'."
  
  :command ("ruff"
			"check"
			"--output-format"
			"text"
            (eval (when buffer-file-name
                    (concat "--stdin-filename=" buffer-file-name)))
            "-")
  :standard-input t
  :error-filter (lambda (errors)
                  (let ((errors (flycheck-sanitize-errors errors)))
                    (seq-map #'flycheck-flake8-fix-error-level errors)))
  :next-checkers ((warning . python-mypy))
  :error-patterns
  ((warning line-start
            (file-name) ":" line ":" (optional column ":") " "
            (id (one-or-more (any alpha)) (one-or-more digit)) " "
            (message (one-or-more not-newline))
            line-end))
  :modes python-mode)

(add-to-list 'flycheck-checkers 'python-ruff)

(setq-default flycheck-disabled-checkers
	      (cons 'python-pycompile (default-value flycheck-disabled-checkers)))

(defun projectile-activate-venv-on-project-switch ()
  (let* ((project-root (projectile-project-root))
	 (venv-dir (concat project-root ".venv"))
	 (is-pyproject (eql (projectile-project-type) 'python-toml)))
    (if (and (file-exists-p venv-dir) is-pyproject)
	(pyvenv-activate venv-dir)
      (pyvenv-deactivate))))

(add-hook 'projectile-after-switch-project-hook #'projectile-activate-venv-on-project-switch)

(setq-default python-indent-def-block-scale 1)

(provide 'flycheck-ruff)
(provide 'python)
;;; python.el ends here
