;;; custom.el --- user customization file    -*- lexical-binding: t no-byte-compile: t -*-
;;; Commentary:
;;;       Add or change the configurations in custom.el, then restart Emacs.
;;;       Put your own configurations in custom-post.el to override default configurations.
;;; Code:

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
  :config (setq beacon-color "green"))

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
                            :background "#11ff33"))
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


;;███████ ███    ██ ██████  
;;██      ████   ██ ██   ██ 
;;█████   ██ ██  ██ ██   ██ 
;;██      ██  ██ ██ ██   ██ 
;;███████ ██   ████ ██████  

(setq centaur-logo nil)                        ; Logo file or nil (official logo)
;; (setq centaur-full-name "user name")           ; User full name
;; (setq centaur-mail-address "user@email.com")   ; Email address
;; (setq centaur-proxy "127.0.0.1:7890")          ; HTTP/HTTPS proxy
;; (setq centaur-socks-proxy "127.0.0.1:7890")    ; SOCKS proxy
;; (setq centaur-server nil)                      ; Enable `server-mode' or not: t or nil
;; (setq centaur-icon nil)                        ; Display icons or not: t or nil
(setq centaur-package-archives 'melpa)         ; Package repo: melpa, emacs-cn, bfsu, netease, sjtu, tencent, tuna or ustc
;; (setq centaur-theme 'auto)                     ; Color theme: auto, random, system, default, pro, dark, light, warm, cold, day or night
(setq centaur-completion-style 'minibuffer)    ; Completion display style: minibuffer or childframe
;; (setq centaur-dashboard nil)                   ; Display dashboard at startup or not: t or nil
;; (setq centaur-restore-frame-geometry nil)      ; Restore the frame's geometry at startup: t or nil
(setq centaur-lsp 'lsp-mode)                   ; Set LSP client: lsp-mode, eglot or nil
;; (setq centaur-lsp-format-on-save t)            ; Auto format buffers on save: t or nil
;; (setq centaur-lsp-format-on-save-ignore-modes '(c-mode c++-mode python-mode markdown-mode)) ; Ignore format on save for some languages
;; (setq centaur-tree-sitter nil)                 ; Enable tree-sitter or not: t or nil. Only available in 29+.
;; (setq centaur-chinese-calendar t)              ; Support Chinese calendar or not: t or nil
;; (setq centaur-player t)                        ; Enable players or not: t or nil
;; (setq centaur-prettify-symbols-alist nil)      ; Alist of symbol prettifications. Nil to use font supports ligatures.
;; (setq centaur-prettify-org-symbols-alist nil)  ; Alist of symbol prettifications for `org-mode'

;; For Emacs devel
;; (setq package-user-dir (locate-user-emacs-file (format "elpa-%s" emacs-major-version)))
;; (setq desktop-base-file-name (format ".emacs-%s.desktop" emacs-major-version))
;; (setq desktop-base-lock-name (format ".emacs-%s.desktop.lock" emacs-major-version))
;; to have dap-cpptools-setup, it will setup and install automatically for cpp

;; Fonts
(defun centaur-setup-fonts ()
  "Setup fonts."
  (when (display-graphic-p)
    ;; Set default font
    (cl-loop for font in '("Cascadia Code" "Fira Code" "Jetbrains Mono"
                           "SF Mono" "Hack" "Source Code Pro" "Menlo"
                           "Monaco" "DejaVu Sans Mono" "Consolas")
             when (font-installed-p font)
             return (set-face-attribute 'default nil
                                        :family font
                                        :height (cond (sys/macp 130)
                                                      (sys/win32p 110)
                                                      (t 100))))

    ;; Set mode-line font
    ;; (cl-loop for font in '("Menlo" "SF Pro Display" "Helvetica")
    ;;          when (font-installed-p font)
    ;;          return (progn
    ;;                   (set-face-attribute 'mode-line nil :family font :height 120)
    ;;                   (when (facep 'mode-line-active)
    ;;                     (set-face-attribute 'mode-line-active nil :family font :height 120))
    ;;                   (set-face-attribute 'mode-line-inactive nil :family font :height 120)))

    ;; Specify font for all unicode characters
    (cl-loop for font in '("Segoe UI Symbol" "Symbola" "Symbol")
             when (font-installed-p font)
             return (if (< emacs-major-version 27)
                        (set-fontset-font "fontset-default" 'unicode font nil 'prepend)
                      (set-fontset-font t 'symbol (font-spec :family font) nil 'prepend)))

    ;; Emoji
    (cl-loop for font in '("Noto Color Emoji" "Apple Color Emoji" "Segoe UI Emoji")
             when (font-installed-p font)
             return (cond
                     ((< emacs-major-version 27)
                      (set-fontset-font "fontset-default" 'unicode font nil 'prepend))
                     ((< emacs-major-version 28)
                      (set-fontset-font t 'symbol (font-spec :family font) nil 'prepend))
                     (t
                      (set-fontset-font t 'emoji (font-spec :family font) nil 'prepend))))

    ;; Specify font for Chinese characters
    (cl-loop for font in '("WenQuanYi Micro Hei" "PingFang SC" "Microsoft Yahei" "STFangsong")
             when (font-installed-p font)
             return (progn
                      (setq face-font-rescale-alist `((,font . 1.3)))
                      (set-fontset-font t '(#x4e00 . #x9fff) (font-spec :family font))))))

(centaur-setup-fonts)
(add-hook 'window-setup-hook #'centaur-setup-fonts)
(add-hook 'server-after-make-frame-hook #'centaur-setup-fonts)

;; Mail
;; (setq message-send-mail-function 'smtpmail-send-it
;;       smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;;       smtpmail-auth-credentials '(("smtp.gmail.com" 587
;;                                    user-mail-address nil))
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587)

;; Calendar
;; Set location , then press `S' can show the time of sunrise and sunset
;; (setq calendar-location-name "Chengdu"
;;       calendar-latitude 30.67
;;       calendar-longitude 104.07)

;; Misc.
;; (setq confirm-kill-emacs 'y-or-n-p)

;; Enable proxy
;; (proxy-http-enable)
;; (proxy-socks-enable)

;; Display on the specified monitor
;; (when (and (> (length (display-monitor-attributes-list)) 1)
;;            (> (display-pixel-width) 1920))
;;   (set-frame-parameter nil 'left 1920))

;; (put 'cl-destructuring-bind 'lisp-indent-function 'defun)
;; (put 'pdf-view-create-image 'lisp-indent-function 'defun)
;; (put 'treemacs-create-theme 'lisp-indent-function 'defun)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; custom.el ends here
