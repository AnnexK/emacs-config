(req-package smartparens
  :autoload smartparens-config
  :config
  (show-smartparens-global-mode 1)
  (sp-local-pair 'python-mode "\"\"\"" "\"\"\"")
  :init
  (smartparens-global-mode))
