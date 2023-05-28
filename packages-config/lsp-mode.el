(require 'req-package)

(req-package lsp-mode
  :init (setq lsp-keymap-prefix "C-c l")
  :commands lsp)

