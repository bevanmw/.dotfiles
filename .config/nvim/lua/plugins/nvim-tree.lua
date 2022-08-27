--
-- === Nvim tree ===
--
-- Tree view
--

vim.cmd("Plug 'kyazdani42/nvim-tree.lua'")         -- Tree view

vim.api.nvim_exec([[
  autocmd User PlugLoaded lua require("plugins.nvim-tree").setup()
]], false)

local module = {}

function module.setup()
require'nvim-tree'.setup {
  diagnostics = {
    enable = true,
    show_on_dirs = true
  },
  update_focused_file = {
    enable = true
  },
  actions = {
    open_file = {
      quit_on_open = true
    }
  },
  renderer = {
    indent_markers = {
      enable = true
    },
    group_empty = true
  },
  filters = {
    custom = {'.git', 'node_modules', '.cache', '.temp', '.DS_Store'}
  },
  view = {
    width = 50
  }
}
end

-- Make it work like vinegar
vim.api.nvim_set_keymap('n', '-', '<CMD>NvimTreeToggle<CR>', { silent=true, noremap=true })

return module
