(load "~/.emacs.d/system.el")
(setq-default tab-width 4)
(display-time)
(if (> emacs-major-version 20)
    (tool-bar-mode -1))

(if (> emacs-major-version 22)
    (display-battery-mode 1))

(add-to-list 'load-path "~/.emacs.d/misc")
(load-library "load-directory")
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
