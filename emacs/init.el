(setq gc-cons-threshold (* 8 1000 1000))
;(server-start)
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)
(global-visual-line-mode -1)
(global-auto-revert-mode 1)
;;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/") ("org" . "https://orgmode.org/elpa/") ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))
(unless (package-installed-p 'use-package) (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)
;;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

(use-package evil :init (evil-mode 1))
;; (use-package evil-collection :init (evil-collection-setup-minibuffer t))
;(use-package ranger :init (ranger-override-dired-mode 1))
(use-package vertico :init (vertico-mode 1))
(use-package marginalia :init (marginalia-mode 1))
(use-package orderless :config (setq completion-styles '(orderless basic)))
(use-package consult :bind (("C-x b" . consult-buffer)))
(use-package beacon :init (beacon-mode 1) :config (setq beacon-blink-delay 0.1))
(use-package expand-region :init (global-set-key (kbd "M-f") 'er/expand-region))
;(use-package dumb-jump :init (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))
;;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

(add-hook 'dired-mode-hook 'dired-hide-details-mode)
(add-hook 'dired-mode-hook 'global-display-line-numbers-mode)

(setq-default line-spacing 0)
(setq-default scroll-step 1)
(setq-default scroll-conservatively 10000)
(pixel-scroll-precision-mode 1)
(setq-default mode-line-format '("%e %b"))
(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files")))
(load-theme 'gruber-darker t)

(set-face-attribute 'default nil :font "JetBrainsMonoNerdFont" :height 80 :weight 'light)
(set-face-attribute 'font-lock-keyword-face nil :slant 'italic)
(set-face-attribute 'font-lock-comment-face nil :slant 'italic)
(set-face-attribute 'default nil :background "#000000" :foreground "#FFFFFF")
;;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

(defadvice compile (before save-before-compile activate) (save-buffer))
(defadvice recompile (before save-before-recompile activate) (save-buffer))

(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "<f6>") 'recompile)
(global-set-key (kbd "<f7>") 'shell-command)
(global-set-key (kbd "M-K") 'my-keypad-mode)
(global-set-key (kbd "M-C") (lambda () (interactive) (call-interactively 'calc-embedded) (call-interactively 'calc-embedded)))
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(add-hook 'c-mode-hook (lambda () (setq c-basic-offset 8 indent-tabs-mode nil)))
(add-hook 'c-mode-hook (lambda () (setq truncate-lines t)))
(add-hook 'c-mode-hook (lambda () (setq comment-style 'indent)))
(add-hook 'c-mode-hook (lambda () (hide-ifdef-mode t)))

(add-hook 'c++-mode-hook (lambda () (setq c-basic-offset 8 indent-tabs-mode nil)))
(add-hook 'c++-mode-hook (lambda () (setq truncate-lines t)))
(add-hook 'c++-mode-hook (lambda () (setq comment-style 'indent)))


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

(defvar my-compilation-no-display nil
  "If non-nil, the compilation buffer will not be displayed automatically.")

(defun my-toggle-compilation-display ()
  "Toggle the automatic display of the compilation buffer."
  (interactive)
  (setq my-compilation-no-display (not my-compilation-no-display))
  (if my-compilation-no-display
      (setq display-buffer-alist
            '(("*compilation*" display-buffer-no-window)))
    (setq display-buffer-alist
          '(("*compilation*" display-buffer-same-window))))
  (message "Automatic display of compilation buffer is now %s"
           (if my-compilation-no-display "off" "on")))

(defun my-c-stringify-region ()
  (interactive)
  (let ((start (region-beginning))
        (end (region-end)))
    (shell-command-on-region start end "sed 's/^/\"/'" nil t)
    (shell-command-on-region start end "sed 's/$/\\\\n\"/'" nil t)))

(defun my-c-stringify-region-evil ()
  (interactive)
    (evil-ex "'<,'>s/^/\"/")
    (evil-ex "'<,'>s/$/\\\\n\"/"))

(define-minor-mode my-keypad-mode
  "A minor mode that makes 'u i o j k l m , . n' act like a number pad."
  :init-value nil
  :lighter " KP"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "u") 'self-insert-command)
            (define-key map (kbd "i") 'self-insert-command)
            (define-key map (kbd "o") 'self-insert-command)
            (define-key map (kbd "j") 'self-insert-command)
            (define-key map (kbd "k") 'self-insert-command)
            (define-key map (kbd "l") 'self-insert-command)
            (define-key map (kbd "m") 'self-insert-command)
            (define-key map (kbd ",") 'self-insert-command)
            (define-key map (kbd ".") 'self-insert-command)
            (define-key map (kbd "n") 'self-insert-command)
            (define-key map (kbd "u") (lambda () (interactive) (insert "7")))
            (define-key map (kbd "i") (lambda () (interactive) (insert "8")))
            (define-key map (kbd "o") (lambda () (interactive) (insert "9")))
            (define-key map (kbd "j") (lambda () (interactive) (insert "4")))
            (define-key map (kbd "k") (lambda () (interactive) (insert "5")))
            (define-key map (kbd "l") (lambda () (interactive) (insert "6")))
            (define-key map (kbd "m") (lambda () (interactive) (insert "1")))
            (define-key map (kbd ",") (lambda () (interactive) (insert "2")))
            (define-key map (kbd ".") (lambda () (interactive) (insert "3")))
            (define-key map (kbd "n") (lambda () (interactive) (insert "0")))
            map))


;;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("fed90b0cf3dd7b00b5f0b048542c25d6c19d5335bdf121d8b54e59766f17daae" "cab317d0125d7aab145bc7ee03a1e16804d5abdfa2aa8738198ac30dc5f7b569" "39dd7106e6387e0c45dfce8ed44351078f6acd29a345d8b22e7b8e54ac25bac4" "7c7026a406042e060bce2b56c77d715c3a4e608c31579d336cb825b09e60e827" "b5c3c59e2fff6877030996eadaa085a5645cc7597f8876e982eadc923f597aca" "7d1c7ea4f3e73402f012b7011fc4be389597922fa67ad4ec417816971bca6f9d" "8746b94181ba961ebd07c7397339d6a7160ee29c75ca1734aa3744274cbe0370" "aa742450bc84284415b398be20bfe1c7e63b58fbbc4beb4f2709ce08f2ca3c92" "e27c9668d7eddf75373fa6b07475ae2d6892185f07ebed037eedf783318761d7" "80214de566132bf2c844b9dee3ec0599f65c5a1f2d6ff21a2c8309e6e70f9242" "2628939b8881388a9251b1bb71bc9dd7c6cffd5252104f9ef236ddfd8dbbf74a" "d92c1c36a5181cf629749bf6feee1886cf6bce248ab075c9d1b1f6096fea9539" "2bcd3850ef2d18a4c9208fe3e2a78c95fb82f48c26661c86a51ea39152f3577e" default))
 '(package-selected-packages
   '(quasi-monochrome-theme monochrome-theme evil-collection origami ranger dumb-jump expand-region gruber-darker-theme beacon catppuccin-theme modus-themes consult orderless marginalia vertico evil))
 '(ring-bell-function 'ignore)
 '(warning-suppress-types '((use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
