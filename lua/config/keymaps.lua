local opts = { noremap = true, silent = true }
-- local map = vim.keymap.set

-- Keep cursor centered when scrolling
-- vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
-- vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
--
-- Move selected line / block of text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Fast saving
-- vim.keymap.set("n", "<leader>w", ":write!<CR>", { silent = true, desc = "Save file" })
-- vim.keymap.set("n", "<leader>q", ":q!<CR>", opts)

-- Remap for dealing with visual line wraps
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- paste over currently selected text without yanking it
vim.keymap.set("v", "p", '"_dp')
vim.keymap.set("v", "P", '"_dP')

-- copy everything between { and } including the brackets
-- p puts text after the cursor,
-- P puts text before the cursor.
vim.keymap.set("n", "YY", "va{Vy", opts)

-- Move line on the screen rather than by line in the file
-- vim.keymap.set("n", "j", "gj", opts)
-- vim.keymap.set("n", "k", "gk", opts)

-- Exit on jj and jk
vim.keymap.set("i", "jj", "<ESC>", opts)
vim.keymap.set("i", "jk", "<ESC>", opts)

-- Move to start/end of line
vim.keymap.set({ "n", "x", "o" }, "H", "^", opts)
vim.keymap.set({ "n", "x", "o" }, "L", "g_", opts)

-- Navigate buffers
vim.keymap.set("n", "<Right>", ":bnext<CR>", opts)
vim.keymap.set("n", "<Left>", ":bprevious<CR>", opts)

-- Panes resizing
vim.keymap.set("n", "+", ":vertical resize +5<CR>")
vim.keymap.set("n", "_", ":vertical resize -5<CR>")
vim.keymap.set("n", "=", ":resize +5<CR>")
vim.keymap.set("n", "-", ":resize -5<CR>")

-- Map enter to ciw in normal mode
-- vim.keymap.set("n", "<CR>", "ciw", opts)  -- Commented out: This overwrites word on Enter - too disruptive
-- vim.keymap.set("n", "<BS>", "ci", opts)   -- Commented out: This changes text on Backspace - too disruptive

vim.keymap.set("n", "n", "nzzv", opts)
vim.keymap.set("n", "N", "Nzzv", opts)
vim.keymap.set("n", "*", "*zzv", opts)
vim.keymap.set("n", "#", "#zzv", opts)
vim.keymap.set("n", "g*", "g*zz", opts)
vim.keymap.set("n", "g#", "g#zz", opts)

-- map ; to resume last search
-- map("n", ";", "<cmd>Telescope resume<cr>", opts)

-- search current buffer
-- vim.keymap.set("n", "<C-s>", ":Telescope current_buffer_fuzzy_find<CR>", opts)

-- Split line with X
vim.keymap.set("n", "X", ":keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<cr>", { silent = true })

-- ctrl + x to cut full line
vim.keymap.set("n", "<C-x>", "dd", opts)

-- Select all
vim.keymap.set("n", "<C-a>", "ggVG", opts)

-- write file in current directory
-- :w %:h/<new-file-name>
vim.keymap.set("n", "<C-n>", ":w %:h/", opts)

-- delete forward
-- w{number}dw
-- delete backward
-- w{number}db

-- vim.keymap.set("n", "<C-P>", ':lua require("config.utils").toggle_go_test()<CR>', opts)

-- Get highlighted line numbers in visual mode
vim.keymap.set("v", "<leader>ln", ':lua require("config.utils").get_highlighted_line_numbers()<CR>', opts)

vim.keymap.set('n', '<leader>rl', function()
  vim.cmd('w')
  vim.cmd('SlimeSendCurrentLine')
end, { desc = '[Slime] [l]ine: Send current line to REPL' })

vim.keymap.set('n', '<leader>L', ':cd %:h<CR>', {
  desc = '[L]ocate file in system'
})

-- This file defines a Lua function to open a terminal and initialize tmux.

-- The function that will be called by the keymap.
local function open_tmux_terminal()
  -- The command to open a terminal and run the 'tmux' command.
  -- `:terminal` opens a new terminal in a horizontal split.
  local cmd_string = 'terminal tmux'
  
  -- We use vim.cmd() to execute the command directly.
  vim.cmd(cmd_string)
end

-- This file defines a Lua function to open a vertical split terminal and then initialize a Tmux session within it.

-- The function that will be called by the keymap.
local function open_tmux_vsplit()
  -- The command to open a terminal in a vertical split (`vsplit`)
  -- and then run the tmux command.
  -- `tmux attach || tmux new-session` will attach to an existing session
  -- or create a new one if none exists.
  local cmd_string = 'vsplit | terminal tmux attach || tmux new-session'
  
  -- We use vim.cmd() to execute the command directly.
  vim.cmd(cmd_string)
end

--[[ vim.keymap.set('n', '<leader>T', open_tmux_vsplit, {
  desc = 'Windowed Tmux'
}) ]]

-- Opens a vsplit terminal
vim.keymap.set('n', '<leader>T', function()
  vim.cmd('vsplit | terminal')
end, {
  desc = 'Windowed Tmux'
})

-- New keymap to open a vsplit terminal, start tmux, and run Julia.
local function open_julia_terminal()
  local cmd_string = 'vsplit | terminal tmux new-session -A -s julia_session'
  vim.cmd(cmd_string)
end
vim.keymap.set('n', '<leader>J', open_julia_terminal, {
  desc = 'Open Julia in a vertical split terminal with tmux'
})



-- Save the current file using <leader> w
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file' })

-- Send motion (paragraph) to Slime, and move the cursor to the end of the paragraph
vim.keymap.set('n', '<leader>rr', '<Plug>SlimeMotionSend}}', {
    silent = true,
    desc = 'Slime: Send Current Paragraph'
})



-- Smart expand/init
vim.keymap.set({'n', 'v'}, '<CR>', function()
  local mode = vim.fn.mode()
  if mode == 'n' then
    vim.cmd("lua require'nvim-treesitter.incremental_selection'.init_selection()")
  else
    vim.cmd("lua require'nvim-treesitter.incremental_selection'.node_incremental()")
  end
end, { desc = 'Init or expand Treesitter selection' })

-- Shrink
vim.keymap.set('v', '<BS>', function()
  vim.cmd("lua require'nvim-treesitter.incremental_selection'.node_decremental()")
end, { desc = 'Shrink Treesitter selection' })

-- Open broot in a terminal
local function open_broot()
  local cmd_string = 'terminal broot' 
  vim.cmd('cd %:h')
  vim.cmd(cmd_string)
  vim.cmd('startinsert')
end
vim.keymap.set('n', '<leader>e', open_broot, { desc = 'test termial' })
