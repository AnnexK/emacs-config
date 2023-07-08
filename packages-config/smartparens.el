(req-package smartparens
  :autoload smartparens-config
  :config
  (require 'smartparens-config)
  (show-smartparens-global-mode 1)
  :init
  (smartparens-global-mode))
