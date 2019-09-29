(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(defvar required-packages (list 'slime
				'smartparens
			        'company			     
				'elpy
			        'cyberpunk-theme
				'dracula-theme
				'markdown-mode
				'exec-path-from-shell
				'magit))

(defun packages-installed-p (package-list)
  (loop for package in package-list
	unless (package-installed-p package)
	do (return nil)
	finally (return t)))

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
