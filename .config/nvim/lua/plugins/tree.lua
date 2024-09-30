local function telescope_dir(node)
  local path = ""
  if (node.type == 'file') then
    path = node.parent.absolute_path
  else
    path = node.absolute_path
  end

  require('nvim-tree').toggle()
  require('telescope.builtin').live_grep({
    search_dirs = { path },
    prompt_title = string.format('Grep in [%s]', vim.fs.basename(path)),
  })
end

-- Make it work like vinegar
vim.api.nvim_set_keymap('n', '-', '<CMD>NvimTreeToggle<CR>', { silent=true, noremap=true })

return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
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
    width = 40
  }
}
  end,
}
