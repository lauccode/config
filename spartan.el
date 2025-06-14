;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Spartan.el Emacs General Settings
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TO COPY AT END OF REAL FILE:

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

(defun my-rgrep-word-at-point ()
  "Run rgrep with the word under the cursor and reuse the existing grep buffer window if open."
  (interactive)
  (let ((word (thing-at-point 'word t))
        (root-dir (project-root (project-current))))
    (rgrep word "*" root-dir)
    (let ((grep-buffer "*grep*"))
      (when (get-buffer grep-buffer)
        (let ((window (get-buffer-window grep-buffer)))
          (if window
              (select-window window) ;; Reuse the existing window showing the grep buffer
            (pop-to-buffer grep-buffer))))))) ;; Otherwise, show in the current window
(global-set-key (kbd "C-c g") 'my-rgrep-word-at-point)

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

;; select lines
(defun select-line-end ()
  "Select the current line and leave the cursor at the end of the line."
  (interactive)
  (end-of-line)
  (set-mark (line-beginning-position)))
(global-set-key (kbd "C-c l") 'select-line-end)
;; (global-set-key (kbd "C-c L") 'duplicate-line)  ;; "C-c C-l" with crux

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

(defun projectile-ripgrep-find-file-all ()
  "Find file in project, including those ignored by .gitignore using ripgrep."
  (interactive)
  (let ((projectile-generic-command "rg --files --hidden --no-ignore --glob '!.git/' -0"))
    (projectile-find-file)))
(define-key projectile-mode-map (kbd "C-c p G") 'projectile-ripgrep-find-file-all)

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


