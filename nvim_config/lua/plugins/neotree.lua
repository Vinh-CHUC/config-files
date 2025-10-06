return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false,                      -- neo-tree will lazily load itself
    ---@module 'neo-tree'
    ---@type neotree.Config
    opts = {
        window = {
            mappings = {
                ["<C-x>"] = "open_split",
                ["<C-v>"] = "open_vsplit",
                ["<C-t>"] = "open_tabnew",
            },
        },
        filesystem = {
            follow_current_file = {
                enabled = true, -- This will automatically reveal the active file
                leave_dirs_open = true
            },
            filtered_items = {
                always_show_by_pattern = {
                    ".github", -- always show its contents
                    ".gitignore",
                    ".envrc",
                    ".env"
                },
            }
        },
    }
}
