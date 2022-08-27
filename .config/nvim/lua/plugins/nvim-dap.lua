--
-- === Nvim DAP ===
--
-- Debuggin plugin for vim
--

vim.cmd("Plug 'mfussenegger/nvim-dap'")

local config = {noremap = true, silent = true}
vim.api.nvim_set_keymap('n', '<F4>', ':lua require("dapui").toggle()<CR>', config)
vim.api.nvim_set_keymap('n', '<F5>', ':lua require("dap").toggle_breakpoint()<CR>', config)
vim.api.nvim_set_keymap('n', '<F9>', ':lua require("dap").continue()<CR>', config)

vim.api.nvim_set_keymap('n', '<F1>', ':lua require("dap").step_over()<CR>', config)
vim.api.nvim_set_keymap('n', '<F2>', ':lua require("dap").step_into()<CR>', config)
vim.api.nvim_set_keymap('n', '<F3>', ':lua require("dap").step_out()<CR>', config)

vim.api.nvim_set_keymap('n', '<Leader>dsc', ':lua require("dap").continue()<CR>', config)
vim.api.nvim_set_keymap('n', '<Leader>dsv', ':lua require("dap").step_over()<CR>', config)
vim.api.nvim_set_keymap('n', '<Leader>dsi', ':lua require("dap").step_into()<CR>', config)
vim.api.nvim_set_keymap('n', '<Leader>dso', ':lua require("dap").step_out()<CR>', config)

vim.api.nvim_set_keymap('n', '<Leader>dhh', ':lua require("dap.ui.variables").hover()<CR>', config)
vim.api.nvim_set_keymap('n', '<Leader>dso', ':lua require("dap.ui.variables").visual_hover()<CR>', config)

vim.api.nvim_set_keymap('n', '<Leader>duh', ':lua require("dap.ui.widgets").hover()<CR>', config)
vim.api.nvim_set_keymap('n', '<Leader>duf', ':lua require("dap.ui.widgets").widgets.centered_float(widgets.scopes)<CR>', config)

vim.api.nvim_set_keymap('n', '<Leader>dro', ':lua require("dap").repl.open()<CR>', config)
vim.api.nvim_set_keymap('n', '<Leader>drl', ':lua require("dap").repl.run_last()<CR>', config)

vim.api.nvim_set_keymap('n', '<Leader>dbc', ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', config)
vim.api.nvim_set_keymap('n', '<Leader>dbm', ':lua require("dap").set_breakpoint({ nil, nil, vim.fn.input("Log point message: ") })<CR>', config)
vim.api.nvim_set_keymap('n', '<Leader>dbt', ':lua require("dap").toggle_breakpoint()<CR>', config)

vim.api.nvim_set_keymap('n', '<Leader>dc', ':lua require("dap.ui.variables").scopes()<CR>', config)
vim.api.nvim_set_keymap('n', '<Leader>di', ':lua require("dapui").toggle()<CR>', config)


vim.api.nvim_exec([[
  autocmd User PlugLoaded lua require("plugins.nvim-dap").setup()
]], false)


local module = {}

function module.setup()
  require('dap.ext.vscode').load_launchjs()
end

return module
