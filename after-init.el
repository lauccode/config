;;; File for exordium emacs in ~/.emacs.d

;; Projectile
(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map))
  :config
  (setq projectile-indexing-method 'alien)
  (setq projectile-enable-caching t)
  (setq projectile-git-command "git ls-files -zco --exclude-standard")
;;   (setq projectile-project-search-path '("~/projects/" "/ssh:remote:/path/to/projects/"))
  (projectile-discover-projects-in-search-path))
;; Exclude unnecessary files in .projectile
;; -/path/to/exclude
;; -*.log


;; Magit
(use-package magit
  :ensure t)
;;   :bind (("C-x g" . magit-status)
;;          ("C-x M-g" . magit-dispatch)))
;; seems needed to have magit ok to find git
(eval-after-load 'tramp
  '(setq magit-remote-git-executable "/usr/local/bin/git"))


;; Install Dumb Jump
(use-package dumb-jump
  :ensure t
;;   :bind (("M-g o" . dumb-jump-go-other-window)
;;          ("M-g j" . dumb-jump-go)
;;          ("M-g b" . dumb-jump-back)
;;          ("M-g q" . dumb-jump-quick-look))
  :config
  (setq dumb-jump-selector 'ivy)  ;; Use Ivy for selection interface
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

