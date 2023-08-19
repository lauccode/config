;;; custom-post.el --- user customization file
;;; Commentary:
;;; post centaur configuration

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
(use-package god-mode
  :straight t
  :ensure t)
(global-set-key (kbd "<escape>") #'god-local-mode)
;; (global-set-key (kbd "<escape>") #'god-mode-all)
(setq god-mode-enable-function-key-translation nil)
(require 'god-mode)

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
                        :background "DarkGoldenrod4")
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

(add-hook 'post-command-hook 'tsa/reflect-god-mode)

;; key binding for god-mode
(global-set-key (kbd "C-x C-1") #'delete-other-windows)
(global-set-key (kbd "C-x C-2") #'split-window-below)
(global-set-key (kbd "C-x C-3") #'split-window-right)
(global-set-key (kbd "C-x C-0") #'delete-window)

(menu-bar-mode t)
(setq tab-bar-show t)

;; ;; define any dir as project with .project
(use-package project-x :straight (project-x
                                  :type git
                                  :host github
                                  :repo "karthink/project-x"
                                  :branch "master")
  :ensure t
  :load-path "~/project-x/"
  :after project
  :config
  (project-x-mode 1)  
  (setq project-x-save-interval 600))    ;Save project state every 10 min
(require 'project-x)
;; To not use project-x
;; (use-package project
;;   :init
;;   (setq project-vc-extra-root-markers '(".project")))



;;; custom-post.el ends here
