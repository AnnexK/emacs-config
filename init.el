(require 'cl)
(setq-default inferior-lisp-program "sbcl")

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(display-time)
(if (> emacs-major-version 20)
    (tool-bar-mode -1))

(add-to-list 'load-path "~/.emacs.d/misc")
(load-library "load-directory")
(require 'load-directory)

(defvar *theme* 'dracula)

(load "~/.emacs.d/elpa.el")

(exec-path-from-shell-initialize)

(load-directory "~/.emacs.d/languages/")
