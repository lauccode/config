return {
{
  "nvim-orgmode/orgmode",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = "VeryLazy",
  config = function()
    require("orgmode").setup({
      org_agenda_files = {"~/org/**/*"},
      org_default_notes_file = "~/org/inbox.org",
    })
  end,
}
}
