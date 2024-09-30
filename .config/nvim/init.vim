set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

filetype plugin indent on
" show existing tab with spaces width
set tabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
" On pressing tab, insert 2 spaces
set expandtab
" Line numbers:
set number relativenumber
" Highlight searches
set incsearch
" Start scrolling 10 lines before
set scrolloff=10
" Disable line wrapping
set nowrap
" Allow hiding of buffers
set hidden
" Show max line lenght indicator
set colorcolumn=88 " Black python uses this
" Terminal title
set title

set nocompatible
filetype plugin on
syntax on

set redrawtime=100000

set encoding=UTF-8

set signcolumn=yes

set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

set signcolumn=yes

set copyindent
set preserveindent
set list listchars=tab:▸\ ,trail:·,precedes:←,extends:→

setlocal spell spelllang=en_us

set clipboard=unnamed

set splitbelow
set splitright

let mapleader = " "

set shell=/bin/zsh

set termguicolors

syntax on
set re=0

lua require("config.lazy")

autocmd StdinReadPre * let s:std_in=1

autocmd FileType markdown setlocal spell

augroup env_ft
  au!
  autocmd BufEnter *.env.* set syntax=sh " Handle .env.* files as .env files
augroup END


autocmd VimEnter *
            \   if !argc()
            \ |   Startify
            \ |   wincmd w
            \ | endif

" if $TERM_PROGRAM =~ "iTerm"
"    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
"    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
" endif


" Buffers
nnoremap <leader>vb :vertical sb<space>
nnoremap <leader>sb :sb<space>
" Close all buffers
nnoremap <leader>Q :bufdo bwipeout<CR>

" Quickly open the embedded Nvim terminal emulator
nnoremap <silent> <Leader>t :bel 10sp +terminal<CR>

" Bufferline
nnoremap <silent>]b :BufferLineCycleNext<CR>
nnoremap <silent>[b :BufferLineCyclePrev<CR>

" Move selected up or down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Go to definition at center
nnoremap gd gdzz

" Allow upper case save
:command WQ wq
:command Wq wq
:command W w
:command Q q

" Enter terminal mode automatically
augroup term_open
  autocmd!
  autocmd TermOpen * startinsert
augroup END

" Exit terminal insert mode with escape
tnoremap <Esc> <C-\><C-n>

lua require("lsp-config")

" Don't replace register when pasting
xnoremap <leader>p "_dP
" Keep current line in center of screen
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz


