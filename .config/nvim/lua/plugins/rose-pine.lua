--
-- === Nightfox ===
--
-- Nvim compatible color scheme
--

vim.cmd("Plug 'rose-pine/neovim'")

vim.api.nvim_exec([[
  autocmd User PlugLoaded lua require("plugins.rose-pine").setup()
]], false)


local module = {}

function module.setup()
  vim.cmd('colorscheme rose-pine')
end

return module
