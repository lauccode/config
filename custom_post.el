;; to have dap-cpptools-setup, it will setup and install automatically for cpp
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
