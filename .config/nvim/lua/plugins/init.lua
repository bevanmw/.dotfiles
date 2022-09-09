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

  require 'plugins.nvim-web-devicons'

  require 'plugins.quick-scope'

  require 'plugins.nvim-lspconfig'

  require 'plugins.nvim-cmp'

  require 'plugins.nvim-lsp-ts-utils'

  require 'plugins.vim-vsnip'

  require 'plugins.nvim-colorizer'

  require 'plugins.nightfox'

  require 'plugins.nvim-dap'

  require 'plugins.nvim-dap-python'

  require 'plugins.nvim-dap-ui'

  require 'plugins.fidget'

  require 'plugins.markdown-preview'

  require 'plugins.vimwiki'

  require 'plugins.telescope-vimwiki'

  require 'plugins.mdx'

  require 'plugins.nvim-autopairs'

  require 'plugins.nvim-ts-autotag'

  require 'plugins.nvim-navic'

  require 'plugins.nvim-winbar'

vim.call('plug#end')

-- Calls functions after all plugins have loaded
vim.api.nvim_command('doautocmd User PlugLoaded')
