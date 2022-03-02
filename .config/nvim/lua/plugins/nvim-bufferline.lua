--
-- === Nvim Bufferline ===
--
-- Top buffer line
--

vim.cmd("Plug 'akinsho/nvim-bufferline.lua'")

vim.api.nvim_exec([[
  autocmd User PlugLoaded lua require("plugins.nvim-bufferline").setup()
]], false)

local module = {}
function module.setup ()
require("bufferline").setup{
  options = {
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and "? " or "? "
      return " " .. icon .. count
    end,
    offsets = {{filetype = "NvimTree", text = "", text_align = "left"}},
    numbers = "buffer_id"
  },
}
end

return module
