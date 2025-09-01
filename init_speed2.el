;; straight to manage package
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

(setq package-enable-at-startup nil)

(straight-use-package 'use-package)

;; path in title bar
(setq frame-title-format
      '(:eval (if buffer-file-name
                  (abbreviate-file-name buffer-file-name)
                "%b")))

(setq org-confirm-babel-evaluate nil)
;; Suppress all warnings
(setq warning-minimum-level :error)
;; Suppress specific types of warnings
;; (setq warning-suppress-types '((comp)))
;; (setq warning-suppress-types '((comp) (bytecomp) (nativecomp)))

(global-set-key (kbd "C-c i")
  (lambda () (interactive) (find-file user-init-file)))

;; set the tab width to 4 spaces for C++
(defun my-c++-mode-hook ()
  (setq c-basic-offset 4)    ; Set the basic indentation to 4 spaces
  (setq tab-width 4)         ; Set the tab width to 4 spaces
  (setq indent-tabs-mode nil)) ; Use spaces instead of tabs
;; set the tab width to 4 spaces for C
(defun my-c-mode-hook ()
  (setq c-basic-offset 4)    ; Set the basic indentation to 4 spaces
  (setq tab-width 4)         ; Set the tab width to 4 spaces
  (setq indent-tabs-mode nil)) ; Use spaces instead of tabs
;; set the tab width to 4 spaces for C++ for ts
(defun my-c++-ts-mode-hook ()
  (setq-local c-ts-mode-indent-offset 4)    ; Set the basic indentation to 4 spaces
  (setq-local tab-width 4)         ; Set the tab width to 4 spaces
  (setq-local indent-tabs-mode nil)) ; Use spaces instead of tabs
;; set the tab width to 4 spaces for C for ts
(defun my-c-ts-mode-hook ()
  (setq-local c-ts-mode-indent-offset 4)    ; Set the basic indentation to 4 spaces
  (setq-local tab-width 4)         ; Set the tab width to 4 spaces
  (setq-local indent-tabs-mode nil)) ; Use spaces instead of tabs
(defun my-lua-ts-mode-hook ()
  (setq-local lua-ts-mode-indent-offset 4)    ; Set the basic indentation to 4 spaces
  (setq-local tab-width 4)         ; Set the tab width to 4 spaces
  (setq-local indent-tabs-mode nil)) ; Use spaces instead of tabs

;; For classic CC mode
(add-hook 'c++-mode-hook #'my-c++-mode-hook)
(add-hook 'c-mode-hook #'my-c-mode-hook)
;; For Tree-sitter C++ mode
(add-hook 'c++-ts-mode-hook #'my-c++-ts-mode-hook)
(add-hook 'c-ts-mode-hook #'my-c-ts-mode-hook)
;; For Tree-sitter lua mode
(add-hook 'lua-ts-mode-hook #'my-lua-ts-mode-hook)

;; M-% to replace, below arrow to retrieve word under cursor in minibuffer !

;; M-s M-. to isearch-forward-thing-at-point is an interactive byte-code-function in

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
(global-set-key (kbd "M-o") 'other-window)  ;; comment if use switch-window
;; Shift + arrow to move windows
(windmove-default-keybindings)
;; C-S BACKSPACE to kill all the line
;; M-w copy the line without selection
(defun my/copy-line-or-region ()
  "Copy region if active, otherwise copy the current line."
  (interactive)
  (if (use-region-p)
      (kill-ring-save (region-beginning) (region-end))
    (kill-ring-save (line-beginning-position) (line-end-position))
    (message "Line copied")))
(global-set-key (kbd "M-w") #'my/copy-line-or-region)
;; C-w cut the line without selection
(defun my/cut-line-or-region ()
  "Cut region if active, otherwise cut the entire current line."
  (interactive)
  (if (use-region-p)
      (kill-region (region-beginning) (region-end))
    (kill-region (line-beginning-position) (line-end-position))
    (message "Line cut")))
(global-set-key (kbd "C-w") #'my/cut-line-or-region)


;; switch focus to any new window:
(defadvice display-buffer (after select-new-window activate)
  "Automatically select newly created window."
  (when (window-live-p (get-buffer-window (ad-get-arg 0)))
    (select-window (get-buffer-window (ad-get-arg 0)))))

(setq desktop-save t)
(setq desktop-load-locked-desktop t)
(setq native-comp-deferred-compilation nil)

;; Collection of Ridiculously Useful eXtensions
(use-package crux
  :straight t
  :ensure t
  :config
      (global-set-key (kbd "C-a") 'crux-move-beginning-of-line)
       (global-set-key (kbd "C-o") 'crux-smart-open-line)
       ;; (global-set-key (kbd "C-x C-o") 'crux-other-window-or-switch-buffer)
       ;; (global-set-key (kbd "C-c C-l") 'crux-duplicate-current-line-or-region)
       (global-set-key (kbd "C-c C--") 'crux-kill-whole-line)
       (global-set-key (kbd "C-c ;") 'crux-duplicate-and-comment-current-line-or-region))

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
             :straight t
             :ensure t
             :config
             ;; (load-theme 'leuven-dark nil)
			 )

(use-package material-theme
             :straight t
             :ensure t
             :config
	     ;; (load-theme 'material-light t)
	     (load-theme 'material t)
	     )

(use-package powerline
             :straight t
             :ensure t
             :config
             (powerline-default-theme))


(use-package undo-tree
  :straight t
  :ensure t
  :init
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist
        `(("." . ,(expand-file-name "undo-tree-history" user-emacs-directory))))
  :config
  (global-undo-tree-mode)
  ;; Create undo history directory if it doesn't exist
  (unless (file-directory-p (expand-file-name "undo-tree-history" user-emacs-directory))
    (make-directory (expand-file-name "undo-tree-history" user-emacs-directory) t)))

(use-package markdown-mode
  :straight t
  :ensure t)


;; ;; To toggle the highlight of the symbol under the cursor in all buffers:
(use-package highlight-thing
             :straight t
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


(use-package expand-region
             :straight t
             :ensure t
             :config
             (global-set-key (kbd "C-=") 'er/expand-region))

;; ALT + Arrow Up and ALT + Arrow Down to move lines:
(use-package drag-stuff
             :straight t
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
             :straight t
             :ensure t
             :init
             (savehist-mode 1)
             (setq savehist-additional-variables '(command-history)))

(use-package eglot
  :straight t
  :ensure t
  ;; 2. **Install `clangd`**: Install `clangd` if you haven't already. You can install it using a package manager like `brew`, `apt`, or `choco`:
  ;; sudo apt install clangd
  ;; 3. **Configure Eglot for C++**: Add `clangd` to Eglot's configuration for C++ mode:
  :config
  (add-to-list 'eglot-server-programs '(c++-mode . ("clangd")))
  (add-to-list 'eglot-server-programs '(c-mode . ("clangd")))
  (add-to-list 'eglot-server-programs '(lua-mode . ("lua-language-server")))
  ;; 4. **Start Eglot**: Open a C++ file and start Eglot with `M-x eglot RET`. This will initialize `clangd` for your project.
  ;; 5. **Automatic Startup**: If you want Eglot to start automatically when you open a C++ file, add it to the major-mode hook:
  (add-hook 'c++-mode-hook 'eglot-ensure)
  (add-hook 'c-mode-hook 'eglot-ensure))
  ;; (add-hook 'lua-mode-hook 'eglot-ensure))
;; 6. **Project-Specific Configuration**: You can customize `clangd` using a `.dir-locals.el` file in your project directory:
;; ((c++-mode . ((eglot-workspace-configuration . (:clangd (:fallbackFlags ["-std=c++17"] :clangTidy (:checks ["*"] :clangdCheck :json-false))))))
;;  (c-mode . ((eglot-workspace-configuration . (:clangd (:fallbackFlags ["-std=c11"] :clangTidy (:checks ["*"] :clangdCheck :json-false))))))))
;; start eglot on buffers after restart !!
(add-hook 'emacs-startup-hook
  (lambda ()
    (dolist (buf (buffer-list))
      (with-current-buffer buf
        (when (and (or (derived-mode-p 'c-mode)
                       (derived-mode-p 'c++-mode)
                       (derived-mode-p 'lua-mode))
                   (not (eglot-current-server)))
          (eglot-ensure))))))
(with-eval-after-load 'eglot
  (define-key eglot-mode-map (kbd "M-m r") 'eglot-rename)
  (define-key eglot-mode-map (kbd "M-m o") 'eglot-code-action-organize-imports)
  (define-key eglot-mode-map (kbd "M-m h") 'eldoc)
  (define-key eglot-mode-map (kbd "M-m =") 'eglot-format)
  (define-key eglot-mode-map (kbd "M-m ?") 'xref-find-references)
  (define-key eglot-mode-map (kbd "M-.")   'xref-find-definitions))

;; Company Mode
(use-package company
  :straight t
  :init
  (global-company-mode)
  :config
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 1
        company-show-numbers t
        company-tooltip-align-annotations t)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection)
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous)))

;; Optionnel : snippets pour les complétions
(use-package yasnippet
  :straight t
  :init (yas-global-mode 1))

;; Optionnel : affichage visuel des complétions
(use-package company-box
  :straight t
  :hook (company-mode . company-box-mode))

;; ;; Run this interactively or add to your config
;; ;; (treesit-install-language-grammar 'c)
;; ;; (treesit-install-language-grammar 'cpp)
;; ;; Use Tree-sitter modes for C and C++
;; (setq major-mode-remap-alist
;;       '((c-mode          . c-ts-mode)
;;         (c++-mode        . c++-ts-mode)))
;; ;; Enable Tree-sitter highlighting
;; (add-hook 'c-ts-mode-hook #'treesit-font-lock-enable)
;; (add-hook 'c++-ts-mode-hook #'treesit-font-lock-enable)

; to see why c try each restart the grammar and no color in file ???
(use-package treesit-auto
  :straight t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))
;; Warning (treesit): Cannot activate tree-sitter, because language grammar for c is unavailable (version-mismatch): 15
(setq treesit-language-source-alist
      '((c         "https://github.com/tree-sitter/tree-sitter-c" "v0.20.3")  ;; 0.23.4
	;;(cpp       "https://github.com/tree-sitter/tree-sitter-cpp" "v0.23.4")  ;; 0.23.4
        (python    "https://github.com/tree-sitter/tree-sitter-python" "v0.20.4")
        (rust      "https://github.com/tree-sitter/tree-sitter-rust" "v0.20.1")
        (bash      "https://github.com/tree-sitter/tree-sitter-bash" "v0.19.0")))  ;; 0.22.0
        ;;(lua       "https://github.com/Azganoth/tree-sitter-lua" "v2.1.3")))
;; Then install each grammar
;; (dolist (lang '(c cpp python rust bash lua))
  ;; (treesit-install-language-grammar lang))
;; C-x C-e on(should have the same):
;; (treesit-language-abi-version)
;; (treesit-language-abi-version 'lua)
;; 13 (#o15, #xd, ?\C-m)
;; so version is 13


;; TBT, try to use project
(use-package project
  :init
  (setq project-vc-extra-root-markers '(".project")))


;; Magit
(use-package magit
             :straight t
             :ensure t
             :bind (("C-x g" . magit-status)
                    ("C-x M-g" . magit-dispatch)))
;; seems needed to have magit ok to find git
(eval-after-load 'tramp
                 '(setq magit-remote-git-executable "/usr/bin/git"))
;; magit-ediff-show-commit  : to see the diff of file as vscode
;; magit-log-buffer-file    : to see all previous commit for file

;; view git change in margin
(use-package git-gutter
             :straight t
             :ensure t
             :config
             (global-git-gutter-mode +1))

;; Install and configure Vertico
(use-package vertico
             :straight t
             :ensure t
             :init
             (vertico-mode)
             :config
	     (define-key vertico-map (kbd "DEL") #'vertico-directory-delete-word)
             :custom
             (vertico-resize t)  ;; Enable dynamic resizing
             (vertico-count 30)) ;; Number of candidates to show
(setq max-mini-window-height 0.5)  ;; max 50%
;; Optional enhancements
(use-package marginalia
             :straight t
             :ensure t
             :init
             (marginalia-mode))
(use-package orderless
             :straight t
             :ensure t
             :custom
             (completion-styles '(orderless basic))
             (completion-category-defaults nil)
             (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package consult
             :straight t
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

; (use-package deadgrep
;              :straight t
;              :ensure t
;              :init
;              :config
;              (global-set-key (kbd "<f5>") #'deadgrep))
;
; (use-package rg
;              :straight t
;              :ensure t
;              :init
;              :config
;              (rg-enable-default-bindings)) ;; C-c S
; (with-eval-after-load 'rg
;                       (advice-add 'rg-run :after
;                                   #'(lambda (_pattern _files _dir &optional _literal _confirm _flags) (pop-to-buffer (rg-buffer-name)))))

;; Install and configure which-key
(use-package which-key
             :straight t
             :ensure t
             :init
             :config
             (which-key-mode t)
             (which-key-enable-god-mode-support)
             (setq which-key-idle-delay 0.5))  ;; Adjust the delay as needed

;; ;; Install lua-mode
;; (use-package lua-mode
;;              :straight t
;;              :ensure t)
;; ;; Download love-minor-mode: Clone the love-minor-mode repository from GitHub.
;; ;; git clone https://github.com/ejmr/love-minor-mode.git ~/.emacs.d/love-minor-mode
;; ;; Load love-minor-mode
;; (add-to-list 'load-path "~/.emacs.d/love-minor-mode")
;; (require 'love-minor-mode)
;; ;; Enable love-minor-mode for lua-mode
;; (add-hook 'lua-mode-hook 'love-minor-mode)
;; (global-set-key (kbd "M-p") (lambda () (interactive) (shell-command "love .")))



;; multiple-cursors
;; C-g    To remove selection after multi-cursor creation
;; Install multiple-cursors
(use-package multiple-cursors
  :straight t
  :ensure t
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ;; ("C-<" . mc/mark-next-like-this)
         ;; ("C-M-<" . mc/skip-to-next-like-this)
         ("C-c C-d" . mc/skip-to-next-like-this)
         ;; ("C->" . mc/mark-previous-like-this)
         ;;("C-c C-<" . mc/mark-all-like-this)
         ("C-c C-a" . mc/mark-all-like-this)
         ))
(global-set-key (kbd "C-d") 'mc/mark-next-like-this)

;; French check for writing
;; sudo apt-get install aspell aspell-fr aspell-en
;; Enable Flyspell for text modes

; (add-hook 'text-mode-hook 'flyspell-mode)
; (setq ispell-program-name "aspell")
; (setq ispell-dictionary "francais")

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
             :straight t
             :ensure t
             :bind ("C-c t" . my-vterm)
             :config
             (setq vterm-size 80)
             (setq vterm-command "/bin/bash"))
(defun my-vterm ()
  "Open a new instance of vterm."
  (interactive)
  (vterm (generate-new-buffer-name "vterm")))

; (require 'org)
;; pomodoro
;; org-timer-set-timer
;; org-timer-pause-or-continue

;; IMAGE with ORG
;; Make sure your image link looks like this:
;; [[file:/path/to/image.png]]
;; Avoid adding a description inside the link (like `[[file:/path/to/image.png][desc]]`) unless you use a prefix when toggling.
;; C-c C-x C-v
;; This runs `org-toggle-inline-images`, which shows or hides images inline.
;; If your link includes a description, use:
;; C-u C-c C-x C-v
;; Add this to your Emacs config to always show images when opening `.org` files:
;; (setq org-startup-with-inline-images t)
;; If you're generating images dynamically (e.g., via code blocks), add this hook:
;; (add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)
;; You can control image size with:
;; (setq org-image-actual-width 300) ; or nil to use actual size

;; https://github.com/plantuml/plantuml/releases
;; To do plantuml
(org-babel-do-load-languages
 'org-babel-load-languages
 '((plantuml . t))) ; this line activates plantuml
(setq org-plantuml-jar-path (expand-file-name "/home/coyote/.emacs.d/.local/etc/plantuml.jar"))
;; Add this to your config to show images automatically:
(setq org-startup-with-inline-images t)
(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)
;; 1. Place your cursor inside the block and press:
;; C-c C-c
;; This runs the block and generates `hello.png`.
;; 2. If it doesn’t show automatically, press:
;; C-c C-x C-v
;; to toggle inline image display.
;; 3. ### ✅ Example Block Recap
;; ```org
;; #+BEGIN_SRC plantuml :file hello.png
;; @startuml
;; Bob -> Alice : hello
;; @enduml
;; #+END_SRC
;; ```

;; C-c C-o (org-open-at-point) Opens the link under the cursor. This works for URLs, files, headlines, and more.
;; RET (Enter key) — if configured You can make pressing Enter open links by adding this to your config:
(setq org-return-follows-link t)

;; To **decrease image size** and make it persistent, add this to your Emacs config (`init.el` or `.emacs`):
;; (setq org-image-actual-width 300)  ;; or any number of pixels you prefer
;; This controls the **maximum width** of displayed images. You can also use a list of widths:
;; (setq org-image-actual-width '(300))  ;; safer for Org's internal handling
;; If you want images to scale automatically to fit your window, you can use:
;; (setq org-image-actual-width nil)  ;; uses actual image size
;; After changing the setting, you can refresh the display with:
;; (org-display-inline-images)


; (use-package pulsar
;              :straight t
;              :ensure t
;              :config
;              (pulsar-global-mode 1))
; (add-hook 'minibuffer-setup-hook #'pulsar-pulse-line)

(winner-mode 1)  ;; winner-undo (C-c <left>) and winner-redo (C-c <right>)
;; add easier switch windows
(use-package switch-window
             :straight t
             :ensure t
             :config
             ;; (advice-add 'switch-window :after 'pulsar-pulse-line)

             (global-set-key (kbd "M-o") 'switch-window)

             ;; (global-set-key (kbd "C-c m") 'delete-other-windows)
             (global-set-key (kbd "C-c m") 'switch-window-then-maximize)

             ;; (global-set-key (kbd "C-c h") 'split-window-below)
             (global-set-key (kbd "C-c _") 'switch-window-then-split-below)

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

(use-package meow
  :straight t
  :ensure t)
(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . "H-j")
   '("k" . "H-k")
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . ignore)))
;; (require 'meow)
;; (meow-setup)
;; (meow-global-mode 1)

(custom-set-faces
 '(meow-normal-cursor ((t (:background "violet"))))
 '(meow-insert-cursor ((t (:background "red"))))
 '(meow-motion-cursor ((t (:background "green"))))
 '(meow-keypad-cursor ((t (:background "blue"))))
 '(meow-beacon-cursor ((t (:background "orange"))))
 )


;; Additional settings
;; (setq lsp-enable-snippet nil)  ;; Disable snippets if they cause issues
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-display-line-numbers-mode t)
 '(package-selected-packages nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight regular :height 90 :width normal)))))
