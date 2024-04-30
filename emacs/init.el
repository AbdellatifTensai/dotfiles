(setq gc-cons-threshold (* 8 1000 1000))

(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(global-display-line-numbers-mode 1)
(global-visual-line-mode -1)

;;----------------------------------------------

(use-package evil :init (evil-mode 1))
(use-package vertico :init (vertico-mode 1))
(use-package marginalia :init (marginalia-mode 1))
(use-package orderless :config (setq completion-styles '(orderless basic)))
(use-package consult :bind (("C-x b" . consult-buffer)))
;;----------------------------------------------

(setq-default line-spacing 5)
(setq-default scroll-step 1)
(setq-default scroll-conservatively 10000)
;;----------------------------------------------

(define-key evil-motion-state-map (kbd "C-y") 'nil)
(define-key evil-motion-state-map (kbd "C-e") 'nil)
(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "<f6>") 'recompile)

(global-set-key (kbd "C-e") 'pixel-scroll-up)
(global-set-key (kbd "C-y") 'pixel-scroll-down)
;;----------------------------------------------

(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files")))
;;----------------------------------------------

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/") ("org" . "https://orgmode.org/elpa/") ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))
(unless (package-installed-p 'use-package) (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)
;;----------------------------------------------

(load-theme 'catppuccin t)

(setq-default mode-line-format '("%e %b"))

(set-face-attribute 'default nil :font "JetBrainsMonoNerdFont" :height 140 :weight 'light)
(set-face-attribute 'font-lock-keyword-face nil :slant 'italic)
(set-face-attribute 'font-lock-comment-face nil :slant 'italic)
;;----------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("80214de566132bf2c844b9dee3ec0599f65c5a1f2d6ff21a2c8309e6e70f9242" "2628939b8881388a9251b1bb71bc9dd7c6cffd5252104f9ef236ddfd8dbbf74a" "d92c1c36a5181cf629749bf6feee1886cf6bce248ab075c9d1b1f6096fea9539" "2bcd3850ef2d18a4c9208fe3e2a78c95fb82f48c26661c86a51ea39152f3577e" default))
 '(package-selected-packages
   '(catppuccin-theme modus-themes consult orderless marginalia vertico evil))
 '(warning-suppress-types '((use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
