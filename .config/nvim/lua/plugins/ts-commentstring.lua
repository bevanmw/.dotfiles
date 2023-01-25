--
-- === Comment string ===
--
-- Use Tree Sitter context to apply comments
--

vim.cmd("Plug 'JoosepAlviste/nvim-ts-context-commentstring'")

vim.api.nvim_exec([[
  autocmd User PlugLoaded lua require("plugins.ts-commentstring").setup()
]], false)


local module = {}

function module.setup()
  -- Do nothing
end

return module
