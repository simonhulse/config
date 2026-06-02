-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- pin Python provider so Neovim always finds pynvim/jupyter_client
-- even when a project venv is active
vim.g.python3_host_prog = "/usr/bin/python3"

-- leader (must be before lazy)
vim.g.mapleader      = " "
vim.g.maplocalleader = "\\"

-- options
vim.opt.splitright     = true
vim.opt.splitbelow     = true
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.scrolloff      = 999
vim.opt.timeoutlen     = 200
vim.opt.tabstop        = 4
vim.opt.shiftwidth     = 4
vim.opt.expandtab      = true
vim.opt.laststatus     = 2
vim.opt.showmode       = false
vim.opt.mouse          = "a"
vim.opt.termguicolors  = true
vim.opt.updatetime     = 300  -- faster CursorHold (used by CoC highlight)
vim.opt.signcolumn     = "yes"
vim.opt.undofile       = true
vim.opt.swapfile       = true
vim.opt.backup         = true
vim.opt.backupcopy     = "yes"
vim.opt.nrformats:append("alpha")  -- allow <C-a>/<C-x> to increment/decrement letters

local backup_dir = vim.fn.stdpath("state") .. "/backup"
if vim.fn.isdirectory(backup_dir) == 0 then
  vim.fn.mkdir(backup_dir, "p", tonumber("700", 8))
end
vim.opt.backupdir = { backup_dir }

-- filetype settings
vim.g.tex_flavor = "latex"  -- override .tex default from plaintex

-- keymaps
local map = vim.keymap.set

map("n", "Q",           "<nop>")                -- disable Ex mode
map("n", "<leader>w",   ":w<CR>")               -- save
map("n", "<leader>q",   ":q<CR>")               -- quit
map("n", "<leader>bd",  ":%bd|e#<CR>")          -- close all buffers except current
map("n", ";",           ":")                     -- command mode with ;
map("v", ";",           ":")
map("n", "<Down>",      "<C-W><C-J>")            -- window navigation
map("n", "<Up>",        "<C-W><C-K>")
map("n", "<Right>",     "<C-W><C-L>")
map("n", "<Left>",      "<C-W><C-H>")
map("n", "<leader>ev",  ":vnew $MYVIMRC<CR>")   -- edit config
map("n", "<leader>sv",  ":source $MYVIMRC<CR>") -- source config
map("n", "oo",          "o<Esc>k")              -- blank line below without entering insert
map("n", "OO",          "O<Esc>j")              -- blank line above without entering insert
map("n", "-",           "ddp")                  -- move line down
map("n", "_",           "ddkP")                 -- move line up
map("i", "jk",          "<Esc>")                -- escape insert mode
map("i", "kj",          "<Esc>")
map("i", "JK",          "<Esc>")
map("i", "KJ",          "<Esc>")
map("i", "<Left>",      "<nop>")                -- disable arrows in insert mode
map("i", "<Right>",     "<nop>")
map("i", "<Up>",        "<nop>")
map("i", "<Down>",      "<nop>")
map("n", "dl",          "ddO<Esc>")             -- clear line contents without removing it
map("n", "#",           ":b#<CR>")              -- jump to previous buffer
map("n", "<leader>p",   "a <Esc>p")             -- paste with leading space
map("n", "<leader>b",   "0v$gq")                -- reflow line to textwidth
map("n", "<leader>l",   ":AsyncRun ls")         -- ls (no <CR>: allows appending a path)

-- autocmds
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    if vim.bo.filetype ~= "markdown" then
      vim.cmd([[%s/\s\+$//e]])
    end
  end,
})

-- plugins
require("lazy").setup("plugins", {
  rocks = { hererocks = false },
})
