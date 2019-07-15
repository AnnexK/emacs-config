(defun load-custom-theme (frame)
  (select-frame frame)
  (load-theme *theme* t))

(if (daemonp)
    (add-hook 'after-make-frame-functions #'load-custom-theme)
  (load-theme *theme* t))
