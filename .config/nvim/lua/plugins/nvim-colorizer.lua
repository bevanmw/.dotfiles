--
-- === Nvim colorizer ===
--
-- Highlights colors in code with the color represented in the code
--

vim.cmd("Plug 'norcalli/nvim-colorizer.lua'")

vim.api.nvim_exec([[
  autocmd User PlugLoaded lua require("plugins.nvim-colorizer").setup()
]], false)


local module = {}

function module.setup()
  require('colorizer').setup()
end

return module
