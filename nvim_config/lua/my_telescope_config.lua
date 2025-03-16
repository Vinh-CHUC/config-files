local telescope = require('telescope')
local actions = require('telescope.actions')
telescope.setup {
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    },
    pickers = {
        buffers = {
            mappings = {
                i = { ["<CR>"] = actions.select_tab_drop }
            }
        },
        find_files = {
            mappings = {
                i = { ["<CR>"] = actions.select_tab_drop },
            },
            find_command = {
                "fd", "--type", "file", "--hidden", "--no-ignore",
                "--ignore-file", os.getenv("HOME") .. "/.fdignore"
            }
        },
        git_files = {
            mappings = {
                i = { ["<CR>"] = actions.select_tab_drop }
            }
        },
        old_files = {
            mappings = {
                i = { ["<CR>"] = actions.select_tab_drop }
            }
        }
    }
}
telescope.load_extension("fzf")

vim.keymap.set("n", "<C-p>", ":Telescope find_files<cr>", {remap = false})
vim.keymap.set("n", "<leader>fr", ":Telescope lsp_references<cr>", {remap = false})
vim.keymap.set("n", "<leader>g", ":Telescope live_grep<cr>", {remap = false})
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<cr>", {remap = false})
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<cr>", {remap = false})
