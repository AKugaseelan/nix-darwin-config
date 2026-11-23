vim.g.mapleader = " "
vim.g.maplocalleader = ","

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment / decrement
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Ctrl-hjkl split navigation: normal mode comes from vim-tmux-navigator's
-- defaults; these let the same keys leave terminal splits (incl. Claude)
keymap.set("t", "<C-h>", "<C-\\><C-n><cmd>TmuxNavigateLeft<CR>", { desc = "Go to left split" })
keymap.set("t", "<C-j>", "<C-\\><C-n><cmd>TmuxNavigateDown<CR>", { desc = "Go to lower split" })
keymap.set("t", "<C-k>", "<C-\\><C-n><cmd>TmuxNavigateUp<CR>", { desc = "Go to upper split" })
keymap.set("t", "<C-l>", "<C-\\><C-n><cmd>TmuxNavigateRight<CR>", { desc = "Go to right split" })

-- tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- terminal split
keymap.set("n", "<leader>th", "<cmd>split | terminal<CR>", { desc = "Terminal in horizontal split" })
keymap.set("n", "<leader>tv", "<cmd>vsplit | terminal<CR>", { desc = "Terminal in vertical split" })
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Leave terminal mode" })
