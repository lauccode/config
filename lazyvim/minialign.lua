 return {
  {
    "nvim-mini/mini.align",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.align").setup()
      -- Assure que `ga` appelle bien mini.align
      vim.keymap.set({ "n", "x" }, "ga", function()
        return MiniAlign.operator()
      end, { desc = "Align", expr = true })
    end,
  },
}
-- visual selection, "ga", give character to align
