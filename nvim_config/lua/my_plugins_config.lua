return require('packer').startup(function(use)
    use 'arkav/lualine-lsp-progress'

    use 'christoomey/vim-tmux-navigator'

    use 'folke/neodev.nvim'
    use 'folke/tokyonight.nvim'

    use 'jpalardy/vim-slime'
    use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end}
    use 'junegunn/fzf.vim'

    use 'mhinz/vim-signify'

    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    -- For vsnip users.
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    use 'neovim/nvim-lspconfig'

    use 'jose-elias-alvarez/null-ls.nvim'

    use 'nvim-lua/plenary.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'nvim-orgmode/orgmode'
    use 'nvim-telescope/telescope.nvim'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-tree/nvim-tree.lua'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/nvim-treesitter-textobjects'

    use 'crispgm/nvim-tabline'

    use 'rafcamlet/nvim-luapad'

    use 'stevearc/aerial.nvim'

    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'tpope/vim-fugitive'
end)
