--
-- === Nvim dap ui ===
--
-- Better UI to interact with nvim DAP
--

vim.cmd("Plug 'rcarriga/nvim-dap-ui'")

vim.api.nvim_exec([[
  autocmd User PlugLoaded lua require("plugins.nvim-dap-ui").setup()
]], false)


local module = {}

function module.setup()
  require("dapui").setup()
end

return module
