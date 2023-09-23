;;; custom-post.el --- user customization file
;;; Commentary:
;;; post centaur configuration
;;; code:

(setq lsp-auto-guess-root t)

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

;; To have config ready when launching dap-debug
(with-eval-after-load 'dap-mode
  (dap-register-debug-template
   "cpptools::Run HELLO"
   (list :type "cppdbg"
         :request "launch"
         :name "cpptools::Run HELLO"
         :MIMode "gdb"
         :program "${workspaceFolder}/bin/greet"
         :cwd "${workspaceFolder}")))

;; (package-initialize)

;; ;; Bootstrap `use-package'
;; (unless (package-installed-p 'use-package)
;; (package-refresh-contents)
;; (package-install 'use-package))

;; (use-package beacon
;;   :ensure t
;;   :config (beacon-mode 1))

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

(use-package beacon
  :straight t
  :ensure t
  :config (beacon-mode 1)
  :config (setq beacon-color "orange"))

(use-package love-minor-mode :straight (love-minor-mode
                                        :type git
                                        :host github
                                        :repo "ejmr/love-minor-mode"
                                        :branch "master"))

;; ;; GOD-MODE
;; (use-package god-mode
;;   :straight t
;;   :ensure t
;;   :config (require 'god-mode)
;; (global-set-key (kbd "<escape>") #'god-local-mode)
;; ;; (global-set-key (kbd "<escape>") #'god-mode-all)

;; ;; ;; (custom-set-faces
;; ;; ;;  '(god-mode-lighter ((t (:inherit error)))))

;; ;; change cursor in line = no GOD MODE
;; (defun my-god-mode-update-cursor-type ()
;;   (setq cursor-type (if (or god-local-mode buffer-read-only) 'box 'bar)))
;; (add-hook 'post-command-hook #'my-god-mode-update-cursor-type)

;; ;; ;; change foreground and foreground for GOD-MODE
;; ;; (defun my-god-mode-update-mode-line ()
;; ;;   (cond
;; ;;    (god-local-mode
;; ;;     (set-face-attribute 'mode-line nil
;; ;;                         :foreground "black"
;; ;;                         :background "DarkGoldenrod3")
;; ;;     (set-face-attribute 'mode-line-inactive nil
;; ;;                         :foreground "gray"
;; ;;                         :background "goldenrod4"))
;; ;;    (t
;; ;;     (set-face-attribute 'mode-line nil
;; ;; 			            :foreground "LightGray"
;; ;; 			            :background "black")
;; ;;     (set-face-attribute 'mode-line-inactive nil
;; ;; 			            :foreground "gray"
;; ;; 			            :background "DimGray"))))
;; ;; (add-hook 'post-command-hook #'my-god-mode-update-mode-line)

;; (defun tsa/god-cursor ()
;;   (defvar tsa/cursor-bg (face-attribute 'cursor :background))

;;   (if (or god-local-mode buffer-read-only)
;;       (progn
;;         (setq cursor-type 'hbar)
;;         (set-face-attribute 'cursor nil
;;                             ;; :background "#11ff33"))
;;                             :background "orange"))
;;     (progn
;;       (setq cursor-type 'box)
;;       (set-face-attribute 'cursor nil
;;                           :background tsa/cursor-bg))))

;; (defun tsa/god-update-mode-line ()
;;   (defvar tsa/fg  (face-attribute 'mode-line :foreground))
;;   (defvar tsa/bg  (face-attribute 'mode-line :background))
;;   (defvar tsa/fgi (face-attribute 'mode-line-inactive :foreground))
;;   (defvar tsa/bgi (face-attribute 'mode-line-inactive :background))
;;   (cond
;;    (god-local-mode
;;     (set-face-attribute 'mode-line nil
;;                         :foreground "white"
;;                         :background "DarkGoldenrod4")
;;     (set-face-attribute 'mode-line-inactive nil
;;                         :foreground tsa/fgi
;;                         :background tsa/bgi))
;;    (t
;;     (set-face-attribute 'mode-line nil
;;                         :foreground tsa/fg
;;                         :background tsa/bg)
;;     (set-face-attribute 'mode-line-inactive nil
;;                         :foreground tsa/fgi
;;                         :background tsa/bgi))))

;; (defun tsa/reflect-god-mode ()
;;   "Make visual changes representing whether God is enabled"
;;   (interactive "P")
;;   (tsa/god-update-mode-line)
;;   (tsa/god-cursor))

;; (add-hook 'post-command-hook 'tsa/reflect-god-mode))
;; (setq god-mode-enable-function-key-translation nil)
;; (god-mode)
;; (add-to-list 'god-exempt-major-modes 'vterm-mode)

;; key binding for god-mode
(global-set-key (kbd "C-x C-1") #'delete-other-windows)
(global-set-key (kbd "C-x C-2") #'split-window-below)
(global-set-key (kbd "C-x C-3") #'split-window-right)
(global-set-key (kbd "C-x C-0") #'delete-window)

(menu-bar-mode t)
(tool-bar-mode t)

(use-package tabbar
  :init
  (setq tab-bar-show t))


;; ;; ;; define any dir as project with .project
;; (use-package project-x :straight (project-x
;;                                   :type git
;;                                   :host github
;;                                   :repo "karthink/project-x"
;;                                   :branch "master")
;;   :ensure t
;;   :load-path "~/project-x/"
;;   :after project
;;   :config
;;   (project-x-mode 1)  
;;   (setq project-x-save-interval 600))    ;Save project state every 10 min
;; (require 'project-x)
;; To not use project-x
(use-package project
  :init
  (setq project-vc-extra-root-markers '(".project")))

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
(require 'meow)
(meow-setup)
(meow-global-mode 1)

(custom-set-faces
 '(meow-normal-cursor ((t (:background "violet"))))
 '(meow-insert-cursor ((t (:background "red"))))
 '(meow-motion-cursor ((t (:background "green"))))
 '(meow-keypad-cursor ((t (:background "blue"))))
 '(meow-beacon-cursor ((t (:background "orange"))))
 )

;;; custom-post.el --- user customization file
;;; Commentary:
;;; post centaur configuration
;;; code:

(setq lsp-auto-guess-root t)

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

;; To have config ready when launching dap-debug
(with-eval-after-load 'dap-mode
  (dap-register-debug-template
   "cpptools::Run HELLO"
   (list :type "cppdbg"
         :request "launch"
         :name "cpptools::Run HELLO"
         :MIMode "gdb"
         :program "${workspaceFolder}/bin/greet"
         :cwd "${workspaceFolder}")))

;; (package-initialize)

;; ;; Bootstrap `use-package'
;; (unless (package-installed-p 'use-package)
;; (package-refresh-contents)
;; (package-install 'use-package))

;; (use-package beacon
;;   :ensure t
;;   :config (beacon-mode 1))

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

(use-package beacon
  :straight t
  :ensure t
  :config (beacon-mode 1)
  :config (setq beacon-color "orange"))

(use-package love-minor-mode :straight (love-minor-mode
                                        :type git
                                        :host github
                                        :repo "ejmr/love-minor-mode"
                                        :branch "master"))

;; ;; GOD-MODE
;; (use-package god-mode
;;   :straight t
;;   :ensure t
;;   :config (require 'god-mode)
;; (global-set-key (kbd "<escape>") #'god-local-mode)
;; ;; (global-set-key (kbd "<escape>") #'god-mode-all)

;; ;; ;; (custom-set-faces
;; ;; ;;  '(god-mode-lighter ((t (:inherit error)))))

;; ;; change cursor in line = no GOD MODE
;; (defun my-god-mode-update-cursor-type ()
;;   (setq cursor-type (if (or god-local-mode buffer-read-only) 'box 'bar)))
;; (add-hook 'post-command-hook #'my-god-mode-update-cursor-type)

;; ;; ;; change foreground and foreground for GOD-MODE
;; ;; (defun my-god-mode-update-mode-line ()
;; ;;   (cond
;; ;;    (god-local-mode
;; ;;     (set-face-attribute 'mode-line nil
;; ;;                         :foreground "black"
;; ;;                         :background "DarkGoldenrod3")
;; ;;     (set-face-attribute 'mode-line-inactive nil
;; ;;                         :foreground "gray"
;; ;;                         :background "goldenrod4"))
;; ;;    (t
;; ;;     (set-face-attribute 'mode-line nil
;; ;; 			            :foreground "LightGray"
;; ;; 			            :background "black")
;; ;;     (set-face-attribute 'mode-line-inactive nil
;; ;; 			            :foreground "gray"
;; ;; 			            :background "DimGray"))))
;; ;; (add-hook 'post-command-hook #'my-god-mode-update-mode-line)

;; (defun tsa/god-cursor ()
;;   (defvar tsa/cursor-bg (face-attribute 'cursor :background))

;;   (if (or god-local-mode buffer-read-only)
;;       (progn
;;         (setq cursor-type 'hbar)
;;         (set-face-attribute 'cursor nil
;;                             ;; :background "#11ff33"))
;;                             :background "orange"))
;;     (progn
;;       (setq cursor-type 'box)
;;       (set-face-attribute 'cursor nil
;;                           :background tsa/cursor-bg))))

;; (defun tsa/god-update-mode-line ()
;;   (defvar tsa/fg  (face-attribute 'mode-line :foreground))
;;   (defvar tsa/bg  (face-attribute 'mode-line :background))
;;   (defvar tsa/fgi (face-attribute 'mode-line-inactive :foreground))
;;   (defvar tsa/bgi (face-attribute 'mode-line-inactive :background))
;;   (cond
;;    (god-local-mode
;;     (set-face-attribute 'mode-line nil
;;                         :foreground "white"
;;                         :background "DarkGoldenrod4")
;;     (set-face-attribute 'mode-line-inactive nil
;;                         :foreground tsa/fgi
;;                         :background tsa/bgi))
;;    (t
;;     (set-face-attribute 'mode-line nil
;;                         :foreground tsa/fg
;;                         :background tsa/bg)
;;     (set-face-attribute 'mode-line-inactive nil
;;                         :foreground tsa/fgi
;;                         :background tsa/bgi))))

;; (defun tsa/reflect-god-mode ()
;;   "Make visual changes representing whether God is enabled"
;;   (interactive "P")
;;   (tsa/god-update-mode-line)
;;   (tsa/god-cursor))

;; (add-hook 'post-command-hook 'tsa/reflect-god-mode))
;; (setq god-mode-enable-function-key-translation nil)
;; (god-mode)
;; (add-to-list 'god-exempt-major-modes 'vterm-mode)

;; key binding for god-mode
(global-set-key (kbd "C-x C-1") #'delete-other-windows)
(global-set-key (kbd "C-x C-2") #'split-window-below)
(global-set-key (kbd "C-x C-3") #'split-window-right)
(global-set-key (kbd "C-x C-0") #'delete-window)

(menu-bar-mode t)
(tool-bar-mode t)

(use-package tabbar
  :init
  (setq tab-bar-show t))


;; ;; ;; define any dir as project with .project
;; (use-package project-x :straight (project-x
;;                                   :type git
;;                                   :host github
;;                                   :repo "karthink/project-x"
;;                                   :branch "master")
;;   :ensure t
;;   :load-path "~/project-x/"
;;   :after project
;;   :config
;;   (project-x-mode 1)  
;;   (setq project-x-save-interval 600))    ;Save project state every 10 min
;; (require 'project-x)
;; To not use project-x
(use-package project
  :init
  (setq project-vc-extra-root-markers '(".project")))

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
(require 'meow)
(meow-setup)
(meow-global-mode 1)

(custom-set-faces
 '(meow-normal-cursor ((t (:background "violet"))))
 '(meow-insert-cursor ((t (:background "red"))))
 '(meow-motion-cursor ((t (:background "green"))))
 '(meow-keypad-cursor ((t (:background "blue"))))
 '(meow-beacon-cursor ((t (:background "orange"))))
 )

(use-package zoom-window
  :straight t
  :ensure t
  :bind ("C-x C-z" . zoom-window-zoom)
  :custom
  (zoom-window-mode-line-color "DarkGreen"))

;; (use-package projectile
;;   :straight t
;;   :ensure t)
;; (projectile-mode +1)
;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;;; custom-post.el ends here
