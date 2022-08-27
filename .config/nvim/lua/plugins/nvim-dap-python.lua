--
-- === Nvim dap python ===
--
-- DAP support for python
--

vim.cmd("Plug 'mfussenegger/nvim-dap-python'")

vim.api.nvim_exec([[
  autocmd User PlugLoaded lua require("plugins.nvim-dap-python").setup()
]], false)


local module = {}

function module.setup()
  require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
end

return module
