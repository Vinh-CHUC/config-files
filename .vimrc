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
set autochdir
set wildignore+=*/build/*


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Keep at least 7 lines below and above the cursor, when scrolling
set so=16

set ruler "Always show current position
set wildmenu "Turn on Wild menu
set cmdheight=2 "The commandbar height
set number

" Set backspace config
set backspace=eol,start,indent

" Allow h,l,<- and -> to move to next/previous lines
set whichwrap+=<,>,h,l

""""""""
" Search
""""""""
set ignorecase "Case unsensitive search
"Make it sensitive if the search pattern contains upper case characters
set smartcase 
set hlsearch
set incsearch "Show matches as search pattern is being typed

set nolazyredraw "Do not redraw while executing macros

set showmatch "Show matching bracets when cursor is on them
set mat=2

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set foldcolumn=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colours and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable

if has("gui_running")
  set guioptions-=T
  set guitablabel=%m\ %N\ %t
  set background=dark
  colorscheme desert
else
  set t_Co=256
  set background=dark
  colorscheme desert
endif

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
set shiftwidth=4
set tabstop=4
set smarttab

"Automatic word wrapping
set textwidth=79 
set colorcolumn=+1

"Control the way lines are broken (only affects visualization not text file)
set linebreak

set autoindent
set smartindent
set wrap

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

map <right> gt
map <left> gT


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'ra'
