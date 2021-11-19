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

noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

map <right> gt
map <left> gT

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.local/share/nvim/plugged')
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'dense-analysis/ale'

    Plug 'hhvm/vim-hack'

    Plug 'jpalardy/vim-slime'

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    Plug 'mhinz/vim-signify'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Plug 'neovim/nvim-lspconfig'

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
let g:ale_linters = {'hack': ['hack'], 'erlang': []}
let g:ale_fixers = {'hack': ['hackfmt']}

" COC - LSP
" Tab to trigger completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
    \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> <leader>gt :call CocActionAsync('jumpDefinition', 'tabe')<CR>
nnoremap <silent> <leader>gs :call CocActionAsync('jumpDefinition', 'vsplit')<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LSP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lua << EOF
" require'lspconfig'.pylsp.setup{}
" EOF
