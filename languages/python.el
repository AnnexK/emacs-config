;;; python --- Configuration file for Python source code

;;; Commentary:
;;; LSP config for Python

;;; Code:
(require 'projectile)
(require 'pyvenv)
(require 'flycheck)

(setq-default flycheck-disabled-checkers
	      (cons 'python-pycompile (default-value flycheck-disabled-checkers)))

(defun projectile-activate-venv-on-project-switch ()
  (let* ((project-root (projectile-project-root))
	 (venv-dir (concat project-root ".venv"))
	 (is-pyproject (eql (projectile-project-type) 'python-toml)))
    (message "venv dir=%s root=%s" venv-dir project-root)
    (message "venv dir exists=%s ## is-toml-project=%s" (file-exists-p venv-dir) is-pyproject)
    (if (and (file-exists-p venv-dir) is-pyproject)
	(pyvenv-activate venv-dir)
      (pyvenv-deactivate))))

(add-hook 'projectile-after-switch-project-hook #'projectile-activate-venv-on-project-switch)

(provide 'python)
;;; python.el ends here
