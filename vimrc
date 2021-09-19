"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocp
set history=700

filetype plugin on
filetype indent on

" When vimrc is edited, reload it
autocmd! BufWritePost ~/.vimrc source ~/.vimrc

set ffs=unix,dos,mac "Default file types
set wildignore+=*/build/* "Is also used by CtrlP

" Tabline always visible
set showtabline=2
set clipboard=unnamed,unnamedplus
" Status line always visible
set laststatus=2

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
imap jj <Esc>

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

map <right> gt
map <left> gT

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')
    Plug 'airblade/vim-gitgutter'

    Plug 'ctrlpvim/ctrlp.vim'

    Plug 'jpalardy/vim-slime'
    
    Plug 'preservim/nerdtree'

    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'

    Plug 'vim-airline/vim-airline'
call plug#end()

" NERDTree
" Mirror the NERDTree before showing it. This makes it the same on all tabs.
nnoremap <C-n> :NERDTreeToggle<CR>

" CtrlP
let g:ctrlp_cmd = 'exe "CtrlP".get(["", "Buffer", "MRU"], v:count)'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_files = 0
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:32,results:32'

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
