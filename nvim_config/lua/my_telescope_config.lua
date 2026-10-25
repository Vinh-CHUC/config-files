local telescope = require('telescope')
local actions = require('telescope.actions')
local lga_actions = require("telescope-live-grep-args.actions")

telescope.setup {
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            -- define mappings, e.g.
            mappings = { -- extend mappings
                i = {
                    ["<C-k>"] = lga_actions.quote_prompt(),
                    ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                    -- freeze the current list and start a fuzzy search in the frozen list
                    ["<C-space>"] = actions.to_fuzzy_refine,
                },
            },
            -- ... also accepts theme settings, for example:
            -- theme = "dropdown", -- use dropdown theme
            -- theme = { }, -- use own theme spec
            -- layout_config = { mirror=true }, -- mirror preview pane
        }
    },
}
telescope.load_extension("fzf")
telescope.load_extension("live_grep_args")

local fd_all = {
    "fd", "--type", "file", "--hidden", "--no-ignore",
    "--ignore-file", os.getenv("HOME") .. "/.fdignore"
}
local fd_respect_ignore = { "fd", "--type", "file" }

-- <leader>h toggles between all files and respecting .gitignore/hidden, keeping the prompt
local function find_files(show_all, prompt)
    require("telescope.builtin").find_files {
        find_command = show_all and fd_all or fd_respect_ignore,
        prompt_title = (show_all and "Find Files (all)" or "Find Files (respect ignore)")
            .. "  [" .. vim.g.mapleader .. "h: toggle]",
        default_text = prompt,
        attach_mappings = function(_, map)
            map({ "i", "n" }, "<leader>h", function(prompt_bufnr)
                local text = require("telescope.actions.state").get_current_line()
                actions.close(prompt_bufnr)
                find_files(not show_all, text)
            end)
            return true
        end,
    }
end

vim.keymap.set("n", "<C-p>", function() find_files(true) end, {remap = false})
vim.keymap.set("n", "<leader>fr", ":Telescope lsp_references<cr>", {remap = false})
vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<cr>", {remap = false})
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<cr>", {remap = false})
