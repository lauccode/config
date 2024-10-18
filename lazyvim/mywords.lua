return {
  { "dwrdx/mywords.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
        vim.api.nvim_set_keymap('n', '<leader>a', ":lua require'mywords'.hl_toggle()<CR>", { noremap = true, silent = true,  desc= "Word hl toggle"}),
        vim.api.nvim_set_keymap('n', '<leader>r', ":lua require'mywords'.hl_toggle_regex()<CR>", { noremap = true, silent = true,  desc= "Regex Word hl toggle"}),
        vim.api.nvim_set_keymap('n', '<leader>A', ":lua require'mywords'.uhl_all()<CR>", { noremap = true, silent = true,  desc= "Word uhl toggle"}),
    },
  },
}
