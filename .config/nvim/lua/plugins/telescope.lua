local config = { silent = true }
return {
  'nvim-telescope/telescope.nvim',
  config = function ()
    vim.api.nvim_set_keymap("n", "<Leader>ff", "<CMD>Telescope find_files<CR>", config)
    vim.api.nvim_set_keymap("n", "<Leader>fg", "<CMD>Telescope live_grep<CR>", config)
    vim.api.nvim_set_keymap("n", "<Leader>fh", "<CMD>Telescope help_tags<CR>", config)
    vim.api.nvim_set_keymap("n", "<Leader>fb", "<CMD>Telescope buffers<CR>", config)
    vim.api.nvim_set_keymap("n", "<Leader>fs", "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>", config)
    vim.api.nvim_set_keymap("n", "<Leader>fw", "<CMD>Telescope lsp_workspace_symbols<CR>", config)
    vim.api.nvim_set_keymap("n", "<Leader>fd", "<CMD>Telescope lsp_definitions<CR>", config)
    vim.api.nvim_set_keymap("n", "<Leader>fe", "<CMD>Telescope lsp_workspace_diagnostics<CR>", config)
    vim.api.nvim_set_keymap("n", "<Leader>fgl", "<CMD>Telescope git_files<CR>", config)
    vim.api.nvim_set_keymap("n", "<Leader>fgb", "<CMD>Telescope git_branches<CR>", config)
end,
}
