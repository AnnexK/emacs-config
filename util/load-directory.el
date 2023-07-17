;;; load-directory.el --- Load all elisp files in directory facility
;;; Commentary:
;;; This module contains a function to load all elisp files in a directory.
;;; Code:

(defun load-directory (dir)
  "Load all .el files in DIR."
  (let ((load-it (lambda (f)
		   (load-file (concat (file-name-as-directory dir) f)))))
    (mapc load-it (directory-files dir nil "\\.el$"))))

(provide 'load-directory)
;;; load-directory.el ends here
