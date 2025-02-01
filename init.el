;;; package --- summary

;; Ensure use-package is installed
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;; Commentary:

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'leuven-dark t))

;; Add the following configuration to set the cursor type to a vertical bar:
;; (setq-default cursor-type 'bar)
;; If you prefer a horizontal bar, you can use:
;; (setq-default cursor-type 'hbar)
;; To make the cursor more visible, you can enable HL Line mode, which highlights the current line:
(global-hl-line-mode 1)

(setq window-divider-default-places t)
(setq window-divider-default-bottom-width 1)
(setq window-divider-default-right-width 9) ;; Adjust this value as needed
(window-divider-mode 1)

(global-display-line-numbers-mode t)
(recentf-mode 1)
(desktop-save-mode 1)
(save-place-mode 1)
(global-auto-revert-mode 1)
(global-set-key (kbd "C-c h") 'ff-find-other-file)  ;; Open header for cpp

;; To toggle the highlight of the symbol under the cursor:
;; (use-package symbol-overlay
;;   :ensure t
;;   :config
;;   (symbol-overlay-mode t)
;;   (global-set-key (kbd "C-c C-M-SPC") 'symbol-overlay-remove-all)
;;   (global-set-key (kbd "C-c C-SPC") 'symbol-overlay-put))
;; ;; (package-install 'highlight-symbol)
(require 'highlight-symbol)
;; Define a function to remove all highlights
(defun remove-all-highlights ()
  (interactive)
  (highlight-symbol-remove-all))
;; Set the key binding to remove all highlights
(global-set-key (kbd "C-c C-M-SPC") 'remove-all-highlights)
;; Set highlight colors
(setq highlight-symbol-colors '("yellow" "DeepPink" "cyan" "MediumSpringGreen"
                                "orange" "HotPink" "SpringGreen" "MediumPurple"))
;; Enable highlight-symbol mode globally
(global-highlight-symbol-mode 1)
;; Set the key binding to highlight symbols
(global-set-key (kbd "C-c C-SPC") 'highlight-symbol)

(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

;; ALT + Arrow Up and ALT + Arrow Down to move lines:
(use-package drag-stuff
  :ensure t
  :config
  (drag-stuff-global-mode 1)
  (global-set-key (kbd "M-<up>") 'drag-stuff-up)
  (global-set-key (kbd "M-<down>") 'drag-stuff-down))

;; select lines
(defun select-line-end ()
  "Select the current line and leave the cursor at the end of the line."
  (interactive)
  (end-of-line)
  (set-mark (line-beginning-position)))
(global-set-key (kbd "C-c l") 'select-line-end)

(use-package savehist
  :ensure t
  :init
  (savehist-mode 1)
  (setq savehist-additional-variables '(command-history)))

;; TRAMP
(use-package tramp
  :ensure t
  :config
  (setq tramp-default-method "plink")
  (setq tramp-default-remote-shell "/bin/bash")  ;; Change to the desired shell
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
  (add-to-list 'tramp-remote-path '("/usr/local/bin" "/usr/bin" "/bin" "/snap/bin")))  ;; Add desired paths


(setq lsp-feature-enabled t)

(if lsp-feature-enabled
    (progn
     ;; ;; Install and configure lsp-mode
(use-package lsp-mode
  :ensure t
  :hook ((c++-mode . lsp)
         (c-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; Optional: Install lsp-ui for additional UI features
(use-package lsp-ui
  :ensure t
  :config
    (setq lsp-ui-doc-enable t)
    (setq lsp-ui-doc-show-with-mouse nil)
  :commands lsp-ui-mode)

;; LSP Treemacs
(use-package lsp-treemacs
  :ensure t
  :commands lsp-treemacs-errors-list)

;; LSP Ivy
(use-package lsp-ivy
  :ensure t
  :commands lsp-ivy-workspace-symbol)

;; Ensure lsp-mode works with tramp
(setq lsp-enable-file-watchers nil)

;; adapt shortcuts for windows
(global-unset-key (kbd "s-l"))
(use-package lsp-mode
  :commands lsp
  :init
  (setq lsp-keymap-prefix "C-c C-l")
  :config
  (define-key lsp-mode-map (kbd "C-c C-l") lsp-command-map)
  :hook (lsp-mode . lsp-enable-which-key-integration))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TO REPLACE LSP

  (progn
   ;; Flycheck (TO BE REMOVED IF LSP)
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

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

;; format selection with clang-format
;; Specify the path to clang-format executable
(use-package clang-format
  :ensure t
  :config
;; Bind clang-format-region to a key (e.g., C-c f)
;; (setq clang-format-executable "/home/user/extension/LLVM/bin/clang-format")
(eval-after-load 'cc-mode
  '(define-key c++-mode-map (kbd "C-c f") 'clang-format-region)))

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
)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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

;; view git change in margin
(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode +1))

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


;; French check for writing
;; sudo apt-get install aspell aspell-fr
(setq ispell-program-name "aspell")
(setq ispell-dictionary "francais")
;; check word under cursor with M-$
;; You can enable spell checking in a buffer by using:
;; M-x ispell-buffer
;; Or to check a specific region:
;; M-x ispell-region

;; add terminal
(use-package vterm
  :ensure t
  :bind ("C-c v" . vterm)
  :config
  (setq vterm-size 80)
  (setq vterm-command "/bin/bash"))

(require 'org)
;; pomodoro
;; org-timer-set-timer
;; org-timer-pause-or-continue

;; for emacsc daemon use
;; emacs --fg-daemon
;; emacs --fg-daemon=two
;; emacsclient -c
;; emacsclient -c --socket-name=two
;; emacsclient -c -s two
;; emacsclient -e "(kill-emacs)"
;; emacsclient -e "(kill-emacs)" -s two
;; use describe-variable for server-socket-dir to check if specific path for --socket-name !

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
