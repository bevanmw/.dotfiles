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

setlocal spell spelllang=en_us

set clipboard=unnamed

set splitbelow
set splitright


set shell=/bin/zsh

set termguicolors

syntax on
set re=0

autocmd StdinReadPre * let s:std_in=1

let g:presence_editing_text      = "Editing file"
let g:presence_workspace_text    = "Working on nvim"
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

call plug#begin()
  Plug 'jeffkreeftmeijer/vim-numbertoggle'

  Plug 'mhinz/vim-startify'               " Start screen

  Plug 'jparise/vim-graphql'              " GraphQL syntax

  Plug 'tpope/vim-fugitive'               " Git stuff
  Plug 'tpope/vim-rhubarb'                " Enable :GBrowse for github
  Plug 'tommcdo/vim-fubitive'             " Enable :GBrowse for bitbucket

  Plug 'akinsho/nvim-bufferline.lua' " Buffer header

  Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}

  Plug 'nvim-lua/popup.nvim'              " Popup windows - used by other plugins
  Plug 'nvim-lua/plenary.nvim'            " Additional lua functions - used by other plugins
  Plug 'nvim-telescope/telescope.nvim'    " Search popup

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax Highlighting 

  Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }

  Plug 'tpope/vim-commentary'             " Comments

  Plug 'tpope/vim-surround'               " Surround selected text with something

  Plug 'tpope/vim-dispatch'               " Run tasks async

  Plug 'kyazdani42/nvim-tree.lua'         " Tree view

  Plug 'airblade/vim-rooter'              " Find and auto select the root of project

  Plug 'kyazdani42/nvim-web-devicons'     " Icons

  Plug 'unblevable/quick-scope'           " Highlight chars when using f or t

  Plug 'neovim/nvim-lspconfig'            " Nvim LSP config

  Plug 'hrsh7th/nvim-compe'               " Nvim LSP auto completion

  Plug 'hrsh7th/vim-vsnip'                " Snippets

  Plug 'mhartington/oceanic-next'         " Color scheme

  Plug 'norcalli/nvim-colorizer.lua'      " Highlight colors in code

  Plug 'cedarbaum/fugitive-azure-devops.vim'

call plug#end()

colorscheme OceanicNext

let mapleader = " "

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

let g:fubitive_domain_pattern = 'bitbucket\.org'
let g:fugitive_azure_domain_pattern = 'vs-ssh.visualstudio.com'

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fs <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap <leader>fd <cmd>Telescope lsp_definitions<cr>
nnoremap <leader>fe <cmd>Telescope lsp_workspace_diagnostics<cr>
nnoremap <leader>fgl <cmd>Telescope git_files<cr>
nnoremap <leader>fgb <cmd>Telescope git_branches<cr>

" NPM / Yarn maps for vim-dispatch:
nnoremap <leader>yi :Dispatch yarn install<CR>
nnoremap <leader>ys :Dispatch! yarn start<CR>
nnoremap <leader>yt :Dispatch yarn test<CR><C-w>j
nnoremap <leader>ni :Dispatch npm install<CR>
nnoremap <leader>pi :Dispatch cd ios; pod install; cd ../<CR>

" Quickly open the embedded Nvim terminal emulator
nnoremap <silent> <Leader>t :bel 10sp +terminal<CR>

" Bufferline
nnoremap <silent>]b :BufferLineCycleNext<CR>
nnoremap <silent>[b :BufferLineCyclePrev<CR>

" Enter terminal mode automatically
augroup term_open
  autocmd!
  autocmd TermOpen * startinsert
augroup END

" Exit terminal insert mode with escape
tnoremap <Esc> <C-\><C-n>

" Map jk to exit insert mode:
:imap jk <Esc>

let g:chadtree_settings = { "view.window_options.relativenumber": v:true }

let g:netrw_bufsettings = 'noma nomod nonu nobl nowrap ro nornu relativenumber number'

let g:airline_powerline_fonts = 1

" Nvim Tree
let g:nvim_tree_width = 50
let g:nvim_tree_follow = 1
let g:nvim_tree_quit_on_open = 1
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_lsp_diagnostics = 1
let g:nvim_tree_disable_netrw = 0
let g:nvim_tree_hijack_netrw = 1
let g:nvim_tree_group_empty = 1
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache', '.temp', '.DS_Store']

" Make work like vinegar
nnoremap - :NvimTreeToggle<CR>

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
}
require("bufferline").setup{
  options = {
    diagnostics = "nvim_lsp",
    offsets = {{filetype = "NvimTree", text = "", text_align = "left"}},
  },
}
require'colorizer'.setup()
EOF

luafile ~/.config/nvim/spaceline.lua

luafile ~/.config/nvim/telescope.lua

lua require("lsp-config")

