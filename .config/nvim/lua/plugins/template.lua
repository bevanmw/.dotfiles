--
-- === Nightfox ===
--
-- Nvim compatible color scheme
--

vim.cmd("Plug 'glepnir/template.nvim'")

vim.api.nvim_exec([[
  autocmd User PlugLoaded lua require("plugins.template").setup()
]], false)


local module = {}

function module.setup()
  local temp = require('template')

  temp.temp_dir = '~/.config/nvim/template'
  temp.author = 'Bevan Wentzel'
  temp.email = 'bevan@teamgeek.io'
end

return module
