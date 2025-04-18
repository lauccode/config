;;;;;;;;;;;;;  PRELOAD ;;;;;;;;;;;;;;
;; in .emacs.d/personal/preload/myconf.el
;; (disable-theme 'zenburn)
;;;; (setq prelude-theme 'tango-dark)
;;;; (setq prelude-theme 'tsdh-dark)
;; (setq prelude-theme 'gruvbox)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (prelude-require-package 'beacon)
;; ;; +personalisation
;; (beacon-mode 1)

(toggle-frame-maximized )
(toggle-frame-fullscreen)
(desktop-save-mode 1)
(xterm-mouse-mode 1)
;; (global-set-key (kbd "C-c h") 'lsp-clangd-find-other-file)
(global-set-key (kbd "C-c h") 'ff-find-other-file)
;; (global-set-key (kbd "C-c h") 'ff-find-other-file-other-window)
(global-set-key (kbd "<f9>") 'restart-emacs)
(setq prelude-whitespace nil) ;; remove change color 80 chars

(require 'tramp)
(setq tramp-default-method "ssh")
(projectile-mode +1)
;; (setq projectile-project-search-path '("~/remote-projects/"))

(use-package consult
  :ensure t
  :bind (("C-c C-f" . consult-ripgrep)          ; WORK
         ("C-c C-g" . my/consult-ripgrep-all))  ; WORK
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


;; THEMES
; (prelude-require-package 'github-dark-dimmed-theme)
(prelude-require-package 'cyanometric-theme)
; (prelude-require-package 'catppuccin-theme)
; (prelude-require-package 'dracula-theme)  ;; shouldo work
; (prelude-require-package 'doom-themes)  ;; should work
(prelude-require-package 'darktooth-theme)
; (prelude-require-package 'solarized-theme)  ;; should work
(prelude-require-package 'gruvbox-theme)  ;; should work
(prelude-require-package 'nano-theme)
; (prelude-require-package 'nord-theme)
; (prelude-require-package 'ef-themes)
(prelude-require-package 'kaolin-themes)
; (prelude-require-package 'modus-themes)
; (prelude-require-package 'apropospriate-theme)

(prelude-require-package 'vterm)

;; LSP
;;;;;;
;; Assurez-vous que lsp-mode est installé
(require 'lsp-mode)
;; Activer lsp-mode automatiquement pour les fichiers C++
(add-hook 'c++-mode-hook #'lsp)
;; ;; More lsp options
;; (after! lsp-clangd (set-lsp-priority! 'clangd 2))
;; ;; Si besoin
;; (setq lsp-clients-clangd-args '("--log=verbose" "--query-driver=/usr/bin/c++" "--header-insertion=iwyu" "--background-index"))
;; ;; option en plus
;; (after! lsp-ui
;;         (setq lsp-ui-doc-enable t)
;;         (setq lsp-ui-doc-show-with-mouse t))
(global-unset-key (kbd "s-l"))
(use-package lsp-mode
  :commands lsp
  :init
  (setq lsp-keymap-prefix "C-c C-l")
  :config
  (define-key lsp-mode-map (kbd "C-c C-l") lsp-command-map)
  :hook (lsp-mode . lsp-enable-which-key-integration))
(prelude-require-package 'lsp-treemacs)  ;; to have call hierarchy
(use-package lsp-treemacs
  :after lsp)

;; TREE SITTER
(prelude-require-package 'tree-sitter)
(prelude-require-package 'tree-sitter-langs)
(require 'tree-sitter)
(require 'tree-sitter-langs)
(add-hook 'prog-mode-hook #'tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

;; MULTI CURSOR
; (prelude-require-package 'multiple-cursors) 
; (require 'multiple-cursors) 
; ;; When you have an active region that spans multiple lines, the following will add a cursor to each line:
; (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines) 
; ;; When you want to add multiple cursors not based on continuous lines, but based on keywords in the buffer, use:
; (global-set-key (kbd "C->") 'mc/mark-next-like-this) 
; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this) 
; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(prelude-require-package 'meow)
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
(require 'meow)
(meow-setup)
(meow-global-mode 1)

(global-set-key (kbd "M-p") (lambda () (interactive) (shell-command "love .")))


