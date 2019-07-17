(elpy-enable)

(defvar python-interpreter-cmd
      (if (eq system-type 'windows-nt)
	  "py"
	"python3"))

(setq-default python-shell-interpreter python-interpreter-cmd
	      python-shell-interpreter-args "-i")

(setq elpy-rpc-python-command python-interpreter-cmd)
