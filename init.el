(load "~/.emacs.d/system.el")
(setq-default tab-width 4)
(setq display-time-24hr-format t)
(setq display-time-default-load-average nil)
(display-time)

(add-to-list 'load-path "~/.emacs.d/misc")
(load-library "load-directory")
(tool-bar-mode -1)
(require 'load-directory)

(load "~/.emacs.d/straight-bootstrap.el")
(load "~/.emacs.d/theme-loader.el")

(load-directory "~/.emacs.d/packages-config")

(req-package-finish)

(load-directory "~/.emacs.d/languages/")

(let ((locals-directory "~/.emacs.d/local-settings"))
  (if (file-directory-p locals-directory)
      (load-directory locals-directory)))

(put 'dired-find-alternate-file 'disabled nil)

(setq column-number-mode t)

(load "~/.emacs.d/scons.el")
