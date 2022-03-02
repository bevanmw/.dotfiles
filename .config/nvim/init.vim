let g:startify_custom_header = [
      \ '                            __        ',
      \ '                           _| |_      ',
      \ '                           (_"\      ',
      \ '                             | |      ',
      \ '                             | |      ',
      \ '                  __.----.__/  /      ',
      \ '    /‾‾\        /             /       ',
      \ '    V‾\ \____ / (   |   (  |/         ',
      \ '       \________,|_|"‾‾‾"|_|          ',
      \ '‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾']

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

set lazyredraw

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

autocmd StdinReadPre * let s:std_in=1

let g:presence_editing_text      = "Editing file"
let g:presence_workspace_text    = "Working on nvim"

autocmd FileType markdown setlocal spell

autocmd BufEnter *.png,*.jpg,*gif exec "! imgcat ".expand("%") | :bw
"
" Disable quote concealing in JSON files
let g:vim_json_conceal=0
let g:indentLine_setConceal = 0

autocmd VimEnter *
            \   if !argc()
            \ |   Startify
            \ |   wincmd w
            \ | endif

" if $TERM_PROGRAM =~ "iTerm"
"    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
"    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
" endif

lua require("plugins.init")

colorscheme nightfox


let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

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

" Enter terminal mode automatically
augroup term_open
  autocmd!
  autocmd TermOpen * startinsert
augroup END

" Exit terminal insert mode with escape
tnoremap <Esc> <C-\><C-n>

" Map jk to exit insert mode:
" :imap jk <Esc>

" Debugging
nnoremap <F4> :lua require('dapui').toggle()<CR>
nnoremap <F5> :lua require('dap').toggle_breakpoint()<CR>
nnoremap <F9> :lua require('dap').continue()<CR>

nnoremap <F1> :lua require('dap').step_over()<CR>
nnoremap <F2> :lua require('dap').step_into()<CR>
nnoremap <F3> :lua require('dap').step_out()<CR>

nnoremap <Leader>dsc :lua require('dap').continue()<CR>
nnoremap <Leader>dsv :lua require('dap').step_over()<CR>
nnoremap <Leader>dsi :lua require('dap').step_into()<CR>
nnoremap <Leader>dso :lua require('dap').step_out()<CR>

nnoremap <Leader>dhh :lua require('dap.ui.variables').hover()<CR>
nnoremap <Leader>dhv :lua require('dap.ui.variables').visual_hover()<CR>

nnoremap <Leader>duh :lua require('dap.ui.widgets').hover()<CR>
nnoremap <Leader>duf :lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>

nnoremap <Leader>dro :lua require('dap').repl.open()<CR>
nnoremap <Leader>drl :lua require('dap').repl.run_last()<CR>

nnoremap <Leader>dbc :lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <Leader>dbm :lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>
nnoremap <Leader>dbt :lua require('dap').toggle_breakpoint()<CR>

nnoremap <Leader>dc :lua require('dap.ui.variables').scopes()<CR>
nnoremap <Leader>di :lua require('dapui').toggle()<CR>

let g:airline_powerline_fonts = 1

lua <<EOF

require'colorizer'.setup()
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
require('dap.ext.vscode').load_launchjs()
require("dapui").setup()
require("fidget").setup()

-- vim.lsp.set_log_level("debug") -- LSP debugging mode
EOF

luafile ~/.config/nvim/telescope.lua

lua require("lsp-config")

