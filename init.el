(defun my/org-babel-tangle-on-save ()
  "Tangle the current org file if it's `init.org`."
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/.emacs.d/init.org"))
    (org-babel-tangle)))

(add-hook 'org-mode-hook
          (lambda ()
            (add-hook 'after-save-hook #'my/org-babel-tangle-on-save nil 'make-it-local)))

;;; package --- summary

  ;; Ensure use-package is installed
  ;;; Commentary:
  ;;; Commentary: 

  (require 'package)
  (setq package-archives '(  ("melpa-stable" . "https://stable.melpa.org/packages/")
                             ("melpa" . "https://melpa.org/packages/")
                             ("org" . "https://orgmode.org/elpa/")
                             ("gnu" . "https://elpa.gnu.org/packages/")))

  (package-initialize)
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))

;; List of packages to install
(defvar my-packages
  '(use-package
     copilot
     highlight-thing
     clang-format
     ;; company-clang
     vterm           ;; problematic passed
     doom-themes
     powerline
     quelpa
     quelpa-use-package
     god-mode
     expand-region
     drag-stuff
     savehist
     tramp
     eglot
     lsp-mode
     lsp-ui
     lsp-treemacs
     lsp-ivy
     lsp-mode
     flycheck
     dumb-jump
     company
     project
     projectile
     tree-sitter
     tree-sitter-langs
     magit
     git-gutter
     vertico
     marginalia
     orderless
     consult
     deadgrep
     rg
     which-key
     lua-mode
     multiple-cursors
     pulsar
     switch-window))

;; Install all packages in the list
(dolist (pkg my-packages)
  (unless (package-installed-p pkg)
    (package-install pkg)))

;; Now you can use use-package to configure each package
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

  ;; If error or warning with package:
  ;; package-refresh-contents

(setq org-confirm-babel-evaluate nil)
  ;; Suppress all warnings
  (setq warning-minimum-level :error)
  ;; Suppress specific types of warnings
  ;; (setq warning-suppress-types '((comp)))
  ;; (setq warning-suppress-types '((comp) (bytecomp) (nativecomp)))

  ;; set the tab width to 4 spaces for C++
  (defun my-c++-mode-hook ()
    (setq c-basic-offset 4)    ; Set the basic indentation to 4 spaces
    (setq tab-width 4)         ; Set the tab width to 4 spaces
    (setq indent-tabs-mode nil)) ; Use spaces instead of tabs

  ;; C-x -<, C-x ->	navigate between buffers
  ;; C-x M		consult-mark (in a file)

  ;; C-x SPC          rectangle selection

  ;; M-t              inverse both word (M-b go begin word, M-t toggle with previous)

  ;; "M-n"            retrieve better word or line under cursor when in mini-buffer

  ;; Enable visual line mode globally
  (global-visual-line-mode 1)
  ;; Alternatively, enable it for specific modes
  ;; (add-hook 'text-mode-hook 'visual-line-mode)
  ;; (add-hook 'prog-mode-hook 'visual-line-mode)

  ;; For cpp:
  ;; C-x C-;    comment line
  ;; C-c C-c    comment selection
  ;; C-c C-k    toggle comment style
  ;; M-;        comment at end of line
  (global-set-key (kbd "C-;") 'comment-line)

  ;; Here's an example of aligning on the equal sign:
  ;; M-x align-regexp RET = RET

  ;; mouse activated for emacs in terminal mode (emacs -nw)
  (xterm-mouse-mode 1)

  ;; Add the following configuration to set the cursor type to a vertical bar:
  ;; (setq-default cursor-type 'bar)
  ;; If you prefer a horizontal bar, you can use:
  ;; (setq-default cursor-type 'hbar)
  ;; To make the cursor more visible, you can enable HL Line mode, which highlights the current line:
  (global-hl-line-mode 1)

  ;; Make the mouse wheel scroll one line at a time
  ;; C-SPC C-SPC to mark cursor position (set-mark-command x2)
  ;; scrool with mouse
  ;; C-u C-SPC to retrieve position
  ;; C-x C-SPC (or C-x C-@) to retrieve position if in another buffer (pop-global-mark)
  (setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; One line at a time
  (setq mouse-wheel-progressive-speed nil) ;; Don't accelerate scrolling

  (setq window-divider-default-places t)
  (setq window-divider-default-bottom-width 1)
  (setq window-divider-default-right-width 9) ;; Adjust this value as needed
  (window-divider-mode 1)

  ;; Ensure `grep` and `rgrep` use `ripgrep`
  (setq grep-program "rg")
  ;; launch with ":rgrep"
  ;; "M-n" to retrieve word under cursor to be searched
  ;; In grep buffer, use "n" "p" to see file next/previous preview also with tramp
  ;; In grep buffer, use "C-o" to preview the file under cursor in grep buffer
  ;; Use "M-s ." "M-s M-." to retrieve word under cursor to be searched (classic isearch used)
  ;; define command to search in * from project root :
(defun my-rgrep-selection-or-word ()
  "Run rgrep with the selected region or the word under the cursor.
Reuse the existing grep buffer window if open."
  (interactive)
  (let* ((selection (when (use-region-p)
                      (buffer-substring-no-properties (region-beginning) (region-end))))
         (word (or selection (thing-at-point 'word t)))
         (root-dir (project-root (project-current))))
    (rgrep word "*" root-dir)
    (let ((grep-buffer "*grep*"))
      (when (get-buffer grep-buffer)
        (let ((window (get-buffer-window grep-buffer)))
          (if window
              (select-window window)
            (pop-to-buffer grep-buffer)))))))
(global-set-key (kbd "C-c g") 'my-rgrep-selection-or-word)

  (menu-bar-mode 1)
  (tool-bar-mode nil)
  (global-display-line-numbers-mode t)
  (recentf-mode 1)
  (desktop-save-mode 1)
  (save-place-mode 1)
  (global-auto-revert-mode 1)
  (global-set-key (kbd "C-c h") 'ff-find-other-file)  ;; Open header for cpp
  ;; (global-set-key (kbd "M-o") 'other-window)  ;; comment if use switch-window

;; for emacsc daemon use
;; emacs --fg-daemon
;; emacs --fg-daemon=two
;; emacsclient -c
;; emacsclient -c --socket-name=two
;; emacsclient -c -s two
;; emacsclient -e "(kill-emacs)"
;; emacsclient -e "(kill-emacs)" -s two
;; use describe-variable for server-socket-dir to check if specific path for --socket-name !

(defun my-ninja-build ()
  "Run Ninja build in a specific directory."
  (interactive)
  (let ((default-directory (projectile-project-root)))
    (compile "ninja -C path/to/dir")))
(global-set-key (kbd "C-c n") 'my-ninja-build)

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'leuven-dark t))

(use-package powerline
  :ensure t
  :config
(powerline-default-theme))

;;;;;;;;;;;;;
	      ;; COPILOT
	    ;;;;;;;;;;;;;
	    (setq copilot-enabled nil)
	      ;; QUELPA
	    (unless (package-installed-p 'quelpa)
	      (with-temp-buffer
		(url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
		(eval-buffer)
		(quelpa-self-upgrade)))

	    ;; Ensure quelpa is installed and configured

(use-package quelpa
  :ensure t
  :config
  (quelpa-self-upgrade))

(use-package quelpa-use-package
  :after quelpa
  :ensure t)

	  (when copilot-enabled
(use-package copilot
  :quelpa (copilot :fetcher github :repo "copilot-emacs/copilot.el" :branch "main" :files ("*.el"))
  :config
  (setq copilot-node-executable "~/node-v22.14.0-linux-x64/bin/node")
  (define-key copilot-mode-map (kbd "M-C-<next>") #'copilot-next-completion)
  (define-key copilot-mode-map (kbd "M-C-<prior>") #'copilot-previous-completion)
  (define-key copilot-mode-map (kbd "M-C-<right>") #'copilot-accept-completion-by-word)
  (define-key copilot-mode-map (kbd "M-C-<down>") #'copilot-accept-completion-by-line)
  (define-key global-map (kbd "M-C-<return>") #'rk/copilot-complete-or-accept)))

;; ;; To toggle the highlight of the symbol under the cursor in all buffers:
(use-package highlight-thing
  :ensure t)
(require 'highlight-thing)
;; Define a list of colors
(defvar highlight-symbol-colors '("yellow" "cyan" "magenta" "green" "blue" "orange" "red" "purple")
  "List of colors for highlighting symbols.")
(defvar highlight-symbol-color-index 0
  "Index of the next color to use from `highlight-symbol-colors`.")
(defvar highlighted-symbols nil
  "List of currently highlighted symbols.")
(defun toggle-highlight-symbol-at-point ()
  "Toggle highlighting for the symbol at point in all buffers."
  (interactive)
  (let* ((symbol-at-point (thing-at-point 'symbol t))  ;; Ensure the symbol is correctly identified
         (pattern (regexp-quote symbol-at-point)))
    (if (and symbol-at-point (member pattern highlighted-symbols))
        ;; If the symbol is already highlighted, unhighlight it
        (unhighlight-symbol-at-point pattern)
      ;; Otherwise, highlight the symbol with the next color
      (highlight-symbol-with-next-color symbol-at-point))))
(defun highlight-symbol-with-next-color (symbol-at-point)
  "Highlight the symbol at point with the next color from `highlight-symbol-colors`."
  (let ((color (nth highlight-symbol-color-index highlight-symbol-colors)))
    (when symbol-at-point
      (save-excursion
        ;; Create a custom face for the symbol with the chosen color
        (let ((face-name (intern (concat "highlight-symbol-face-" color))))
          (unless (facep face-name)
            (make-face face-name)
            (set-face-attribute face-name nil :background color :foreground "black"))
          (dolist (buffer (buffer-list))
            (with-current-buffer buffer
              (highlight-regexp (regexp-quote symbol-at-point) face-name))))
        ;; Add the symbol to the list of highlighted symbols
        (add-to-list 'highlighted-symbols (regexp-quote symbol-at-point))
        ;; Update the color index for the next symbol
        (setq highlight-symbol-color-index (mod (1+ highlight-symbol-color-index) (length highlight-symbol-colors)))))))
(defun unhighlight-symbol-at-point (pattern)
  "Remove highlighting for the symbol at point in all buffers."
  (interactive)
  (when pattern
    (dolist (buffer (buffer-list))
      (with-current-buffer buffer
        (hi-lock-unface-buffer pattern)))
    ;; Remove the symbol from the list of highlighted symbols
    (setq highlighted-symbols (remove pattern highlighted-symbols))))
(defun unhighlight-all-symbols-in-all-buffers ()
  "Remove all symbol highlighting in all buffers."
  (interactive)
  (dolist (buffer (buffer-list))
    (with-current-buffer buffer
      (hi-lock-mode 1)  ;; Ensure hi-lock-mode is enabled
      (hi-lock-unface-buffer t)))
  ;; Clear the list of highlighted symbols
  (setq highlighted-symbols nil))
;; Bind the function to the shortcut
(global-set-key (kbd "C-c C-SPC") 'toggle-highlight-symbol-at-point)
(global-set-key (kbd "C-c C-M-SPC") 'unhighlight-all-symbols-in-all-buffers)

;; GOD MODE
;; GOD MODE
(use-package god-mode
  :ensure t
  :init
  (god-mode)
  ;; (global-set-key (kbd "<escape>") #'god-local-mode)
  (global-set-key (kbd "<escape>") #'god-mode-all)

;; ;; (custom-set-faces
;; ;;  '(god-mode-lighter ((t (:inherit error)))))

;; change cursor in line = no GOD MODE
(defun my-god-mode-update-cursor-type ()
  (setq cursor-type (if (or god-local-mode buffer-read-only) 'box 'bar)))
(add-hook 'post-command-hook #'my-god-mode-update-cursor-type)

;; ;; change foreground and foreground for GOD-MODE
;; (defun my-god-mode-update-mode-line ()
;;   (cond
;;    (god-local-mode
;;     (set-face-attribute 'mode-line nil
;;                         :foreground "black"
;;                         :background "DarkGoldenrod3")
;;     (set-face-attribute 'mode-line-inactive nil
;;                         :foreground "gray"
;;                         :background "goldenrod4"))
;;    (t
;;     (set-face-attribute 'mode-line nil
;; 			            :foreground "LightGray"
;; 			            :background "black")
;;     (set-face-attribute 'mode-line-inactive nil
;; 			            :foreground "gray"
;; 			            :background "DimGray"))))
;; (add-hook 'post-command-hook #'my-god-mode-update-mode-line)

(defun tsa/god-cursor ()
  (defvar tsa/cursor-bg (face-attribute 'cursor :background))

  (if (or god-local-mode buffer-read-only)
      (progn
        (setq cursor-type 'hbar)
        (set-face-attribute 'cursor nil
                            ;; :background "#11ff33"))
                            :background "orange"))
    (progn
      (setq cursor-type 'box)
      (set-face-attribute 'cursor nil
                          :background tsa/cursor-bg))))

(defun tsa/god-update-mode-line ()
  (defvar tsa/fg  (face-attribute 'mode-line :foreground))
  (defvar tsa/bg  (face-attribute 'mode-line :background))
  (defvar tsa/fgi (face-attribute 'mode-line-inactive :foreground))
  (defvar tsa/bgi (face-attribute 'mode-line-inactive :background))
  (cond
   (god-local-mode
    (set-face-attribute 'mode-line nil
                        :foreground "white"
                        ;; :background "DarkGoldenrod4")
                        ;; :background "dark cyan")
                        :background "purple")
    (set-face-attribute 'mode-line-inactive nil
                        :foreground tsa/fgi
                        :background tsa/bgi))
   (t
    (set-face-attribute 'mode-line nil
                        :foreground tsa/fg
                        :background tsa/bg)
    (set-face-attribute 'mode-line-inactive nil
                        :foreground tsa/fgi
                        :background tsa/bgi))))

(defun tsa/reflect-god-mode ()
  "Make visual changes representing whether God is enabled"
  (interactive "P")
  (tsa/god-update-mode-line)
  (tsa/god-cursor))

(add-hook 'post-command-hook 'tsa/reflect-god-mode))
(setq god-mode-enable-function-key-translation nil)
(god-mode)
(add-to-list 'god-exempt-major-modes 'vterm-mode)

;; key binding for god-mode
(global-set-key (kbd "C-x C-1") #'delete-other-windows)
(global-set-key (kbd "C-x C-2") #'split-window-below)
(global-set-key (kbd "C-x C-3") #'split-window-right)
(global-set-key (kbd "C-x C-0") #'delete-window)

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
(global-set-key (kbd "C-c L") 'duplicate-line)

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

(setq eglot-feature-enabled nil)
(setq lsp-feature-enabled t)
(setq jump-feature-enabled nil)

(if eglot-feature-enabled
    (progn
      ;; eglot
      ;; 1. **Install Eglot**: First, make sure Eglot is installed:
      (use-package eglot
	:ensure t
	;; 2. **Install `clangd`**: Install `clangd` if you haven't already. You can install it using a package manager like `brew`, `apt`, or `choco`:
	;; sudo apt install clangd
	;; 3. **Configure Eglot for C++**: Add `clangd` to Eglot's configuration for C++ mode:
	:config
	(add-to-list 'eglot-server-programs '(c++-mode . ("clangd")))
	(add-to-list 'eglot-server-programs '(c-mode . ("clangd")))
	;; 4. **Start Eglot**: Open a C++ file and start Eglot with `M-x eglot RET`. This will initialize `clangd` for your project.
	;; 5. **Automatic Startup**: If you want Eglot to start automatically when you open a C++ file, add it to the major-mode hook:
	(add-hook 'c++-mode-hook 'eglot-ensure)
	(add-hook 'c-mode-hook 'eglot-ensure))  ))
;; 6. **Project-Specific Configuration**: You can customize `clangd` using a `.dir-locals.el` file in your project directory:
;; ((c++-mode . ((eglot-workspace-configuration . (:clangd (:fallbackFlags ["-std=c++17"] :clangTidy (:checks ["*"] :clangdCheck :json-false))))))
;;  (c-mode . ((eglot-workspace-configuration . (:clangd (:fallbackFlags ["-std=c11"] :clangTidy (:checks ["*"] :clangdCheck :json-false))))))))

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
      ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TO REPLACE LSP
(if jump-feature-enabled
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

;; TBT, try to use project
;; (use-package project
;;   :init
;;   (setq project-vc-extra-root-markers '(".project")))

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

(defun projectile-ripgrep-find-file-all ()
  "Find file in project, including those ignored by .gitignore using ripgrep."
  (interactive)
  (let ((projectile-generic-command "rg --files --hidden --no-ignore --glob '!.git/' -0"))
    (projectile-find-file)))
(define-key projectile-mode-map (kbd "C-c p G") 'projectile-ripgrep-find-file-all)

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
  '(setq magit-remote-git-executable "/usr/bin/git"))

;; view git change in margin
(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode +1))

;; Install and configure Vertico
(use-package vertico
  :ensure t
  :init
  (vertico-mode)
  :custom
  (vertico-resize t)  ;; Enable dynamic resizing
  (vertico-count 30)) ;; Number of candidates to show
(setq max-mini-window-height 0.5)  ;; max 50%
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
  :bind (("C-s" . consult-line)    ;; "M-n" to retrieve line under cursor when in mini-buffer 
         ("M-y" . consult-yank-pop)
         ("C-x b" . consult-buffer)
         ("C-x M" . consult-mark)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x 5 b" . consult-buffer-other-frame)
         ("M-g g" . consult-goto-line)
         ("M-g M-g" . consult-goto-line)
         ("C-x C-r" . consult-recent-file)
	 ("M-s r" . my-consult-ripgrep-standard)
	 ("M-s R" . my/consult-ripgrep-all)
         ("M-s l" . consult-line)))
;; Standard Search:
(defun my-consult-ripgrep-standard ()
  "Run consult-ripgrep with standard parameters."
  (interactive)
  (let ((consult-ripgrep-args "rg --null --line-buffered --color=never --max-columns=1000 --path-separator / --smart-case --no-heading --line-number")
        (symbol (thing-at-point 'symbol t)))
    (if symbol
        (consult-ripgrep nil symbol)
      (consult-ripgrep))))
;; Search All Files:
(defun my/consult-ripgrep-all ()
  "Run consult-ripgrep to search all files."
  (interactive)
  (let ((consult-ripgrep-args "rg -uu --null --line-buffered --color=never --max-columns=1000 --path-separator / --smart-case --no-heading --line-number")
        (symbol (thing-at-point 'symbol t)))
    (if symbol
        (consult-ripgrep nil symbol)
      (consult-ripgrep))))

;; (defun consult-ripgrep-with-symbol-at-point ()
;;   "Run `consult-ripgrep` with the symbol at point as the initial input."
;;   (interactive)
;;   (let ((symbol (thing-at-point 'symbol t)))
;;     (if symbol
;;         (consult-ripgrep nil symbol)
;;       (message "No symbol found under cursor."))))

;; ;; Bind the custom function to a key
;; (global-set-key (kbd "C-c r") 'consult-ripgrep-with-symbol-at-point)

(use-package deadgrep
  :ensure t
  :init
  :config
(global-set-key (kbd "<f5>") #'deadgrep))

(use-package rg
  :ensure t
  :init
  :config
(rg-enable-default-bindings)) ;; C-c S
(with-eval-after-load 'rg
  (advice-add 'rg-run :after
	      #'(lambda (_pattern _files _dir &optional _literal _confirm _flags) (pop-to-buffer (rg-buffer-name)))))

;; Install and configure which-key
(use-package which-key
  :ensure t
  :init
  :config
  (which-key-mode t)
  (which-key-enable-god-mode-support)
  (setq which-key-idle-delay 0.5))  ;; Adjust the delay as needed

;; Install lua-mode
(use-package lua-mode
  :ensure t)
;; Download love-minor-mode: Clone the love-minor-mode repository from GitHub.
;; git clone https://github.com/ejmr/love-minor-mode.git ~/.emacs.d/love-minor-mode
;; Load love-minor-mode
;; (add-to-list 'load-path "~/.emacs.d/love-minor-mode")
;; (require 'love-minor-mode)
;; ;; Enable love-minor-mode for lua-mode
;; (add-hook 'lua-mode-hook 'love-minor-mode)
;; (global-set-key (kbd "M-p") (lambda () (interactive) (shell-command "love .")))

;; Install multiple-cursors
(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C-<" . mc/mark-next-like-this)
         ("C-M-<" . mc/skip-to-next-like-this)
         ("C->" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))

;; French check for writing
;; sudo apt-get install aspell aspell-fr aspell-en
;; Enable Flyspell for text modes
(add-hook 'text-mode-hook 'flyspell-mode)
(setq ispell-program-name "aspell")
(setq ispell-dictionary "francais")
;; (setq ispell-dictionary "english")
;; check word under cursor with M-$
;; You can enable spell checking in a buffer by using:
;; M-x ispell-buffer
;; Or to check a specific region:
;; M-x ispell-region  <-----------------------------------
;; Enable Flyspell for programming modes (if desired)
;; (add-hook 'prog-mode-hook 'flyspell-prog-mode)
;; Ensure aspell is used
;; Automatically check spelling when saving a file
;; (add-hook 'before-save-hook 'ispell-buffer)
;; Function to switch dictionary

;; add terminal
;; (require 'vterm)
(use-package vterm
  :ensure t
  :bind ("C-c t" . my-vterm)
  :config
  (setq vterm-size 80)
  (setq vterm-command "/bin/bash"))
(defun my-vterm ()
  "Open a new instance of vterm."
  (interactive)
  (vterm (generate-new-buffer-name "vterm")))

(require 'org)
;; pomodoro
;; org-timer-set-timer
;; org-timer-pause-or-continue

(use-package pulsar
	:ensure t
	:config
(pulsar-global-mode 1))
(add-hook 'minibuffer-setup-hook #'pulsar-pulse-line)

(winner-mode 1)  ;; winner-undo (C-c <left>) and winner-redo (C-c <right>)
   ;; add easier switch windows
   (use-package switch-window
     :ensure t
     :config
     (advice-add 'switch-window :after 'pulsar-pulse-line)

(global-set-key (kbd "M-o") 'switch-window)

;; (global-set-key (kbd "C-c m") 'delete-other-windows)
(global-set-key (kbd "C-c m") 'switch-window-then-maximize)

;; (global-set-key (kbd "C-c h") 'split-window-below)
(global-set-key (kbd "C-c h") 'switch-window-then-split-below)

;; (global-set-key (kbd "C-c v") 'split-window-right)
(global-set-key (kbd "C-c v") 'switch-window-then-split-right)

;; (global-set-key (kbd "C-c c") 'delete-window)
(global-set-key (kbd "C-c c") 'switch-window-then-delete)

(global-set-key (kbd "C-x 4 d") 'switch-window-then-dired)
(global-set-key (kbd "C-x 4 f") 'switch-window-then-find-file)
(global-set-key (kbd "C-x 4 m") 'switch-window-then-compose-mail)
(global-set-key (kbd "C-x 4 r") 'switch-window-then-find-file-read-only)

(global-set-key (kbd "C-x 4 C-f") 'switch-window-then-find-file)
(global-set-key (kbd "C-x 4 C-o") 'switch-window-then-display-buffer)

(global-set-key (kbd "C-x 4 0") 'switch-window-then-kill-buffer)

;; I use text terminal, but I want bigger label.
;; The only choice is using asciiart, which draw a bigger label with small ascii char.
;; (setq switch-window-shortcut-appearance 'text)
;; (setq switch-window-shortcut-appearance 'asciiart)  ;; for terminal emacs mode !

;; I want to select a window with "a-z" instead of "1-9".
(setq switch-window-shortcut-style 'qwerty)
;; Note: user can arrange qwerty shortcuts by variable `switch-window-qwerty-shortcuts'.
;; I want to hide window label when window's number < 3
(setq switch-window-threshold 2)
;; I want to select minibuffer with label "z".
(setq switch-window-minibuffer-shortcut ?z))

;; Additional settings
;; (setq lsp-enable-snippet nil)  ;; Disable snippets if they cause issues
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
