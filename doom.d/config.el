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


;; to put in .bashrc with mobaXterm to have color theme 
;; export TERM=xterm-256color

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

;; to have horizontal bar on cursor
;; (setq global-hl-line-mode t)

;; (setq inhibit-eol-conversion t)

;; can solve issue with TRAMP / LSP !! 
;; (require 'tramp)
;; (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
;; (add-to-list 'tramp-remote-path "/path/of/clangd/") 

;; (use-package lsp-mode
;;   ;; :hook ((prog-mode . lsp-deferred))
;;   ;; :commands (lsp lsp-deferred)
;;   :config
;;  (progn
;; (lsp-register-client
;;     (make-lsp-client :new-connection (lsp-tramp-connection "clangd")
;;     ;; without tramp
;;     ;; (make-lsp-client :new-connection (lsp-stdio-connection "/path/to/clangd")
;; 
;;                      :major-modes '(c-mode c++-mode)
;;                      :priority 1
;;                      :remote? t
;;                      :server-id 'clangd-remote))))

;; .clangd
;; ---
;; CompileFlags:
;;     Add: [-isystem /usr/lib/llvm-13/lib/clang/13.0.1/include]


;; (setq lsp-clients-clangd-args '("-j=3"
;;                                 "--background-index"
;;                                 "--clang-tidy"
;;                                 "--completion-style=detailed"
;;                                 "--header-insertion=never"
;;                                 "--header-insertion-decorators=0"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))
;; option en plus
(after! lsp-ui
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-doc-show-with-mouse t))
;; Si besoin
(setq lsp-clients-clangd-args '("--log=verbose" "--query-driver=/usr/bin/c++" "--header-insertion=iwyu" "--background-index"))

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

;; (cmake-ide-setup)
;; (use-package cmake-mode
;;   :ensure t
;;   :mode
;;   ("CMakeLists\\.txt\\'" "\\.cmake\\'")
;;   )
;; (use-package cmake-font-lock
;;   :ensure t
;;   :after (cmake-mode)
;;   :hook (cmake-mode . cmake-font-lock-activate)
;;   )
;; ;; with cmake-ide
;; (setq ccls-sem-highlight-method 'font-lock)

;; To specify what M-x make uses for compilation, you specify the compile-command variable.
;; (setq compile-command "make -c /path/to/makefile")
;; For your GDB stuff, the variable is gud-gdb-command-name, so
;; (setq gud-gdb-command-name "gdb --anotate=3 -cd /path/to/exec")

;; gdb /docker:container_name:/path/to/bin -ex "set substitute-path /path/to/local/repo /path/to/docker/repo" -ex "handle SIGPIPE nostop" -f
;; gdb /docker:container_name:/path/to/bin -ex "set substitute-path /path/to/local/repo /path/to/docker/repo" -ex "handle SIGPIPE nostop"

;; to debug with DAP-MODE
(setq dap-auto-configure-mode t)
(require 'dap-cpptools)

;; To have config ready when launching dap-debug (also OK with launch.json) 
(with-eval-after-load 'dap-mode
(dap-register-debug-template
  "U2 Test Linux"
  (list :type "cppdbg"
        :request "launch"
        :name "cpptools::U2TestsLinux"
        :MIMode "gdb"
        :program "${workspaceFolder}/path/to/bin"
        :cwd "${workspaceFolder}")))

(map! :map dap-mode-map
      :leader
      :prefix ("d" . "dap")
      ;; basics
      :desc "dap next"          "n" #'dap-next
      :desc "dap step in"       "i" #'dap-step-in
      :desc "dap step out"      "o" #'dap-step-out
      :desc "dap continue"      "c" #'dap-continue
      :desc "dap hydra"         "h" #'dap-hydra
      :desc "dap debug restart" "r" #'dap-debug-restart
      :desc "dap debug"         "s" #'dap-debug

      ;; debug
      :prefix ("dd" . "Debug")
      :desc "dap debug recent"  "r" #'dap-debug-recent
      :desc "dap debug last"    "l" #'dap-debug-last

      ;; eval
      :prefix ("de" . "Eval")
      :desc "eval"                "e" #'dap-eval
      :desc "eval region"         "r" #'dap-eval-region
      :desc "eval thing at point" "s" #'dap-eval-thing-at-point
      :desc "add expression"      "a" #'dap-ui-expressions-add
      :desc "remove expression"   "d" #'dap-ui-expressions-remove

      :prefix ("db" . "Breakpoint")
      :desc "dap breakpoint toggle"      "b" #'dap-breakpoint-toggle
      :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
      :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
      :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message)


;; xterm mouse support
;; (require 'mouse)
;; (xterm-mouse-mode t)
(global-set-key (kbd "M-m") 'xterm-mouse-mode)

;;(require 'bitbake)
;; (add-to-list 'auto-mode-alist '("\\.bbappend\\'" . bitbake-mode))
;; (add-to-list 'auto-mode-alist '("\\.bb\\'" . bitbake-mode))
;; (add-to-list 'auto-mode-alist '("\\.inc$" . bitebake-mode))
;; (add-to-list 'auto-mode-alist '("\\.bbclass$" . bitebake-mode))
;; (add-to-list 'auto-mode-alist '("\\.conf$" . bitebake-mode))
;; (setq auto-mode-alist (cons '("\\.bb$" . bitbake-mode) auto-mode-alist))
;; (setq auto-mode-alist (cons '("\\.inc$" . bitbake-mode) auto-mode-alist))
;; (setq auto-mode-alist (cons '("\\.bbappend$" . bitbake-mode) auto-mode-alist))
;; (setq auto-mode-alist (cons '("\\.bbclass$" . bitbake-mode) auto-mode-alist))
;; (setq auto-mode-alist (cons '("\\.conf$" . bitbake-mode) auto-mode-alist))

