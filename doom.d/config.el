;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; to add to .bashrc to have doom command everywhere
;; export PATH="$HOME/.emacs.d/bin:$PATH"

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
(setq doom-font (font-spec :family "Fira Mono" :size 12)
      doom-variable-pitch-font (font-spec :family "Fira Mono" :size 12)
      doom-unicode-font (font-spec :family "Fira Mono")
      doom-big-font (font-spec :family "Fira Mono" :size 18))

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
;; (setq doom-theme 'leuven-dark)
;; (load-theme 'alect-light t)

;; (when (eq window-system 'nil)
;;(custom-theme-set-faces! 'doom-dracula
  ;; 232/239
;; '(default :background "color-233")
;; '(default :background "black" :weight bold)
;; for selection
;; (region :background "color-201" :weight bold)))


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(setq display-line-numbers 'relative)

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
;; (global-set-key (kbd "M-*") 'rgrep)
(global-set-key (kbd "M-*") '+vertico/project-search)  ;; to have ripgrep preview for emacs in terminal
;; Switch entre cpp et h
(global-set-key (kbd "M-o") 'lsp-clangd-find-other-file) 
(global-set-key (kbd "M-;") 'evilnc-comment-or-uncomment-lines)

;;; Shortcut for muting search highlighting
(map! :leader
      :desc "remove highlight"          "l" #'evil-ex-nohighlight)

  (define-key evil-motion-state-map (kbd "M-h") #'evil-window-left)
  (define-key evil-motion-state-map (kbd "M-j") #'evil-window-down)
  (define-key evil-motion-state-map (kbd "M-k") #'evil-window-up)
  (define-key evil-motion-state-map (kbd "M-l") #'evil-window-right)

;; Shortcuts for GDB
(global-set-key (kbd "<f7>") 'gud-break)
(global-set-key (kbd "<f8>") 'gud-remove)
(global-set-key (kbd "<f5>") 'gud-cont)
(global-set-key (kbd "<f6>") 'gud-run)
(global-set-key (kbd "<f10>") 'gud-next)
(global-set-key (kbd "<f9>") 'gud-step)

;; (with-eval-after-load 'evil-maps
;;    (define-key evil-normal-state-map (kbd "f") 'evilem-motion-find-char)
;;    (define-key evil-normal-state-map (kbd "F") 'evilem-motion-find-char-backward))


;; to have horizontal bar on cursor
;; (setq global-hl-line-mode t)
;; (set-face-attribute hl-line-face nil :underline t)

;; disable hl line in visual mode
;; (add-hook 'evil-visual-state-entry-hook (lambda() (hl-line-mode -1)))
;; (add-hook 'evil-visual-state-exit-hook (lambda() (hl-line-mode +1)))

;; to have dracula theme ok with highlighting the line on cursor position with vertico
;; (use-package vertico
;;   :custom-face
;;   (vertico-current ((t (:background "#3a3f5a"))))
;;   :init
;;   (vertico-mode))

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

(setq evil-escape-key-sequence ",,")
  ;; Allow to escape from the visual state as from insert.
  (delete 'visual evil-escape-excluded-states)

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

;; build main SPC,c,c :
;; g++ -Wall -g -o main main.cpp

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

;; "args": ["-q"],
;; "stopAtEntry": false,
;; "environment": [],
;; "externalConsole": false,

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

;; show breakpoints with cpptools in terminal
(unless (display-graphic-p)
(set-face-background 'dap-ui-marker-face "green") ; An orange background for the line to execute
(set-face-attribute 'dap-ui-marker-face nil :inherit nil) ; Do not inherit other styles
(set-face-background 'dap-ui-pending-breakpoint-face "black") ; Blue background for breakpoints line
(set-face-attribute 'dap-ui-verified-breakpoint-face nil :inherit 'dap-ui-pending-breakpoint-face))

;; For realgud 
;;   (global-set-key (kbd "<f5>") 'gud-cont)
;;   (global-set-key (kbd "<f10>") 'gud-next)
;;   (global-set-key (kbd "<f11>") 'gud-step)
;;   (global-set-key (kbd "<f9>") 'gud-break)
;;   (global-set-key (kbd "<S-f9>") 'gud-remove)
;;   (global-set-key (kbd "<f12>") 'gud-print)
;;   (global-set-key (kbd "<S-f12>") 'gud-watch)


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

;; Merge conflict with magit :
;; S,g,g 	: open git status
;; e 	      : on unmerge file (so, with conflicts), to open ediff
;; 
;; In ediff windows, cursors is on the botton ! on “Type ? for help”
;; You need to change windows upper to modify in “C” windows.
;; And after come back in the windows “Type ? for help” to use ediff shortcuts.
;; 
;; In ediff :
;; a	: add A windows modifications in C windows
;; b	: add B windows modifications in C windows
;; +	: add A and B windows modifications in C windows
;; wc : save buffer
;; i	: infos


;; The default is to not sort files:
;; (setq projectile-sort-order 'default)
;; To sort files by recently opened:
(setq projectile-sort-order 'recentf)
;; To sort files by recently active buffers and then recently opened files:
;; (setq projectile-sort-order 'recently-active)
;; To sort files by modification time (mtime):
;; (setq projectile-sort-order 'modification-time)
;; To sort files by access time (atime):
;; (setq projectile-sort-order 'access-time)

;; To force the use of native indexing in all operating systems:
(setq projectile-indexing-method 'native)
;; To force the use of hybrid indexing in all operating systems:
;; (setq projectile-indexing-method 'hybrid)
;; To force the use of alien indexing in all operating systems: (native)
;; (setq projectile-indexing-method 'alien)

;; tree-sitter
(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; finer undo
(setq evil-want-fine-undo t)

;; clever expand from DOOM emacs developer
(map!
 (:map 'override
   :v "v" #'er/expand-region
   :v "V" #'er/contract-region))

;; next page of which-key => <C-h>  (all key in vertico)

(map! :n  "C-a"   #'evil-numbers/inc-at-pt
      :v  "C-a"   #'evil-numbers/inc-at-pt-incremental
      :v  "C-S-a" #'evil-numbers/inc-at-pt
      :n  "C-x"   #'evil-numbers/dec-at-pt
      :v  "C-x"   #'evil-numbers/dec-at-pt-incremental)

;; avoid "async shell command" buffer with run-love-game
;; (add-to-list 'display-buffer-alist '("^*Async Shell Command*" . (display-buffer-no-window)))
;; OR
(set 'async-shell-command-display-buffer nil)

;; emacsclient without new workspace :
;; emacsclient -c -e "(+workspace:delete)"
;; OR
(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override "main")
)

