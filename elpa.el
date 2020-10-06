(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(setq package-enable-at-startup nil)
(package-initialize)

(defvar required-packages (list 'slime
				'smartparens
			        'company			     
				'elpy
			        'cyberpunk-theme
				'dracula-theme
				'markdown-mode
				'exec-path-from-shell
				'magit
				'forge
				'django-mode
				'mode-line-bell
				'color-theme-modern))

(defun packages-installed-p (package-list)
  (let ((& (lambda (x y) (and x y))))
    (seq-reduce & (mapcar #'package-installed-p package-list) t)))

(defun do-install-packages (package-list)
  (unless (packages-installed-p package-list)
    (package-refresh-contents)
    (dolist (package package-list)
      (unless (package-installed-p package)
	(package-install package)))))

(do-install-packages required-packages)

(require 'load-directory)
(when (packages-installed-p required-packages)
  (load-directory "~/.emacs.d/elpa-packages-config")
  (load "~/.emacs.d/theme.el"))
