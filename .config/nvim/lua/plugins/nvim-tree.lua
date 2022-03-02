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
  disable_netrw = 0,
  hijack_netrw = 1,
  follow = 1,
  diagnostics = {
  enable = true
  },
  update_focused_file = {
    enable = true
  },
  filters = {
    custom = {'.git', 'node_modules', '.cache', '.temp', '.DS_Store'}
  }
}
end

-- Make it work like vinegar
vim.api.nvim_set_keymap('n', '-', '<CMD>NvimTreeToggle<CR>', { silent=true, noremap=true })

-- Settings
vim.g["nvim_tree_width"] = 50
vim.g["nvim_tree_quit_on_open"] = 1
vim.g["nvim_tree_indent_markers"] = 1
vim.g["nvim_tree_group_empty"] = 1

-- Disable netrw
vim.g["netrw_bufsettings "] = 'noma nomod nonu nobl nowrap ro nornu relativenumber number'

return module
