"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocp
set history=700

filetype plugin on
filetype indent on

set ffs=unix,dos,mac "Default file types
set wildignore+=*/build/* "Is also used by CtrlP

" Tabline always visible
set showtabline=2
set clipboard=unnamed,unnamedplus
" Status line always visible
set laststatus=2

let mapleader = "["
let localleader = "["
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Minimum amount of screen lines above or below the cursor
set scrolloff=16
set ruler "Always show current position
set wildmenu "Turn on Wild menu
set cmdheight=2 "The commandbar height
set number

" Set backspace config
set backspace=eol,start,indent

""""""""
" Search
""""""""
set ignorecase "Case unsensitive search
set smartcase "Make it sensitive if the search pattern contains upper case characters
set hlsearch
set incsearch "Show matches as search pattern is being typed

set nolazyredraw "Do redraw during macros :)

set showmatch "Show matching bracets when cursor is on them
set matchtime=2 "For 0.2 seconds

set timeoutlen=200
set foldcolumn=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colours and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable

set t_Co=256
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
set autoindent "Copy current line indent to subsequent new line

set textwidth=99
set colorcolumn=+1

"Automatic word wrapping
set wrap
set linebreak "Do not break in a middle of a word (this is only visual)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap jk <Esc>

noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

map <right> gt
map <left> gT

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')
    Plug 'dense-analysis/ale'

    Plug 'hhvm/vim-hack'

    Plug 'jpalardy/vim-slime'

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    Plug 'mhinz/vim-signify'

    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    Plug 'preservim/nerdtree'

    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'

    Plug 'vim-airline/vim-airline'
call plug#end()

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(
    \   <q-args>,
    \   fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" NERDTree
" Mirror the NERDTree before showing it. This makes it the same on all tabs.
nnoremap <C-n> :NERDTreeToggle<CR>

" CtrlP
nnoremap <silent> <C-p> :Files<CR>

" Signify
cnoreabbrev Diff SignifyDiff

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_section_c = '%f'

" Slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": ":.1"}
let g:slime_dont_ask_default = 1
let g:slime_python_ipython = 1
xmap ff <Plug>SlimeRegionSend
nmap ff <Plug>SlimeParagraphSend

" ALE
let g:ale_completion_enabled = 1
let g:ale_echo_msg_format = '[%linter%]% [code]% %s'
let g:ale_linters = {'hack': ['hack']}
let g:ale_fixers = {'hack': ['hackfmt']}
set omnifunc=ale#completion#OmniFunc
" Press `K` to view the type in the gutter
nnoremap <silent> K :ALEHover<CR>
" Type `gd` to go to definition
nnoremap <silent> gd :ALEGoToDefinition<CR>
