return {
  "epwalsh/obsidian.nvim", -- or markdown-todo.nvim
  -- Load only for Markdown buffers (optional, keeps things light)
  ft = "markdown",
  dependencies = { "nvim-lua/plenary.nvim" },
  -- ✅ Prevent errors when the path/vault doesn't exist
  enabled = function()
    local vault = "~/vaults/work"
    return vim.fn.isdirectory(vault) == 1
  end,
  opts = {
    workspaces = {
      {
        name = "work",
        path = "~/vaults/work",
      },
       },
  },
}
