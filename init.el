;; Ensure use-package is installed
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(global-display-line-numbers-mode t)
(recentf-mode 1)
(desktop-save-mode 1)
(global-set-key (kbd "C-c h") 'ff-find-other-file)  ;; Open header for cpp

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-rouge t))
;; (load-theme 'wombat t)

(use-package savehist
  :ensure t
  :init
  (savehist-mode 1)
  (setq savehist-additional-variables '(command-history)))

;; Flycheck (TO BE REMOVED IF LSP)
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; ;; LSP Mode
;; (use-package lsp-mode
;;   :ensure t
;;   :hook ((prog-mode . lsp))
;;   :commands lsp
;;   :config
;; ;;   (setq lsp-clients-clangd-args '("--compile-commands-dir=/remote/path/to/project"))
;;   (lsp-register-client
;;    (make-lsp-client :new-connection (lsp-tramp-connection "clangd")
;;                     :major-modes '(c-mode c++-mode)
;;                     :remote? t
;;                     :server-id 'clangd-remote)))

;; ;; (setq debug-on-error t)
;; (use-package xref
;;   :ensure t)
;; (setq lsp-log-io t)

;; ;; LSP UI
;; (use-package lsp-ui
;;   :ensure t
;;   :commands lsp-ui-mode)

;; ;; LSP Treemacs
;; (use-package lsp-treemacs
;;   :ensure t
;;   :commands lsp-treemacs-errors-list)

;; ;; LSP Ivy
;; (use-package lsp-ivy
;;   :ensure t
;;   :commands lsp-ivy-workspace-symbol)

;; Install Dumb Jump
(use-package dumb-jump
  :ensure t
;;   :bind (("M-g o" . dumb-jump-go-other-window)
;;          ("M-g j" . dumb-jump-go)
;;          ("M-g b" . dumb-jump-back)
;;          ("M-g q" . dumb-jump-quick-look))
  :config
  (setq dumb-jump-selector 'ivy)  ;; Use Ivy for selection interface
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

;; Projectile
(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map))
  :config
  (setq projectile-indexing-method 'alien)
  (setq projectile-enable-caching t)
  (setq projectile-git-command "git ls-files -zco --exclude-standard")
;;   (setq projectile-project-search-path '("~/projects/" "/ssh:remote:/path/to/projects/"))
  (projectile-discover-projects-in-search-path))
;; Exclude unnecessary files in .projectile
;; -/path/to/exclude
;; -*.log

;; TRAMP
(use-package tramp
  :ensure t
  :config
  (setq tramp-default-method "plink")
  (setq tramp-default-remote-shell "/bin/bash")  ;; Change to the desired shell
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
  (add-to-list 'tramp-remote-path '("/usr/local/bin" "/usr/bin" "/bin" "/snap/bin")))  ;; Add desired paths

;; Tree-sitter
(use-package tree-sitter
  :ensure t
  :hook ((prog-mode . tree-sitter-mode)
         (tree-sitter-after-on . tree-sitter-hl-mode))
  :config
  (add-to-list 'tree-sitter-major-mode-language-alist '(c++-mode . cpp))
  (add-hook 'find-file-hook
            (lambda ()
              (when (file-remote-p (buffer-file-name))
                (tree-sitter-mode)
                (tree-sitter-hl-mode)))))

(use-package tree-sitter-langs
  :ensure t
  :after tree-sitter
  :config
  (tree-sitter-require 'cpp))

;; Magit
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch)))
;; seems needed to have magit ok to find git
(eval-after-load 'tramp
  '(setq magit-remote-git-executable "/usr/local/bin/git"))

;; Company (Complete Anything)
;; Company is a modular text completion framework that works well with many programming languages and backends.
(use-package company
  :ensure t
  :init
  :config
  (global-company-mode t)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  :bind (("M-/" . company-complete)))

(use-package company-clang
  :ensure company
  :config
  (setq company-clang-executable "/usr/bin/clang")  ;; Adjust to the remote clang path
  (setq company-clang-arguments '("-I/usr/include" "-I/usr/local/include")))

;; Install and configure Vertico
(use-package vertico
  :ensure t
  :init
  (vertico-mode))
;; Optional enhancements
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles basic partial-completion)))))
(use-package consult
  :ensure t
  :bind (("C-s" . consult-line)
         ("M-y" . consult-yank-pop)
         ("C-x b" . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x 5 b" . consult-buffer-other-frame)
         ("M-g g" . consult-goto-line)
         ("M-g M-g" . consult-goto-line)
         ("C-x C-r" . consult-recent-file)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)))
(use-package consult
  :ensure t
  :bind     ("M-s R" . my/consult-ripgrep-all)  ; WORK
  :config
  (setq consult-ripgrep-args "rg --null --line-buffered --color=never --max-columns=1000 --path-separator / --smart-case --no-heading --line-number ."))
(defun my/consult-ripgrep-all ()
  "Run `consult-ripgrep` with arguments to include hidden and ignored files."
  (interactive)
  ; (let ((consult-ripgrep-args "rg --hidden --no-ignore -u --null --line-buffered --color=never --max-columns=1000 --path-separator / --smart-case --no-heading --line-number ."))
  (let ((consult-ripgrep-args "rg -u --null --line-buffered --color=never --max-columns=1000 --path-separator / --smart-case --no-heading --line-number ."))
    (consult-ripgrep)))
(defun projectile-ripgrep-find-file-all ()
  "Find file in project, including those ignored by .gitignore using ripgrep."
  (interactive)
  (let ((projectile-generic-command "rg --files --hidden --no-ignore --glob '!.git/' -0"))
    (projectile-find-file)))
(define-key projectile-mode-map (kbd "C-c p G") 'projectile-ripgrep-find-file-all)

;; Install and configure which-key
(use-package which-key
  :ensure t
  :init
  :config
  (which-key-mode t)
  (setq which-key-idle-delay 0.5))  ;; Adjust the delay as needed

;; Install lua-mode
(use-package lua-mode
  :ensure t)
;; Download love-minor-mode: Clone the love-minor-mode repository from GitHub.
;; git clone https://github.com/ejmr/love-minor-mode.git ~/.emacs.d/love-minor-mode
;; Load love-minor-mode
(add-to-list 'load-path "~/.emacs.d/love-minor-mode")
;; (require 'love-minor-mode)
;; ;; Enable love-minor-mode for lua-mode
;; (add-hook 'lua-mode-hook 'love-minor-mode)
;; (global-set-key (kbd "M-p") (lambda () (interactive) (shell-command "love .")))

;; Install multiple-cursors
(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))

;; Additional settings
;; (setq lsp-enable-snippet nil)  ;; Disable snippets if they cause issues
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(projectile lsp-ivy lsp-treemacs lsp-ui lsp-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
