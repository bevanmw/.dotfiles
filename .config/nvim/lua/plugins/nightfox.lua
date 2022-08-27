--
-- === Nightfox ===
--
-- Nvim compatible color scheme
--

vim.cmd("Plug 'EdenEast/nightfox.nvim'")

vim.api.nvim_exec([[
  autocmd User PlugLoaded lua require("plugins.nightfox").setup()
]], false)


local module = {}

function module.setup()
  vim.cmd('colorscheme nightfox')
end

return module
