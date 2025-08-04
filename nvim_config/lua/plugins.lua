return {
    'airblade/vim-gitgutter',
    'arkav/lualine-lsp-progress',
    require('my_avante_config'),

    'crispgm/nvim-tabline',

    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            "nvim-dap-ui"
          },
        },
    },
    {
        'folke/tokyonight.nvim',
        priority=1000,
        config = function()
            require('tokyonight').setup({style= "night", transparent = true})
            vim.cmd.colorscheme('tokyonight')
            vim.cmd("highlight ColorColumn ctermbg=0 guibg=LightYellow")
        end,
    },
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      ---@type Flash.Config
      opts = {},
      -- stylua: ignore
      keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      },
    },

    'imsnif/kdl.vim',
    'jpalardy/vim-slime',

    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',

    'mfussenegger/nvim-dap',
    {
        'mfussenegger/nvim-dap-python',
        dependencies = {"mfussenegger/nvim-dap"},
        config = function()
            require("dap-python").setup("python3")
        end
    },

    'neovim/nvim-lspconfig',

    'nvimtools/none-ls.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-lualine/lualine.nvim',
    'nvim-orgmode/orgmode',
    {
      "nvim-telescope/telescope.nvim",
      dependencies = {
        {
            "nvim-telescope/telescope-live-grep-args.nvim" ,
            -- This will not install any breaking changes.
            -- For major updates, this must be adjusted manually.
            version = "^1.0.0",
        },
      },
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
    },
    'nvim-tree/nvim-web-devicons',
    'nvim-tree/nvim-tree.lua',

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

    'stevearc/aerial.nvim',

    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
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

    -- You don't need to add packer itself since it's replaced by lazy.nvim
}
