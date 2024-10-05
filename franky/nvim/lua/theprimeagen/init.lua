require("theprimeagen.set")
require("theprimeagen.remap")
require("theprimeagen.lazy_init")


-- vim.cmd("set expandtab")
-- vim.cmd("set tabstop=2") vim.cmd("set softtabstop=2") vim.cmd("set shiftwidth=2")

-- Enable mouse support
vim.opt.mouse = "a"  

-- Enable line numbers by default
vim.opt.number = true



-- Enable relative line numbers by default
-- vim.opt.relativenumber = true

-- Set tab width vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Enable syntax highlighting
vim.cmd('syntax on')

-- Enable auto-indentation
vim.cmd('filetype plugin indent on')

-- Set clipboard to use system clipboard
vim.opt.clipboard = 'unnamedplus'

-- Set a better status line
vim.opt.laststatus = 2

-- Set color scheme
-- vim.cmd('colorscheme desert')
-- vim.cmd('colorscheme elflord')
-- vim.cmd('colorscheme evening')
-- vim.cmd('colorscheme industry')
--
-- Remove M characters 
vim.cmd [[command! RemoveM %s/\r//g]]

-- Packer configuration
vim.cmd [[packadd packer.nvim]]

-- Define autocmd to set nonumber and norelativenumber in terminal buffers
vim.cmd([[
  augroup TerminalSettings
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
  augroup END
]])



-- DO.not
-- DO NOT INCLUDE THIS

-- If i want to keep doing lsp debugging
-- function restart_htmx_lsp()
--     require("lsp-debug-tools").restart({ expected = {}, name = "htmx-lsp", cmd = { "htmx-lsp", "--level", "DEBUG" }, root_dir = vim.loop.cwd(), });
-- end

-- DO NOT INCLUDE THIS
-- DO.not

local augroup = vim.api.nvim_create_augroup
local ThePrimeagenGroup = augroup('ThePrimeagen', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = ThePrimeagenGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd('LspAttach', {
    group = ThePrimeagenGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.opt.clipboard = 'unnamedplus'

vim.opt.mouse = 'a'
