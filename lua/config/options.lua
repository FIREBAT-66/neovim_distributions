-- Use :lua print(package.path) to see the path. Note that the ../config directory is not part of the current package path. If desired, thepackage path can be added via modifying the package.path variable
require("config.vimtex.config")

vim.g.mapleader = " "					-- change leader to a space
vim.g.maplocalleader = " "				-- change localleader to a space
vim.g.loaded_netrw = 1					-- disable netrw
vim.g.loaded_netrwPlugin = 1				--  disable netrw
vim.opt.incsearch = true				-- make search act like search in modern browsers
vim.opt.backup = false					-- creates a backup file
vim.opt.clipboard='unnamedplus'			      -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1					-- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0				-- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"				-- the encoding written to a file
vim.opt.hlsearch = true					-- highlight all matches on previous search pattern
vim.opt.ignorecase = true				-- ignore case in search patterns
vim.opt.mouse = "a"					-- allow the mouse to be used in neovim
vim.opt.pumheight = 10					-- pop up menu height
vim.opt.showmode = false				-- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 0					-- always show tabs
vim.opt.smartcase = true				-- smart case
vim.opt.splitbelow = true				-- force all horizontal splits to go below current window
vim.opt.splitright = true				-- force all vertical splits to go to the right of current window
vim.opt.swapfile = false				-- creates a swapfile
vim.opt.termguicolors = true				-- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 66				-- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true					-- enable persistent undo
vim.opt.updatetime = 100				-- faster completion (4000ms default)
vim.opt.writebackup = false				-- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = false				-- convert tabs to spaces
vim.opt.shiftwidth = 2 -- Amount to indent with << and >>
vim.opt.tabstop = 2 -- How many spaces are shown per Tab
vim.opt.softtabstop = 2 -- How many spaces are shown per Tab
-- vim.opt.smartindent = false				    -- make indenting smarter again
-- Lists invisibles
-- vim.opt.list = true
-- vim.opt.listchars = { tab = "|-", trail = "·", nbsp = "␣" }

vim.opt.cursorline = true				-- highlight the current line
-- vim.opt.cursorcolumn = true				-- highlight the current line
vim.opt.number = true					-- set numbered lines
vim.opt.breakindent = true				-- wrap lines with indent
vim.opt.relativenumber = true				-- set relative numbered lines
vim.opt.numberwidth = 4					-- set number column width to 2 {default 4}
vim.opt.signcolumn =
"yes:1"							--  show the sign column, otherwise it would shift the text each time
vim.opt.wrap = true				       -- display lines as one long line
vim.opt.scrolloff = 6				   -- Makes sure there are always eight lines of context
-- vim.opt.sidescrolloff = 8				   -- Makes sure there are always eight lines of context
vim.opt.showcmd = true		 -- Don't show the command in the last line
vim.opt.ruler = true		  -- Don't show the ruler
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.title = true		  -- set the title of window to the value of the titlestring
vim.opt.confirm = true		  -- confirm to save changes before exiting modified buffer
vim.opt.fillchars = { eob = " " } -- change the character at the end of buffer
-- vim.opt.winborder = "rounded" -- solid
vim.opt.winborder = "single"	  -- https://neovim.io/doc/user/options.html#'winborder'

-- vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
-- vim.opt.guicursor = "i-ci:ver30-iCursor-blinkwait300-blinkon200-blinkoff150"
vim.opt.guicursor = ""


-- vim.opt.cursorlineopt = "number"		 -- set the cursorline
-- vim.opt.tabstop = 2				 -- insert 2 spaces for a tab
-- vim.opt.laststatus = 0 -- Always display the status line

-- changes colors of the number columns and other associated features
vim.api.nvim_set_hl(0, 'Normal', { fg = '#FF6000', bg = 'none' })
vim.api.nvim_set_hl(0, 'CursorLine', { fg = 'none', bg = '#80401a', blend = 5 })
vim.api.nvim_set_hl(0, 'Visual', { fg = 'none', bg = '#80401a', blend = 50 })
vim.api.nvim_set_hl(0, 'ministatuslinemodenormal', { fg = '#ff6000', bg = '#80401a' })

vim.filetype.add({
    extension = {
	env = "dotenv",
    },
    filename = {
	[".env"] = "dotenv",
	["env"] = "dotenv",
    },
    pattern = {
	["[jt]sconfig.*.json"] = "jsonc",
	["%.env%.[%w_.-]+"] = "dotenv",
    },
})

local opt = vim.opt
local cmd = vim.cmd
local api = vim.api
local nvim_create_autocmd = api.nvim_create_autocmd
local nvim_set_hl = api.nvim_set_hl

-- vim.opt.list = true

local space = "·"
opt.listchars:append {
	tab = "│─",
--	multispace = space,
	eol = "↲",
	extends = "❯",
	precedes = "❮",
	lead = "─",
	trail = "─",
	nbsp = "─",
}

cmd([[match TrailingWhitespace /\s\+$/]])

nvim_set_hl(0, "TrailingWhitespace", { link = "Error" })




vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN]  = "",
      [vim.diagnostic.severity.INFO]  = "",
      [vim.diagnostic.severity.HINT]  = "󰌵",
    },
  },
})


-- vim.api.nvim_create_augroup("remember_folds", { clear = true })
--
-- vim.api.nvim_create_autocmd("BufWinLeave", {
--   group = "remember_folds",
--   pattern = "*",
--   command = "mkview",
-- })
--
-- vim.api.nvim_create_autocmd("BufWinEnter", {
--   group = "remember_folds",
--   pattern = "*",
--   command = "silent! loadview",
-- })



-- 1. Set the global slime target to 'neovim'.
-- This tells vim-slime to look for an open Neovim terminal buffer to send text to.
vim.g.slime_target = "neovim"

-- Set bracketed paste mode for Neovim so slime can deliver data to ipython interpreters
vim.g.slime_bracketed_paste = 1
vim.g.slime_python_ipython = 1
