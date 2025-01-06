----------------------------------
-- INSTALL LAZY ------------------
----------------------------------

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)



----------------------------------
-- PLUGINS -----------------------
----------------------------------

require('lazy').setup({
  "mrjones2014/smart-splits.nvim",
})


----------------------------------
-- Keymaps -----------------------
----------------------------------

vim.keymap.set("n", "<C-A-S-j>", require("smart-splits").resize_left)
vim.keymap.set("n", "<C-S-A-,>", require("smart-splits").resize_down)
vim.keymap.set("n", "<C-S-A-8>", require("smart-splits").resize_up)
vim.keymap.set("n", "<C-S-A-i>", require("smart-splits").resize_right)
-- moving between splits
vim.keymap.set("n", "<C-S-A-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-S-A-e>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-S-A-u>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-S-A-a>", require("smart-splits").move_cursor_right)

-- Keybinds to create new plits
vim.keymap.set("n", "<C-S-A-6>", "<cmd>vsplit<CR>", { desc = "Create a new vertical split" })
vim.keymap.set("n", "<C-S-A-q>", "<cmd>split<CR>", { desc = "Create a new horizontal split" })
