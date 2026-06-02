return {
    'airblade/vim-gitgutter',
    {
      'andymass/vim-matchup', ---@type matchup.Config opts = {
        treesitter = {
          stopline = 500,
        }
    },
    'arkav/lualine-lsp-progress',

    {
        "cbochs/grapple.nvim",
        opts = {
            scope = "git_branch", -- also try out "git_branch"
        },
        event = { "BufReadPost", "BufNewFile" },
        cmd = "Grapple",
        keys = {
            { "<leader>m", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle tag" },
            { "<leader>M", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },
        },
    },

    'imsnif/kdl.vim',
    {
      'Julian/lean.nvim',
      event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

      dependencies = {
        'nvim-lua/plenary.nvim',

        -- optional dependencies:

        -- a completion engine
        --    hrsh7th/nvim-cmp or Saghen/blink.cmp are popular choices

        -- 'nvim-telescope/telescope.nvim', -- for 2 Lean-specific pickers
        -- 'andymass/vim-matchup',          -- for enhanced % motion behavior
        -- 'andrewradev/switch.vim',        -- for switch support
        -- 'tomtom/tcomment_vim',           -- for commenting
      },

      ---@type lean.Config
      opts = { -- see below for full configuration options
        mappings = true,
      }
    },

    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
    {
        'kosayoda/nvim-lightbulb',
        config = function()
            require("nvim-lightbulb").setup({
              autocmd = { enabled = true }
            })
        end
    },
    'mfussenegger/nvim-dap',
    {
        'mfussenegger/nvim-dap-python',
        dependencies = {"mfussenegger/nvim-dap"},
        config = function()
            require("dap-python").setup("python3")
        end
    },
    -- For some reason configuring lazily seems buggy?
    'nanozuki/tabby.nvim',

    'neovim/nvim-lspconfig',

    {
      "nickjvandyke/opencode.nvim",
      version = "*", -- Latest stable release
      dependencies = {
        {
          -- `snacks.nvim` integration is recommended, but optional
          ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
          "folke/snacks.nvim",
          optional = true,
          opts = {
            input = {}, -- Enhances `ask()`
            picker = { -- Enhances `select()`
              actions = {
                opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
              },
              win = {
                input = {
                  keys = {
                    ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                  },
                },
              },
            },
          },
        },
      },
      config = function()
        ---@type opencode.Opts
        vim.g.opencode_opts = {
        }

        vim.o.autoread = true -- Required for `opts.events.reload`

        -- Recommended/example keymaps
        vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode…" })
        vim.keymap.set({ "n", "x" }, "<leader>ox", function() require("opencode").select() end,                          { desc = "Execute opencode action…" })
        vim.keymap.set({ "n", "t" }, "<leader>ot", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })

        vim.keymap.set({ "n", "x" }, "<leader>or",  function() return require("opencode").operator("@this ") end,        { desc = "Add range to opencode", expr = true })
        vim.keymap.set("n",          "<leader>ol", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })

        vim.keymap.set("n", "<leader>osu", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll opencode up" })
        vim.keymap.set("n", "<leader>osd", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })
      end,
    },

    'nvimtools/none-ls.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-lualine/lualine.nvim',

    'nvim-tree/nvim-web-devicons',

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
    },
    'nvim-treesitter/nvim-treesitter-textobjects',
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
        config = function()
            require('dapui').setup()
            local dap, dapui = require('dap'), require('dapui')
            --
            -- Auto-open/close dapui when debugging starts/ends
            dap.listeners.after.event_initialized['dapui_config'] = function()
              dapui.open()
            end
            dap.listeners.before.event_terminated['dapui_config'] = function()
              dapui.close()
            end
            dap.listeners.before.event_exited['dapui_config'] = function()
                dapui.close()
            end
        end
    },
    'rafcamlet/nvim-luapad',
    {
        "rmagatti/auto-session",
        lazy = false,
        ---@module "auto-session"
        ---@type AutoSession.Config
        opts = {
            suppressed_dirs = { "~/", "~/Downloads"},
        },
    },
    {
        'sindrets/diffview.nvim',
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        init = function()
            vim.api.nvim_create_user_command('Dvo', 'DiffviewOpen <args>', { nargs = '*' })
            vim.api.nvim_create_user_command('Dvh', 'DiffviewFileHistory <args>', { nargs = '*' })
        end,
        opts = {},
    },
    'tpope/vim-commentary',
    'tpope/vim-surround',
    'tpope/vim-fugitive',
    {
        'Vinh-CHUC/Navigator.nvim',
        config = function()
            require('Navigator').setup()
        end,
    },
}
