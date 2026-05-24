;;;; init.el --- Init module
;;;; Commentary:
;;;; This is the entrypoint to this Emacs configuration.
;;;; Code:

;; Perf optimization
(setq gc-cons-threshold (* 100 1024 1024))
(setq read-process-output-max (* 8 1024 1024))

(setq-default tab-width 4)

(setq-default display-time-24hr-format t)
(setq-default display-time-default-load-average nil)
(display-time)

(setq-default column-number-mode t)

(if (functionp #'tool-bar-mode) (tool-bar-mode -1))

;; Straight bootstrap
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'req-package)

(use-package straight
  :custom
  (straight-use-package-by-default t))
;; End of Straight bootstrap

;;; Package setup
(require 'req-package)

;; Mode-line-bell
(req-package mode-line-bell
  :ensure t
  :init
  (mode-line-bell-mode))

;; Doom modeline
(req-package doom-modeline
  :init
  (doom-modeline-mode 1))

;; Exec-path-from-shell
(req-package exec-path-from-shell
  :init
  (exec-path-from-shell-initialize))

;; Ace-window
(req-package ace-window
  :bind ("M-o" . ace-window)
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?\;))
  (setq aw-dispatch-always t)
  (setq aw-dispatch-alist
		'((?x aw-delete-window "Delete window")
		  (?m aw-swap-window "Swap windows")
		  (?M aw-move-window "Move window")
		  (?c aw-copy-window "Copy window")
		  (?J aw-switch-buffer-in-window "Select buffer for current window")
		  (?u aw-switch-buffer-other-window "Select buffer for other window")
		  (?e aw-execute-command-other-window "Execute command in other window")
		  (?F aw-split-window-fair "Split window -- Fair")
		  (?v aw-split-window-vert "Split window -- Vertical")
		  (?b aw-split-window-horz "Split window -- Horizontal")
		  (?o delete-other-windows "Delete other windows")
		  (?? aw-show-dispatch-help))))

;; Company
(req-package company
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (setq company-selection-wrap-around t)
  :bind
  ("C-c c" . company-complete))

;; Tree-sitter
(req-package tree-sitter
  :require tree-sitter-langs
  :after tree-sitter-langs
  :init
  (global-tree-sitter-mode)
  :hook
  (tree-sitter-mode . tree-sitter-hl-mode))

