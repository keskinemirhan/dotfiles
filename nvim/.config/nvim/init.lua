local notes_path = "/home/emirhan/notes"
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"


if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)
-- Options

vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.incsearch = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.fillchars = { eob = " " }
vim.opt.signcolumn = "no"
vim.opt.scrolloff = 10
vim.opt.wrap = false
vim.opt.ic = true
vim.opt.signcolumn = 'yes'

vim.keymap.set("n", "<leader>/", function() vim.cmd("nohlsearch") end)
vim.keymap.set("n", "<leader>s", function() vim.cmd("vsplit") end)
vim.keymap.set("n", "<leader>b", function() vim.cmd("split") end)
vim.keymap.set("n", "<leader>l", "<C-w>l")
vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>r", "<C-w>r")

vim.keymap.set("n", "<leader>b", ":buffers<CR>:buffer ")
vim.keymap.set("n", "<leader>d", ":buffers<CR>:bdelete ")
vim.keymap.set("n", "<leader>t", function() vim.cmd("tabnew") end)
vim.keymap.set("n", "<leader>g", function() vim.cmd("tabnew") end)

vim.keymap.set("n", "<leader>1", "1gt")
vim.keymap.set("n", "<leader>2", "2gt")
vim.keymap.set("n", "<leader>3", "3gt")
vim.keymap.set("n", "<leader>4", "4gt")
vim.keymap.set("n", "<leader>5", "5gt")
vim.keymap.set("n", "<leader>6", "6gt")
vim.keymap.set("n", "<leader>7", "7gt")
vim.keymap.set("n", "<leader>8", "8gt")
vim.keymap.set("n", "<leader>9", "9gt")

vim.api.nvim_create_user_command(
    "Notes",             -- string
    ":e " .. notes_path, -- string or Lua function
    {}                   -- table
)

require("lazy").setup({
    spec    = {
        {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.8',
            dependencies = { 'nvim-lua/plenary.nvim' }
        },
        {
            "williamboman/mason.nvim"
        },
        {
            "williamboman/mason-lspconfig.nvim",
        },
        {
            "neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
        },
        {
            "L3MON4D3/LuaSnip"
        },
        {
            "hrsh7th/nvim-cmp"
        },
        {
            'hrsh7th/cmp-nvim-lsp'
        },
        {
            'hrsh7th/cmp-buffer'
        },
        {
            'hrsh7th/cmp-path'
        },
        {
            'hrsh7th/cmp-cmdline'
        },
        {
            'saadparwaiz1/cmp_luasnip'
        },
        {
            "rafamadriz/friendly-snippets"
        },
        {
            'nvim-treesitter/nvim-treesitter'
        },
        {
            'nvim-lualine/lualine.nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' }
        },
        {
            "folke/trouble.nvim",
            opts = {}, -- for default options, refer to the configuration section for custom setup.
            cmd = "Trouble",
            keys = {
                {
                    "<leader>xx",
                    "<cmd>Trouble diagnostics toggle<cr>",
                    desc = "Diagnostics (Trouble)",
                },
                {
                    "<leader>xX",
                    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                    desc = "Buffer Diagnostics (Trouble)",
                },
                {
                    "<leader>xs",
                    "<cmd>Trouble symbols toggle focus=false<cr>",
                    desc = "Symbols (Trouble)",
                },
                {
                    "<leader>xl",
                    "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                    desc = "LSP Definitions / references / ... (Trouble)",
                },
                {
                    "<leader>xL",
                    "<cmd>Trouble loclist toggle<cr>",
                    desc = "Location List (Trouble)",
                },
                {
                    "<leader>xq",
                    "<cmd>Trouble qflist toggle<cr>",
                    desc = "Quickfix List (Trouble)",
                },
            },
        },
        {
            "lewis6991/gitsigns.nvim"
        },
        {
            "sindrets/diffview.nvim"
        },
        {
            "Mofiqul/vscode.nvim"
        }
    },
    install = { colorscheme = { "default" } },
    checker = { enabled = true },
})

-- Plugin Setups
local lspconfig = require("lspconfig")

require("mason").setup()

require("mason-lspconfig").setup({
    automatic_installation = true,
})

require('gitsigns').setup()

local cmp = require 'cmp'

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
    }, {
        { name = 'buffer' },
    })
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]] --

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason-lspconfig').setup_handlers({
    function(server)
        lspconfig[server].setup({
            capabilities = capabilities
        })
    end,
})

require("luasnip.loaders.from_vscode").lazy_load()

require 'nvim-treesitter.configs'.setup {
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = "codedark",
        component_separators = { left = ' ', right = ' ' },
        section_separators = { left = ' ', right = ' ' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}



-- Telescope
local telescope = require("telescope.builtin")


-- Plugin Keybindings
vim.keymap.set("n", "<leader>f", telescope.find_files, { desc = 'FILES' })
vim.keymap.set("n", "<leader>g", telescope.live_grep, { desc = 'GREP' })
vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format() end)
vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end)
vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.rename() end)

vim.keymap.set("n", "<leader>n", function() vim.cmd("Notes") end)

vim.cmd("colorscheme vscode")
vim.cmd [[
   highlight CursorLineNr guibg=none
   highlight DiagnosticError guibg=none
   highlight EndOfBuffer guibg=none
   highlight ErrorMsg guibg=none
   highlight FloatBorder guibg=none
   highlight LineNr guibg=none
   highlight ModeMsg guibg=none
   highlight MsgArea guibg=none
   highlight NonText guibg=none
   highlight NormalFloat guibg=none
   highlight Normal guibg=none
   highlight Pmenu guibg=none
   highlight PmenuSel guibg=none
   highlight SignColumn guibg=none
   highlight StatusLine guibg=none
   highlight StatusLineNC guibg=none

   highlight CursorLineNr ctermbg=none
   highlight DiagnosticError ctermbg=none
   highlight EndOfBuffer ctermbg=none
   highlight ErrorMsg ctermbg=none
   highlight FloatBorder ctermbg=none
   highlight LineNr ctermbg=none
   highlight ModeMsg ctermbg=none
   highlight MsgArea ctermbg=none
   highlight NonText ctermbg=none
   highlight Normal ctermbg=none
   highlight NormalFloat ctermbg=none
   highlight Pmenu ctermbg=none
   highlight PmenuSel ctermbg=none
   highlight SignColumn ctermbg=none
   highlight StatusLine ctermbg=none
   highlight StatusLineNC ctermbg=none
 ]]
