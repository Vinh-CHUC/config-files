return {
    'airblade/vim-gitgutter',
    'arkav/lualine-lsp-progress',
    'crispgm/nvim-tabline',

    'folke/neodev.nvim',
    'folke/tokyonight.nvim',

    'ggandor/leap.nvim',
    'imsnif/kdl.vim',
    'jpalardy/vim-slime',
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
