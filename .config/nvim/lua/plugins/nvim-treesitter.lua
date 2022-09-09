--
-- === Nvim Treesitter ===
--
-- Syntax highlighting
--

vim.cmd("Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}")

vim.api.nvim_exec([[
  autocmd User PlugLoaded lua require("plugins.nvim-treesitter").setup()
]], false)

local module = {}
function module.setup ()
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
  autotag = {
    enable = true
  }
}
end

return module
