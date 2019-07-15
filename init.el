(require 'cl)
(setq-default inferior-lisp-program "sbcl")

(display-time)
(if (> emacs-major-version 20)
    (tool-bar-mode -1))

(load "~/.emacs.d/elpa.el")
