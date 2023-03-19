(defvar *theme* 'dracula)

(defun load-custom-theme (frame)
  (select-frame frame)
  (load-theme *theme* t))

(req-package dracula-theme
  
  :config
  (if (daemonp)
      (add-hook 'after-make-frame-functions #'load-custom-theme)
    (load-theme *theme* t)))

