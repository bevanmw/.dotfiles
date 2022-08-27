--
-- === Telescope Vimwiki ===
--
-- Telescope extension for vim wiki pages
--

vim.cmd("Plug 'ElPiloto/telescope-vimwiki.nvim'")

vim.api.nvim_exec([[
  autocmd User PlugLoaded lua require("plugins.telescope-vimwiki").setup()
]], false)


local module = {}

function module.setup()
  require('telescope').load_extension('vimwiki')
end

return module
