;;; custom-file-loader.el --- Facility to load custom files
;;; Commentary:
;;; This module contains a function to facilitate custom file loading.
;;; Code:

(defun set-and-load-custom-file (filename)
  "Set and load a custom file by FILENAME.
If FILENAME does not exist, emit a message."
  (cond ((file-exists-p filename) (setq custom-file filename) (load custom-file))
		(t (message "Custom file does not exist: %s" filename))))

(provide 'custom-file-loader)
;;; custom-file-loader.el ends here
