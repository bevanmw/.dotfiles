--
-- === Fidget ===
--
-- Show status for LSP loading
--

vim.cmd("Plug 'j-hui/fidget.nvim'")

vim.api.nvim_exec([[
  autocmd User PlugLoaded lua require("plugins.nvim-dap-ui").setup()
]], false)


local module = {}

function module.setup()
  require("fidget").setup()
end

return module
