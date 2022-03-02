vim.call('plug#begin')

  require 'plugins.vim-numbertoggle'

  require 'plugins.vim-startify'

  require 'plugins.vim-graphql'

  require 'plugins.vim-fugitive'

  require 'plugins.vim-gitgutter'

  require 'plugins.nvim-bufferline'

  require 'plugins.galaxyline-nvim'

  require 'plugins.popup'

  require 'plugins.plenary'

  require 'plugins.telescope'

  require 'plugins.nvim-treesitter'

  require 'plugins.indent-blankline'

  require 'plugins.vim-commentary'

  require 'plugins.vim-surround'

  require 'plugins.vim-dispatch'

  require 'plugins.nvim-tree'

  require 'plugins.vim-rooter'

  vim.cmd("Plug 'kyazdani42/nvim-web-devicons'")     -- Icons

  vim.cmd("Plug 'unblevable/quick-scope'")           -- Highlight chars when using f or t

  vim.cmd("Plug 'neovim/nvim-lspconfig'")            -- Nvim LSP config

  vim.cmd("Plug 'hrsh7th/nvim-compe'")               -- Nvim LSP auto completion

  vim.cmd("Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'") -- Typescript utils for LSP

  vim.cmd("Plug 'hrsh7th/vim-vsnip'")                -- Snippets

  vim.cmd("Plug 'mhartington/oceanic-next'")         -- Color scheme

  vim.cmd("Plug 'norcalli/nvim-colorizer.lua'")      -- Highlight colors in code

  vim.cmd("Plug 'cedarbaum/fugitive-azure-devops.vim'")

  vim.cmd("Plug 'ruanyl/vim-sort-imports'")          -- Sort imports

  vim.cmd("Plug 'glepnir/lspsaga.nvim'")             -- Better LSP UI

  vim.cmd("Plug 'EdenEast/nightfox.nvim'")           -- Color scheme

  vim.cmd("Plug 'mfussenegger/nvim-dap'")            -- Debugging

  vim.cmd("Plug 'mfussenegger/nvim-dap-python'")

  vim.cmd("Plug 'rcarriga/nvim-dap-ui'")

  vim.cmd("Plug 'j-hui/fidget.nvim'")

  vim.cmd("Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }")

  vim.cmd("Plug 'vimwiki/vimwiki'")

  vim.cmd("Plug 'ElPiloto/telescope-vimwiki.nvim'")

vim.call('plug#end')

vim.api.nvim_command('doautocmd User PlugLoaded')
