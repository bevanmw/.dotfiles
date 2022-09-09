--
-- === Nvim winbar ===
--
-- Status line with current function
--

vim.cmd("Plug 'mauricekraus/winbar.nvim', { 'branch': 'fix/#5' }")         -- Tree view

vim.api.nvim_exec([[
  autocmd User PlugLoaded lua require("plugins.nvim-winbar").setup()
]], false)

local module = {}

function module.setup()
  require('winbar').setup({
    enabled = true
  })
end

return module

