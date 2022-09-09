--
-- === Nvim autopairs ===
--
-- Preview markdown while editing
--

vim.cmd("Plug 'windwp/nvim-autopairs'")

vim.api.nvim_exec([[
  autocmd User PlugLoaded lua require("plugins.nvim-autopairs").setup()
]], false)

local module = {}

function module.setup()
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require('cmp')
  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )
end

return module
