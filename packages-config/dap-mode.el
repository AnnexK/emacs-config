(require 'req-package)

(req-package dap-mode
  :after lsp-mode
  :hook (python-mode . dap-mode)
  :config
  (dap-auto-configure-mode)
  (require 'dap-python)
  (setq dap-python-debugger 'debugpy))
