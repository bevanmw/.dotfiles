--
-- === Vim dispatch ===
--
-- Allows for running things async
--

vim.cmd("Plug 'tpope/vim-dispatch'")

local config = { silent = true, noremap = true }
-- NPM / Yarn maps for vim-dispatch:
vim.api.nvim_set_keymap("n", "<Leader>yi", "<CMD>Dispatch yarn install<CR>", config)
vim.api.nvim_set_keymap("n", "<Leader>ys", "<CMD>Dispatch yarn start<CR>", config)
vim.api.nvim_set_keymap("n", "<Leader>yt", "<CMD>Dispatch yarn test<CR>", config)
