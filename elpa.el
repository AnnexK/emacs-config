(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(defvar required-packages (list 'slime
				'smartparens
				'auto-complete
				'elpy
			        'cyberpunk-theme))

(defun packages-installed-p ()
  (loop for package in required-packages
	unless (package-installed-p package)
	do (return nil)
	finally (return t)))

(unless (packages-installed-p)
  (package-refresh-contents)
  (dolist (package required-packages)
    (unless (package-installed-p package)
      (package-install package))))

(require 'load-directory)
(when (packages-installed-p)
  (load-directory "~/.emacs.d/elpa-packages-config")
  (load "~/.emacs.d/theme.el"))
