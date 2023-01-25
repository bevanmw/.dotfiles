-- === Images ===
--
-- Display images as ascii
--

vim.cmd("Plug 'samodostal/image.nvim'")


vim.api.nvim_exec([[
  autocmd User PlugLoaded lua require("plugins.image").setup()
]], false)

local module = {}

function module.setup()
require('image').setup {
  render = {
    min_padding = 5,
    show_label = true,
    use_dither = true,
    foreground_color = false,
    background_color = false
  },
  events = {
    update_on_nvim_resize = true,
  },
}
end

return module
