;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Spartan.el Emacs General Settings
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TO COPY AT END OF REAL FILE:

;; path in title bar
(setq frame-title-format
      '(:eval (if buffer-file-name
                  (abbreviate-file-name buffer-file-name)
                "%b")))

;; C-x,=      To know cursor position
;; To always see your position in the mode line:
;; (size-indication-mode 1)

;; BASIC SETTINGS
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
;; (global-visual-line-mode 1)
;; Alternatively, enable it for specific modes
;; (add-hook 'text-mode-hook 'visual-line-mode)
;; (add-hook 'prog-mode-hook 'visual-line-mode)

;; M-% to replace
;; M-n recall word under cursor
;; C-x,n,n narrow-to-region
;; C-x,n,w widen, cancel narrow-to-region

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
;; (global-hl-line-mode 1)

;; Make the mouse wheel scroll one line at a time
;; C-SPC C-SPC to mark cursor position (set-mark-command x2)
;; scrool with mouse
;; C-u C-SPC to retrieve position
;; C-x C-SPC (or C-x C-@) to retrieve position if in another buffer (pop-global-mark)

;; (setq window-divider-default-places t)
;; (setq window-divider-default-bottom-width 1)
;; (setq window-divider-default-right-width 9) ;; Adjust this value as needed
;; (window-divider-mode 1)

;; Ensure `grep` and `rgrep` use `ripgrep`
;; (setq grep-program "rg")
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




(setq desktop-save t)
(setq desktop-load-locked-desktop t)
(setq native-comp-deferred-compilation nil)

;; (use-package boon
;;   :straight t
;;   :ensure t
;;   :config (boon-mode 0))

;; eval-last-sexp to know if tree sitter is OK: will return t
;; (featurep 'treesit)
;; (treesit-language-available-p 'lua)

(use-package doom-themes
  :straight t
  :ensure t
  :config
  (load-theme 'leuven-dark t))

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

;; Here's an example of aligning on the equal sign:
;; M-x align-regexp RET = RET

;; drag-stuff
;; ALT + Arrow Up and ALT + Arrow Down to move lines:
(use-package drag-stuff
  :straight t
  :ensure t
  :config
  (drag-stuff-global-mode 1)
  (global-set-key (kbd "M-<up>") 'drag-stuff-up)
  (global-set-key (kbd "M-<down>") 'drag-stuff-down))

(use-package savehist
  :straight t
  :ensure t
  :init
  (savehist-mode 1)
  (setq savehist-additional-variables '(command-history)))

;; (defun projectile-ripgrep-find-file-all ()
;;   "Find file in project, including those ignored by .gitignore using ripgrep."
;;   (interactive)
;;   (let ((projectile-generic-command "rg --files --hidden --no-ignore --glob '!.git/' -0"))
;;     (projectile-find-file)))
;; (define-key projectile-mode-map (kbd "C-c p G") 'projectile-ripgrep-find-file-all)

;; Git-gutter
;; view git change in margin
(use-package git-gutter
  :straight t
  :ensure t
  :config
  (global-git-gutter-mode +1))

;; which-key
;; Install and configure which-key
(use-package which-key
  :straight t
  :ensure t
  :init
  :config
  (which-key-mode t)
  (which-key-enable-god-mode-support)
  (setq which-key-idle-delay 0.5))  ;; Adjust the delay as needed








 ;; highlight-thing
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



;; Consult
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


;; deadgrep
(use-package deadgrep
  :straight t
  :ensure t
  :init
  :config
(global-set-key (kbd "<f5>") #'deadgrep))

;; rg
(use-package rg
  :straight t
  :ensure t
  :init
  :config
(rg-enable-default-bindings)) ;; C-c S
(with-eval-after-load 'rg
  (advice-add 'rg-run :after
              #'(lambda (_pattern _files _dir &optional _literal _confirm _flags) (pop-to-buffer (rg-buffer-name)))))


;; multiple-cursors
;; C-g    To remove selection after multi-cursor creation
;; Install multiple-cursors
(use-package multiple-cursors
  :straight t
  :ensure t
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C-<" . mc/mark-next-like-this)
         ("C-M-<" . mc/skip-to-next-like-this)
         ("C->" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))



;; switch-window
(winner-mode 1)  ;; winner-undo (C-c <left>) and winner-redo (C-c <right>)
   ;; add easier switch windows
   (use-package switch-window
     :straight t
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

