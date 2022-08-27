--
-- === Dim ===
--
-- Dims unused functions and variables
--

vim.cmd("Plug 'narutoxy/dim.lua'")

vim.api.nvim_exec([[
  autocmd User PlugLoaded lua require("plugins.dim").setup()
]], false)

local module = {}

function module.setup()
  require("dim").setup()
end

return module
