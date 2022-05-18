"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ffs=unix,dos,mac "Default file types
set wildignore+=*/build/* "Is also used by CtrlP

" Tabline always visible
set showtabline=2
set clipboard=unnamed,unnamedplus

let mapleader = "["
let maplocalleader = "["
nnoremap  <leader>ev :vsplit $MYVIMRC<cr>
nnoremap  <leader>sv :source $MYVIMRC<cr>

if exists("+showtabline")
     function MyTabLine()
         let s = ''
         let cur_tab_n = tabpagenr()

         for tab_idx in range(tabpagenr('$'))
             let buflist = tabpagebuflist(tab_idx + 1)
             let winnr = tabpagewinnr(tab_idx + 1)

             let filename = bufname(buflist[winnr - 1])
             let filename = fnamemodify(filename, ':p:t')
             if filename == ''
                 let filename = '[No Name]'
             endif

             " Tab page number
             let s .= '%' . (tab_idx + 1) . 'T'
             let s .= ((tab_idx + 1) == cur_tab_n ? '%1*' : '%2*')
             let s .= ' '
             let s .= (tab_idx + 1) . '|'
             let s .= ' %*'

             " Highlight if current tab
             let s .= ((tab_idx + 1) == cur_tab_n ? '%#TabLineSel#' : '%#TabLine#')

             " Filename
             let s .= filename

             " Some padding at the end
             let s .= '  '
         endfor
         let s .= '%T%#TabLineFill#%='
         let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
         return s
     endfunction
     set stal=2
     set tabline=%!MyTabLine()
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Minimum amount of screen lines above or below the cursor
set scrolloff=16
set cmdheight=2 "The commandbar height
set number

""""""""
" Search
""""""""
set ignorecase "Case unsensitive search
set smartcase "Make it sensitive if the search pattern contains upper case characters

set nolazyredraw "Do redraw during macros :)

set showmatch "Show matching bracets when cursor is on them
set matchtime=2 "For 0.2 seconds

set timeoutlen=200
set foldcolumn=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colours and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable

set background=dark
colorscheme desert

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files,backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, write to your files often !! Use Git !!
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text,tab,indent
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Converts TAB to spaces
set expandtab 
"How many spaces for (auto)indent
set shiftwidth=4 " << >> 
set tabstop=4 "The actual tab key
set softtabstop=4 "How many characters does a tab count for 
set smartindent "Guesses for indents when using t a C like language

set textwidth=99
set colorcolumn=+1

"Automatic word wrapping
set wrap
set linebreak "Do not break in a middle of a word (this is only visual)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap jk <Esc>

nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

map <right> gt
map <left> gT

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.local/share/nvim/plugged')
    Plug 'christoomey/vim-tmux-navigator'

    Plug 'jpalardy/vim-slime'
    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() }}
    Plug 'junegunn/fzf.vim'

    Plug 'mhinz/vim-signify'

    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}
    Plug 'nvim-treesitter/nvim-treesitter'

    Plug 'preservim/nerdtree'

    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'

    Plug 'vim-airline/vim-airline'
call plug#end()

" Telescope
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>fr <cmd>Telescope lsp_references<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" NERDTree
" Mirror the NERDTree before showing it. This makes it the same on all tabs.
nnoremap <C-n> :NERDTreeToggle<CR>

" Signify
cnoreabbrev Diff SignifyDiff

" Slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_dont_ask_default = 1
let g:slime_python_ipython = 1
xmap ff <Plug>SlimeRegionSend
nmap ff <Plug>SlimeParagraphSend

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lua
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua << EOF
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
require("telescope").load_extension("fzf")

-------------------
-- NVIM LSP BEGIN -
-------------------
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local servers = { "erlangls", "pyre", "pylsp", "hhvm"}
for _, lsp in ipairs(servers) do
  require("lspconfig")[lsp].setup {
    on_attach = on_attach,
  }
end

------------------
-- NVIM LSP END --
------------------
EOF
