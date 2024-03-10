(require 'req-package)

(req-package lsp-mode
  :init (setq lsp-keymap-prefix "C-c l")
  :commands lsp
  :config (lsp-configure-buffer)
  :hook ((go-mode . lsp) (python-mode . lsp)))

