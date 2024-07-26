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
(use-package beacon :init (beacon-mode 1) :config (setq beacon-blink-delay 0.1))
(use-package expand-region :init (global-set-key (kbd "M-f") 'er/expand-region))
;(use-package dumb-jump :init (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))
;;----------------------------------------------

(setq-default line-spacing 5)
(setq-default scroll-step 1)
(setq-default scroll-conservatively 10000)
(pixel-scroll-precision-mode 1)
;;----------------------------------------------

(defadvice compile (before save-before-compile activate) (save-buffer))
(defadvice recompile (before save-before-recompile activate) (save-buffer))
(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "<f6>") 'recompile)

(defun set-c-style-to-linux () (c-set-style "linux"))
(add-hook 'c-mode-hook 'set-c-style-to-linux)

(defun my-truncate-lines () (setq truncate-lines t))
(add-hook 'c-mode-hook 'my-truncate-lines)

;;----------------------------------------------

(defun my-find-header-file (header)
  "Find and open a C header file in /usr/include or /usr/local/include."
  (interactive "Enter the C header file name (e.g., <stdio.h>): ")
  (let ((header-file (concat "/usr/include/" header))
        (local-header-file (concat "/usr/local/include/" header)))
    (if (file-exists-p header-file)
        (find-file header-file)
      (if (file-exists-p local-header-file)
          (find-file local-header-file)
        (message "Header file not found in /usr/include or /usr/local/include")))))

(defun my-find-header-file-at-point ()
  "Find and open the C header file corresponding to the symbol at point."
  (interactive)
  (let ((header (thing-at-point 'symbol)))
    (when header
      (setq header (concat header ".h"))
      (let ((header-file (concat "/usr/include/" header))
            (local-header-file (concat "/usr/local/include/" header)))
        (if (file-exists-p header-file)
            (find-file header-file)
          (if (file-exists-p local-header-file)
              (find-file local-header-file)
            (message "Header file not found in /usr/include or /usr/local/include")))))))

(global-set-key (kbd "C-c h") 'my-find-header-file-at-point)

(defun my-go-to-file-position ()
  "Go to the file and position specified in the current line."
  (interactive)
  (beginning-of-line)
  (when (re-search-forward "\\([^:]+\\):\\([0-9]+\\)" (line-end-position) t)
    (let ((file (match-string 1))
          (position (string-to-number (match-string 2))))
      (find-file file)
      (goto-char (point-min))
      (forward-char (1- position)))))

(defun my-function-definitions-current-buffer ()
  "Run a program with the current buffer's filename as an argument and display the result in a new buffer."
  (interactive)
  (let ((program "c-function-definitions.py")
        (filename (buffer-file-name))
        (output-buffer (generate-new-buffer "<Function Defintions>")))
    (with-current-buffer output-buffer
      (shell-command (concat program " " filename) t))
    (switch-to-buffer output-buffer)))

;----------------------------------------------

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

;;(load-theme 'catppuccin t)
(load-theme 'gruber-darker t)

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
   '("e27c9668d7eddf75373fa6b07475ae2d6892185f07ebed037eedf783318761d7" "80214de566132bf2c844b9dee3ec0599f65c5a1f2d6ff21a2c8309e6e70f9242" "2628939b8881388a9251b1bb71bc9dd7c6cffd5252104f9ef236ddfd8dbbf74a" "d92c1c36a5181cf629749bf6feee1886cf6bce248ab075c9d1b1f6096fea9539" "2bcd3850ef2d18a4c9208fe3e2a78c95fb82f48c26661c86a51ea39152f3577e" default))
 '(package-selected-packages
   '(dumb-jump expand-region gruber-darker-theme beacon catppuccin-theme modus-themes consult orderless marginalia vertico evil))
 '(ring-bell-function 'ignore)
 '(warning-suppress-types '((use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
