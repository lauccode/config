return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  { "savq/melange-nvim"   },
  { "NLKNguyen/papercolor-theme" },
  { "overcache/NeoSolarized" },


  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
