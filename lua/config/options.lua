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

nvim_create_autocmd("InsertEnter", {
	callback = function()
		opt.listchars.trail = nil
		nvim_set_hl(0, "TrailingWhitespace", { link = "Whitespace" })
	end
})

nvim_create_autocmd("InsertLeave", {
	callback = function()
		opt.listchars.trail = space
		nvim_set_hl(0, "TrailingWhitespace", { link = "Error" })
	end
})

vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2											  
  end
})

-- Create an Autocmd Group to keep your autocommands organized
vim.api.nvim_create_augroup("ChangeCWD", { clear = true })

-- Set the working directory to the current buffer's file path on switch, 
-- but only for file buffers (not terminal or scratch buffers)
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  group = "ChangeCWD",
  callback = function()
    local buffer_name = vim.api.nvim_buf_get_name(0)

    -- Check if the buffer is a file buffer (has a path and is not a terminal buffer)
    -- 'term://' is the filetype for Neovim's built-in terminal
    -- 'buftype' being 'terminal' is another check for terminal buffers
    -- The checks ensure it's a regular file buffer with a name
    if buffer_name ~= "" and vim.bo.buftype ~= "terminal" then
      -- Get the directory of the current buffer's file
      -- %:p:h expands to the full path of the file, then removes the file name (head)
      local dir = vim.fn.fnamemodify(buffer_name, ":h")
      
      -- Use :lcd (local change directory) to change the directory for the current window only
      if dir ~= "" then
        vim.cmd("lcd " .. dir)
      end
    end
  end,
})

-- Optional: For new empty buffers, you might want to switch back to the global CWD
-- or the home directory. The use of 'lcd' means the window keeps its CWD 
-- even when switching to a new *empty* buffer (which has no name/path).
-- This command will revert the window's CWD to the global CWD if it's an unlisted,
-- unnamed buffer (like a new, unsaved buffer).
vim.api.nvim_create_autocmd("BufEnter", {
  group = "ChangeCWD",
  pattern = { "" }, -- Matches unnamed buffers
  callback = function()
    -- Only do this if the buffer has no name and is not a terminal
    if vim.bo.buftype == "" and vim.api.nvim_buf_get_name(0) == "" then
      vim.cmd("lcd " .. vim.fn.getcwd(-1, -1)) -- Revert to global CWD
    end
  end,
})


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

--[[ -- 2. Configure the 'neovim' target settings.
-- Setting 'terminal_channel' to 0 instructs vim-slime to find the
-- channel ID of the *first* open terminal buffer and use it.
vim.g.slime_default_config = {
		neovim = {
				terminal_channel = 0
		}
} ]]

-- Automatically enter insert mode in terminal buffers (used primarily for entering broot commands)
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.cmd("startinsert")
  end,
})


vim.api.nvim_create_autocmd("BufLeave", {
  callback = function()
    if vim.bo.buftype == "terminal" and vim.fn.bufname():match("broot") then
      vim.cmd("bd!") -- close the buffer
    end
  end,
})



-- -- Close terminal buffers automatically when the job exits, which prevents you from having to manually close them by pressing any key
-- vim.api.nvim_create_autocmd("TermClose", {
--   pattern = "*",
--   callback = function()
--     -- Only close if you're not already viewing another buffer
--     -- (avoids closing if it's in a split you're not focused on)
--     if vim.fn.bufname() ~= "" then
--       vim.cmd("bd!")
--     end
--   end,
-- })



vim.api.nvim_create_autocmd("TermClose", {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local name = vim.fn.bufname(buf)

    if name:match("broot") then
      -- Switch to alternate buffer if possible
      local alt = vim.fn.bufnr("#")
      if alt ~= -1 and vim.api.nvim_buf_is_valid(alt) then
        vim.cmd("buffer #")
      else
        -- fallback: open a new empty buffer instead
        vim.cmd("enew")
      end

      -- Now safely delete the broot terminal buffer
      vim.schedule(function()
        pcall(vim.cmd, "bd! " .. buf)
      end)
    end
  end,
})
