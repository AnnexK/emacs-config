(require 'req-package)

(req-package lsp-mode
  :init (setq lsp-keymap-prefix "C-c l")
  :hook ((python-mode . lsp))
  :commands lsp)

