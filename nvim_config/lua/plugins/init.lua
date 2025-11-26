return {
    'airblade/vim-gitgutter',
    {
      'andymass/vim-matchup', ---@type matchup.Config opts = {
        treesitter = {
          stopline = 500,
        }
    },
    'arkav/lualine-lsp-progress',
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

    'nvimtools/none-ls.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-lualine/lualine.nvim',

    'nvim-orgmode/orgmode',
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
