;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

(add-to-list 'default-frame-alist '(font . "JetBrains Mono-10"))
(add-to-list 'default-frame-alist '(line-spacing . 0.2))

;; (add-to-list 'default-frame-alist '(font . "Monoid 9"))  ;; OK
;; (add-to-list 'default-frame-alist '(line-spacing . 0.2))  ;; OK
;; (setq doom-font (font-spec :family "Monoid" :size 12 :weight 'regular))  ;; OK
;; (setq doom-font (font-spec :family "Monoid" :size 12 :weight 'bold))  ;; OK
      ;; doom-variable-pitch-font (font-spec :family "sans" :size 13))


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-dark+)
;; (setq doom-theme 'doom-dark)
;; (setq doom-theme 'doom-rouge)
;; (setq doom-theme 'doom-xcode)
;; (setq doom-theme 'doom-henna)
;; (setq doom-theme 'tsdh-dark)
(setq doom-theme 'doom-1337)
;; (load-theme 'alect-light t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; (use-package lsp-treemacs
;;   :custom
;;   (lsp-treemacs-sync-mode 1))

(setq find-name-arg "-iname")
(global-set-key (kbd "M-p") 'find-name-dired)
(global-set-key (kbd "M-*") 'rgrep)

;; (setq inhibit-eol-conversion t)

;; can solve issue with TRAMP / LSP !! 
;; (require 'tramp)
;; (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
;; (add-to-list 'tramp-remote-path "/path/of/clangd/") 

(use-package lsp-mode
  ;; :hook ((prog-mode . lsp-deferred))
  ;; :commands (lsp lsp-deferred)
  :config
  (progn
(lsp-register-client
    (make-lsp-client :new-connection (lsp-tramp-connection "clangd")
    ;; without tramp
    ;; (make-lsp-client :new-connection (lsp-stdio-connection "/path/to/clangd")

                     :major-modes '(c-mode c++-mode)
                     :priority 1
                     :remote? t
                     :server-id 'clangd-remote))))

(menu-bar-mode 1)
(tool-bar-mode 1)

(setq evil-escape-key-sequence "jj")

(set-default 'truncate-lines nil)

(setq global-whitespace-mode t)

;; (if (eq initial-window-system 'x)                 ; if started by emacs command or desktop file
;;     (toggle-frame-maximized)
;;   (toggle-frame-fullscreen))
;; Maximize first frame
(set-frame-parameter nil 'fullscreen 'maximized)

(setq confirm-kill-emacs nil)

;; scroll one line at a time (less "jumpy" than defaults)
    (setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
    (setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
    (setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
    (setq scroll-step 1) ;; keyboard scroll one line at a time

;; (setq fancy-splash-image "~/.doom.d/black-hole.png")
;; (setq fancy-splash-image "~/.doom.d/cute-doom.png")
;; (setq fancy-splash-image "~/.doom.d/doom-light.svg")
;; (setq fancy-splash-image "~/.doom.d/doom-color.jpg")

(after! lsp-ui
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-doc-show-with-mouse t))
