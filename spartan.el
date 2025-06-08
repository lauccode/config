;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Spartan.el Emacs General Settings
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TO COPY AT END OF REAL FILE:

  (menu-bar-mode 1)
  (tool-bar-mode nil)
  (global-display-line-numbers-mode t)
  (recentf-mode 1)
  (desktop-save-mode 1)
  (save-place-mode 1)
  (global-auto-revert-mode 1)
  (global-set-key (kbd "C-c h") 'ff-find-other-file)  ;; Open header for cpp

(setq desktop-save t)
(setq desktop-load-locked-desktop t)

;; select lines
(defun select-line-end ()
  "Select the current line and leave the cursor at the end of the line."
  (interactive)
  (end-of-line)
  (set-mark (line-beginning-position)))
(global-set-key (kbd "C-c l") 'select-line-end)
;; (global-set-key (kbd "C-c L") 'duplicate-line)  ;; "C-c C-l" with crux

;; TO CHECK "C-c i" desapear
;; (use-package boon
;;   :straight t
;;   :ensure t
;;   :config (boon-mode 0))

;; for tree-sitter-lua need to rename ~/.emacs.d/tree-sitter/libtree-sitter-lua.so.0.0
;; eval-last-sexp to know if tree sitter is OK: will return t
;; (featurep 'treesit)
;; (treesit-language-available-p 'lua)

(use-package doom-themes
  :straight t
  :ensure t
  :config
  (load-theme 'leuven-dark t))

;; (use-package lsp-mode
;;   :straight t
;;   :ensure t
;;   :hook ((c++-mode . lsp)
;;          (c-mode . lsp)
;;          (lsp-mode . lsp-enable-which-key-integration))
;;         :commands lsp)

;;; Install lua-mode
;(use-package lua-mode
;             ;:straight t
;  :ensure t)
;;; Download love-minor-mode: Clone the love-minor-mode repository from GitHub.
;;; git clone https://github.com/ejmr/love-minor-mode.git ~/.emacs.d/love-minor-mode
;;; Load love-minor-mode
; (add-to-list 'load-path "~/.emacs.d/love-minor-mode")
; (require 'love-minor-mode)
; ;; Enable love-minor-mode for lua-mode
; (add-hook 'lua-mode-hook 'love-minor-mode)
; (global-set-key (kbd "M-p") (lambda () (interactive) (shell-command "love .")))

(use-package expand-region
  :straight t
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

