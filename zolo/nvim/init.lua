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

-- Map Escape in terminal to exit terminal mode
-- vim.cmd('tnoremap <Esc> <C-\\><C-n>')
-- high
-- vim.api.nvim_exec([[
--   highlight Type ctermfg=Yellow guifg=#FFFF00
-- ]], false)

-- Auto change directory to current file's directory when opening a buffer
vim.cmd([[
  autocmd BufEnter,BufWinEnter * lcd %:p:h
]])

-- Define a custom command to split and open terminal
-- vim.cmd [[command! SplitTerm split | terminal | startinsert]]
vim.cmd[[
  command! SplitTerm call StartSplitTerm()
  function! StartSplitTerm()
    split
    terminal bash 
    startinsert
  endfunction
]]

-- Load plugins using Packer
require('packer').startup(function()

  use 'wbthomason/packer.nvim'
  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
}
  use 'mhartington/formatter.nvim'

  use 'tpope/vim-commentary'

  use 'b3nj5m1n/kommentary'    

  use 'preservim/nerdtree'

  use 'tpope/vim-fugitive'
  use 'nvim-tree/nvim-web-devicons'
  use {'nvim-lualine/lualine.nvim', requires = {'nvim-tree/nvim-web-devicons', opt = true },
  tag = 'compat-nvim-0.6'}

end)

-- Change the background of lualine_c section for normal mode
local custom_gruvbox = require'lualine.themes.gruvbox'

custom_gruvbox.normal.c.bg = '#112233'

require('lualine').setup {
  options = { theme  = custom_gruvbox },
}

vim.api.nvim_exec([[
  " Define a function to add syntax highlighting for a language
  function! MySyntaxHighlighting()
    if &filetype == 'python'
      " Python
      syntax match pythonType "\\<class\\s\\+\\w\\+\\>"
      highlight link pythonType Type
    elseif &filetype == 'go'
      " Go
      syntax match goType "\\<type\\s\\+\\w\\+\\>"
      highlight link goType Type
    elseif &filetype == 'java'
      " Java
      syntax match javaType "\\<class\\|interface\\s\\+\\w\\+\\>"
      highlight link javaType Type
    endif
  endfunction

  " Call the function when a buffer is read or a new buffer is created
  autocmd BufRead,BufNewFile * call MySyntaxHighlighting()

  " Set the color for Type
  highlight Type ctermfg=LightGreen guifg=#90EE90
]], false)

-- Utilities for creating configurations

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
-- require("formatter").setup {
--   -- Enable or disable logging
--   logging = true,
--   -- Set the log level
--   log_level = vim.log.levels.WARN,
--   -- All formatter configurations are opt-in
--   filetype = {
--     -- Formatter configurations for filetype "lua" go here
--     -- and will be executed in order
--     lua = {
--       -- "formatter.filetypes.lua" defines default configurations for the
--       -- "lua" filetype
--       require("formatter.filetypes.lua").stylua,

--       -- You can also define your own configuration
--       function()
--         -- Supports conditional formatting
--         if util.get_current_buffer_file_name() == "special.lua" then
--           return nil
--         end

--         -- Full specification of configurations is down below and in Vim help
--         -- files
--         return {
--           exe = "stylua",
--           args = {
--             "--search-parent-directories",
--             "--stdin-filepath",
--             util.escape_path(util.get_current_buffer_file_path()),
--             "--",
--             "-",
--           },
--           stdin = true,
--         }
--       end
--     },

--     -- Use the special "*" filetype for defining formatter configurations on
--     -- any filetype
--     ["*"] = {
--       -- "formatter.filetypes.any" defines default configurations for any
--       -- filetype
--       require("formatter.filetypes.any").remove_trailing_whitespace
--     }
--   }
-- }
-- Key mappings in Lua for Neovim

-- Map <leader>f to :Format<CR>
-- vim.api.nvim_set_keymap('n', '<leader>f', ':Format<CR>', { noremap = true, silent = true })

-- Map <leader>F to :FormatWrite<CR>
-- vim.api.nvim_set_keymap('n', '<leader>F', ':FormatWrite<CR>', { noremap = true, silent = true })

-- local augroup = vim.api.nvim_create_augroup
-- local autocmd = vim.api.nvim_create_autocmd
-- augroup("__formatter__", { clear = true })
-- autocmd("BufWritePost", {
-- 	group = "__formatter__",
-- 	command = ":FormatWrite",
-- })
