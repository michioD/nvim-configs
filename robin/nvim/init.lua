-- Basic settings
vim.opt.number = true           -- Show line numbers
vim.opt.relativenumber = true   -- Show relative line numbers
vim.opt.clipboard = 'unnamedplus' -- Enable clipboard integration (copy/paste with system clipboard)
vim.opt.mouse = 'a'             -- Enable mouse support
vim.opt.tabstop = 4             -- Number of spaces per Tab
vim.opt.shiftwidth = 4          -- Indentation rule
vim.opt.expandtab = true        -- Convert Tabs to Spaces
vim.opt.wrap = false            -- Disable line wrapping

-- Remove M characters 
vim.cmd [[command! RemoveM %s/\r//g]]


-- Define autocmd to set nonumber and norelativenumber in terminal buffers
vim.cmd([[
  augroup TerminalSettings
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
  augroup END
]])

--Toggle function
function ToggleRelativeLineNumbers()
  if vim.wo.relativenumber == true then
    vim.wo.relativenumber = false
    vim.wo.number = true
  else
    vim.wo.relativenumber = true
  end
end

-- command to toggle relative lines
vim.cmd('command! TL lua ToggleRelativeLineNumbers()')


-- Auto change directory to current file's directory when opening a buffer
vim.cmd([[
  autocmd BufEnter,BufWinEnter * lcd %:p:h
]])

-- Define a custom command to split and open terminal
vim.cmd[[
  command! SplitTerm call StartSplitTerm()
  function! StartSplitTerm()
    split
    terminal bash 
    startinsert
  endfunction
]]

-- Install lazy.nvim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim and specify plugins
require("lazy").setup({

    {'preservim/nerdtree'},

    -- Color scheme
    { 'ellisonleao/gruvbox.nvim', priority = 1000 }, -- Gruvbox color scheme

    -- LSP Support and Autocompletion
    { 'neovim/nvim-lspconfig' },          -- Language Server Protocol (LSP)
    { 'hrsh7th/nvim-cmp' },               -- Autocompletion plugin
    { 'hrsh7th/cmp-nvim-lsp' },           -- LSP source for nvim-cmp
    { 'L3MON4D3/LuaSnip' },               -- Snippet engine

    -- File Explorer
    { 'nvim-tree/nvim-tree.lua' },        -- File explorer
    { 'nvim-tree/nvim-web-devicons' },    -- Optional icons

    -- Telescope Fuzzy Finder
    { 'nvim-telescope/telescope.nvim',
      tag = '0.1.3',
      dependencies = { 'nvim-lua/plenary.nvim' } },

    -- Treesitter for better syntax highlighting
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' }
})

-- Set colorscheme
vim.cmd([[colorscheme gruvbox]])

-- Keymaps for file explorer
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true })

-- Keymaps for Telescope fuzzy finder
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { silent = true })
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>', { silent = true })
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', { silent = true })
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<CR>', { silent = true })
