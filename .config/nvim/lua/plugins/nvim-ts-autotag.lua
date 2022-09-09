--
-- === Nvim auto tag ===
--
-- Preview markdown while editing
--

vim.cmd("Plug 'windwp/nvim-ts-autotag'")

vim.api.nvim_exec([[
  autocmd User PlugLoaded lua require("plugins.nvim-ts-autotag").setup()
]], false)

local module = {}

function module.setup()
  require'nvim-ts-autotag'.setup()
end

return module
