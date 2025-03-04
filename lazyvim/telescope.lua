
-- change some telescope options and a keymap to browse plugin files

return {
    {
        "nvim-telescope/telescope.nvim",
        keys = {
            {
                "<leader>G",
                ":lua require('telescope.builtin').live_grep({ additional_args = function() return {'--no-ignore-vcs', '--glob', '!.git/**'} end })<CR>",
                { noremap = true, silent = true, desc = "Find All Grep" }
            },
            {
                "<leader>F",
                ":Telescope find_files find_command=rg,--files,--hidden,--no-ignore,--iglob,!.git <CR>",
                { noremap = true, silent = true, desc = "Find All Files" }
            },


        },
    }
}
