local cmp = require("cmp")

vim.g.mapleader = " "

-- Navigating Buffers
vim.keymap.set('n', '<C-k>', '<C-u>zz')
vim.keymap.set('n', '<C-j>', '<C-d>zz')

-- Windows 
vim.keymap.set('n', '<leader>r', '<cmd>vsplit<cr>')
vim.keymap.set('n', '<leader>p', '<cmd>split<cr>')
vim.keymap.set('n', '_', '<C-w><')
vim.keymap.set('n', '+', '<C-w>>')

-- navigating windows
vim.cmd('nnoremap <leader>h <C-w>h')
vim.cmd('nnoremap <leader>j <C-w>j')
vim.cmd('nnoremap <leader>k <C-w>k')
vim.cmd('nnoremap <leader>l <C-w>l')

-- Tabs
vim.keymap.set('n', '<leader>n', '<cmd>tabnext<cr>')
vim.keymap.set('n', '<leader>t', '<cmd>tabnew<cr>')
vim.keymap.set('n', '<leader>b', '<cmd>tabprevious<cr>')

-- navigating tabs

vim.keymap.set('n', '<leader>1', '<cmd>tabn 1<cr>')
vim.keymap.set('n', '<leader>2', '<cmd>tabn 2<cr>')
vim.keymap.set('n', '<leader>3', '<cmd>tabn 3<cr>')
vim.keymap.set('n', '<leader>4', '<cmd>tabn 4<cr>')
vim.keymap.set('n', '<leader>5', '<cmd>tabn 5<cr>')
vim.keymap.set('n', '<leader>6', '<cmd>tabn 6<cr>')
vim.keymap.set('n', '<leader>7', '<cmd>tabn 7<cr>')
vim.keymap.set('n', '<leader>8', '<cmd>tabn 8<cr>')
vim.keymap.set('n', '<leader>9', '<cmd>tabn 9<cr>')
vim.keymap.set('n', '<leader>0', '<cmd>tabn 10<cr>')


-- Lsp diagnostic
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


-- plugin toggling 
vim.cmd('nnoremap <leader>o :NvimTreeToggle<CR>')
vim.cmd('nnoremap <leader>g :Git<CR>')
vim.cmd('nnoremap <leader>d :Gvdiffsplit<CR>')

-- Lsp bindings 
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>s', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>nn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- nvim-cmp code completion
local cmp = require("cmp")
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
  }),
})




