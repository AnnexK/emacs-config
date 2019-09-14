(require 'cl)
(setq-default inferior-lisp-program "sbcl")

(display-time)
(if (> emacs-major-version 20)
    (tool-bar-mode -1))

(load "~/.emacs.d/misc/load-directory.el")

(defvar *theme* 'dracula)

(load "~/.emacs.d/elpa.el")
(load-directory "~/.emacs.d/languages/")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (dracula-theme smartparens slime markdown-mode elpy cyberpunk-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
