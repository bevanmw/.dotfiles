--
-- === Indent blankline ===
--
-- Indentation guidelines to all lines including blank lines
--

vim.cmd("Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'master' }")


vim.api.nvim_exec([[
  autocmd User PlugLoaded lua require("plugins.indent-blankline").setup()
]], false)

local module = {}

function module.setup()
require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
    use_treesitter = true
}
end

return module
