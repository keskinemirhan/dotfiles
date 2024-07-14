require("plug-init")
require("bindings")
vim.opt.signcolumn = 'no'

vim.o.termguicolors = true
-- vim.cmd("colorscheme rasmus")
vim.cmd("colorscheme catppuccin-mocha")
-- vim.cmd("colorscheme moonfly")
vim.cmd("set number")
vim.cmd("set scrolloff=15")
vim.cmd("set relativenumber")
vim.cmd("set tabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set expandtab")
vim.cmd('let &t_SI = \"\\e[6 q\"')
vim.cmd('let &t_EI = \"\\e[2 q\"')
-- vim.cmd("set guicursor=n-v-c-i:block")
vim.cmd('set cursorline')
vim.cmd('set signcolumn=yes')
vim.cmd('set nowrap')
vim.opt.hlsearch = false
vim.opt.incsearch = true

