;; Modus theme (Vivendi)
(req-package modus-themes
  :config
  (load-theme 'modus-vivendi t t))

;; Magit
(req-package magit
  :ensure t
  :require forge sqlite3 ssh-agency)
(req-package forge
  :ensure t
  :after magit)

;; Flycheck
(use-package flycheck
  :init
  (global-flycheck-mode)
  (flycheck-mode t)
  :config
  (flycheck-define-checker python-ruff
	"A Python syntax and style checker using the ruff utility.
To override the path to the ruff executable, set
`flycheck-python-ruff-executable'.
See URL `http://pypi.python.org/pypi/ruff'."
	:command ("ruff"
			  "check"
			  "--output-format"
			  "text"
              (eval (when buffer-file-name
                      (concat "--stdin-filename=" buffer-file-name)))
              "-")
	:standard-input t
	:error-filter (lambda (errors)
					(let ((errors (flycheck-sanitize-errors errors)))
                      (seq-map #'flycheck-flake8-fix-error-level errors)))
	:next-checkers ((t . python-mypy))
	:error-patterns
	((warning line-start
              (file-name) ":" line ":" (optional column ":") " "
              (id (one-or-more (any alpha)) (one-or-more digit)) " "
              (message (one-or-more not-newline))
              line-end))
	:modes python-mode)
  (setq-default flycheck-disabled-checkers
				(append flycheck-disabled-checkers
						'(python-pylint python-mypy python-pyright python-pycompile))))

;; Projectile
(defun my/projectile-activate-venv-on-project-switch ()
  "Activate virtual env located in $PROJECT_ROOT/.venv on switching to Python project."
  (let* ((project-root (projectile-project-root))
		 ; TODO: venv lookup
		 (venv-dir (concat project-root ".venv"))
		 (is-pyproject (eql (projectile-project-type) 'python-toml)))
    (if (and (file-exists-p venv-dir) is-pyproject)
		(pyvenv-activate venv-dir)
      (pyvenv-deactivate))))

(req-package projectile
  :after (pyvenv)
  :init
  (projectile-mode)
  :config
  (setq projectile-project-search-path '(("~/" . 1)))
  (setq projectile-switch-project-action #'projectile-dired)
  (setq projectile-run-use-comint-mode t)
  (projectile-register-project-type 'golang-module '("go.mod" "go.sum")
									:project-file "go.mod"
									:compile "go build"
									:test "go test"
									:test-prefix "test_"
									:run "go run")
  :bind
  (:map projectile-mode-map
		("C-c p" . projectile-command-map))
  :hook
  (projectile-after-switch-project . my/projectile-activate-venv-on-project-switch))

;; Treemacs
(req-package treemacs
  :ensure t
  :defer t
  :config
  (defun my/treemacs-toggle ()
	(interactive)
	(save-selected-window (treemacs)))
  :bind
  (:map global-map
		("C-c t t" . my/treemacs-toggle)
		("C-c t s" . treemacs-select-window)))

;; Smartparens
(req-package smartparens
  :autoload smartparens-config
  :config
  (require 'smartparens-config)
  (show-smartparens-global-mode 1)
  :init
  (smartparens-global-mode))

;; Dired
(req-package dired
  :config
  (put 'dired-find-alternate-file 'disabled nil))

;; Python
(req-package python
  :config
  (setq-default python-indent-def-block-scale 1))

;; Pyvenv
(req-package pyvenv
  :init (pyvenv-mode))

;; Golang
(req-package go-mode)

;; SLIME
(req-package slime
  :autoload slime-autoloads
  :config
  (slime-setup '(slime-asdf slime-fancy slime-indentation))
  (setq-default slime-net-config-system 'utf-8-unix)
  (setq-default inferior-lisp-program "sbcl"))

;; LSP
(req-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :commands lsp
  :config
  (lsp-configure-buffer)
  ; enable pylsp plugins
  (setq lsp-pylsp-configuration-sources ["pylsp-mypy"])
  (setq lsp-pylsp-plugins-black-enabled t)
  (setq lsp-pylsp-plugins-mypy-enabled t)
  (setq lsp-pylsp-plugins-ruff-enabled t)
  :hook ((go-mode . lsp) (python-mode . lsp)))

(req-package lsp-ui
  :after lsp-mode)

;; YAML
; TODO: find good YAML mode implementation

;; Yasnippet
(req-package yasnippet
  :config
  (yas-global-mode))

;; DAP
; TODO: try dape-mode
(req-package dap-mode
  :require (dap-python)
  :hook (python-mode . dap-mode)
  :config
  (dap-auto-configure-mode)
  (setq dap-python-debugger 'debugpy))

(req-package-finish)
;;; Package setup ends here

;; Startup buffer
(defconst *startup-buffer-image-path* (file-name-concat user-emacs-directory "assets" "startup-image.jpg"))
(defun my/startup-buffer ()
  (let* ((buffer (get-buffer-create (format "*Hello %s*" (user-real-login-name))))
		 (image (create-image *startup-buffer-image-path*))
		 (image-width (car (image-size image t)))
		 (window-width (window-pixel-width))
		 (image-height (cdr (image-size image t)))
		 (window-height (window-pixel-height))
		 (image-width-offset (/ (- window-width image-width) 2))
		 (image-height-offset (/ (- window-height image-height) 2)))
	(set-buffer buffer)
	(local-set-key (kbd "q") 'quit-window)
	(insert-image image)
	buffer))

(setq initial-buffer-choice #'my/startup-buffer)

;; Custom file
(defun set-and-load-custom-file (filename)
  "Set and load a custom file by FILENAME.
If FILENAME does not exist, emit a message."
  (cond ((file-exists-p filename) (setq custom-file filename) (load custom-file))
		(t (message "Custom file does not exist: %s" filename))))

(set-and-load-custom-file (file-name-concat user-emacs-directory "custom.el"))

;;; init.el ends here
