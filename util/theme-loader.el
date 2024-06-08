;;; theme-loader -- Theme loader utility -*- lexical-binding: t -*-
;;; Commentary:
;;; This package provides apply-theme function
;;; that either loads theme or appends a hook that applies theme to frame,
;;; depending on whether Emacs is run in daemon mode or not.

;;; Code:

(defun apply-theme (theme)
  "Apply theme.
If Emacs is run in daemon mode, add a hook that applies THEME to client frame.
If Emacs is run in server mode, just apply THEME."
  (if (member theme custom-known-themes)
      (if (daemonp)
		  (add-hook 'after-make-frame-functions (make-theme-loader theme))
		(enable-theme theme))
    (message "Theme %s is not available; skipping apply-theme" theme)))

(defun make-theme-loader (theme)
  (let ((my-theme theme))
    (lambda (frame) (select-frame frame) (load-theme my-theme t))))


(provide 'theme-loader)
;;; theme-loader.el ends here
