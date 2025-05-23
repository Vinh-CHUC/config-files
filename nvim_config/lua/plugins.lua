return {
    'airblade/vim-gitgutter',
    'arkav/lualine-lsp-progress',
    'crispgm/nvim-tabline',

    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
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

    'ggandor/leap.nvim',
    'imsnif/kdl.vim',
    'jpalardy/vim-slime',
    {
        'junegunn/fzf',
        build = function() vim.fn['fzf#install']() end
    },
    'junegunn/fzf.vim',

    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',

    'neovim/nvim-lspconfig',

    'nvimtools/none-ls.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-lualine/lualine.nvim',
    'nvim-orgmode/orgmode',
    'nvim-telescope/telescope.nvim',
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
