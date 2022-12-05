"    _____ _               
"   |  |  |_|_____ ___ ___ 
"   |  |  | |     |  _|  _|
"    \___/|_|_|_|_|_| |___|
"                          
"   
set encoding=utf-8

" Vim-Plug
call plug#begin('~/.vim/plugged')

    " Basics
    Plug 'tpope/vim-surround'
    Plug 'jiangmiao/auto-pairs' 
    Plug 'unblevable/quick-scope'

    " Color Scheme
    Plug 'morhetz/gruvbox'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'Lokaltog/vim-powerline'

    " Session Management
    Plug 'xolox/vim-session'
    Plug 'xolox/vim-misc'

    " Html Plugin
    Plug 'mattn/emmet-vim'
    Plug 'ap/vim-css-color'

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'ThePrimeagen/vim-be-good' 

call plug#end()

" Leader Key
let mapleader = " "
let g:user_emmet_leader_key = "<C-Z>"
nnoremap <Leader>av :tabnew $MYVIMRC <Enter>
nnoremap <Leader>rv :source $MYVIMRC <Enter>

" Session Management plugin - xolox
let g:session_directory = "~/.vim/sessions"
let g:session_autoload = 'no'
let g:session_autosave = 'no'
let g:session_command_aliases = 1

nnoremap <Leader>os :OpenSession 
nnoremap <Leader>ss :SaveSession 
nnoremap <Leader>cs :CloseSession 

let $FZF_DEFAULT_COMMAND = "rg --files --hidden --follow --no-ignore-vcs"
nnoremap <Leader>g :GFiles<Enter>
nnoremap <Leader>o :Buffers<Enter>
nnoremap <Leader>z :Files<Enter>
nnoremap <Leader>rg :Rg! 

set backspace=2 
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler
set showcmd
set incsearch
set smartcase
set hlsearch
set laststatus=2
set autowrite
set modelines=0
set nomodeline

" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

filetype plugin indent on
filetype on

augroup vimrcEx
  autocmd!
  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost * if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |   exe "normal g`\"" | endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
  autocmd BufRead,BufNewFile aliases.local,zshrc.local,*/zsh/configs/* set filetype=sh
  autocmd BufRead,BufNewFile gitconfig.local set filetype=gitconfig
  autocmd BufRead,BufNewFile tmux.conf.local set filetype=tmux
  autocmd BufRead,BufNewFile vimrc.local set filetype=vim
augroup END

let g:is_posix = 1

set softtabstop=0 tabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,full
set wildmenu
set wildignore+=*/venv/*

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    else
        return "\<C-p>"
    endif
endfunction

" Switch between the last two files
nnoremap <Leader><Leader> <C-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Set tags for vim-fugitive
set tags^=.git/tags

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

" C++ Compile And Run
au FileType cpp let &makeprg = "g++ -o %:r.out % -std=c++17"
au FileType cpp noremap <F7> :w <Enter> :make <Enter>
au FileType cpp noremap <F8> :!./%:r.out <Enter>
au FileType cpp noremap <F9> :make <Enter> :!./%:r.out <Enter>

" Python Compile and Run au FileType python noremap <F7> :!clear && python3 ./%:r.py <Enter> 
" Remap Escape
inoremap jk <Esc>
cnoremap jk <Esc>
vnoremap <Leader>jk <Esc>
tnoremap jk <C-\><C-n>

" Copy and Paste (Clipboard)
nnoremap <Leader>P "+gP
nnoremap <Leader>ca :%y+ <Enter>
vnoremap <C-c> "+y
map <Leader>V "+p

" Relative Number
set relativenumber

" Gruvbox Plugin - ColorScheme
colorscheme gruvbox
set background=dark
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1

" Quickscope Plugin
let g:qs_highlight_on_keys = ['f', 'F']
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

" Mouse Capability
set mouse=a

" Tab Number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt

" Vertical Split Resize
nnoremap <leader>R :resize 

" Open Terminal
nnoremap <leader>tt :bel term <Enter><C-w>J clear <Enter> <C-\><C-n> 

" Search down into subfolders
set path+=**

highlight LineNr ctermfg=100

" Single movement on long lines
nnoremap j gj
nnoremap k gk

" Remap CTRL d and u with center 
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Remap search next with center 
nnoremap n nzzzv
nnoremap N Nzzzv
