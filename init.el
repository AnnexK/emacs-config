(load "~/.emacs.d/system.el")
(display-time)
(if (> emacs-major-version 20)
    (tool-bar-mode -1))

(if (> emacs-major-version 22)
    (display-battery-mode 1))

(add-to-list 'load-path "~/.emacs.d/misc")
(load-library "load-directory")
(require 'load-directory)

(load "~/.emacs.d/straight-bootstrap.el")

(load-directory "~/.emacs.d/packages-config")
(load "~/.emacs.d/theme.el")

(req-package-finish)

(load-directory "~/.emacs.d/languages/")
(put 'dired-find-alternate-file 'disabled nil)

(setq column-number-mode t)
(add-to-list 'default-frame-alist
	     '(font . "Source Code Pro-14"))

(load "~/.emacs.d/scons.el")

