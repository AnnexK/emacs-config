(add-hook 'after-init-hook 'global-company-mode)

(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)

(setq company-selection-wrap-around t)

(company-tng-configure-default)
