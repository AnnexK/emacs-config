(require 'req-package)
(req-package elpy
  :require flycheck
  :ensure t
  :init
  (elpy-enable)
  :config
  ; Prefer tools from project virtualenv
  (setq elpy-rpc-virtualenv-path 'current)
  ; Disable flymake integration (I use Flycheck)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules)))
