(require 'req-package)

(req-package tree-sitter
  :require tree-sitter-langs
  :after tree-sitter-langs
  :init
  (global-tree-sitter-mode)
  :hook
  (tree-sitter-mode . tree-sitter-hl-mode))
