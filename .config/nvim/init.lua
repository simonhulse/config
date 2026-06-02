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
require("lazy").setup({

  -- Colorscheme
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({ contrast = "hard", transparent_mode = true })
      vim.cmd("colorscheme gruvbox")
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,  -- plugin explicitly does not support lazy-loading
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.install").compilers = { "gcc" }
      require("nvim-treesitter").install({
        "bash", "fish", "java", "latex", "lua", "make", "python", "rust", "vim",
      })
      vim.api.nvim_create_autocmd("FileType", {
        callback = function() pcall(vim.treesitter.start) end,
      })
    end,
  },

  -- Git diff signs in gutter
  "airblade/vim-gitgutter",

  -- Statusline
  {
    "itchyny/lightline.vim",
    config = function()
      vim.g.lightline = {
        active = {
          left = {
            { "mode", "paste" },
            { "cocstatus", "readonly", "filename", "modified" },
          },
        },
        component_function = { cocstatus = "coc#status" },
      }
      vim.api.nvim_create_autocmd("User", {
        pattern = { "CocStatusChange", "CocDiagnosticChange" },
        callback = function() vim.fn["lightline#update"]() end,
      })
    end,
  },

  -- Snippets
  {
    "SirVer/ultisnips",
    config = function()
      vim.g.UltiSnipsExpandTrigger       = "<esc>"
      vim.g.UltiSnipsJumpForwardTrigger  = "<c-j>"
      vim.g.UltiSnipsJumpBackwardTrigger = "<c-k>"
      vim.g.UltiSnipsEditSplit           = "vertical"
      vim.g.UltiSnipsListSnippets        = "<c-tab>"
      vim.g.UltiSnipsSnippetDirectories  = { vim.env.HOME .. "/.config/snippets" }
      -- prevent UltiSnips from capturing <ESC> in visual mode
      vim.keymap.set("x", "<Esc>", "<Esc>", { noremap = true })
    end,
  },

  -- Per-project .lvimrc files
  {
    "embear/vim-localvimrc",
    config = function()
      vim.g.localvimrc_enable  = 1
      vim.g.localvimrc_ask     = 0
      vim.g.localvimrc_reverse = 1
      vim.g.localvimrc_sandbox = 0
    end,
  },

  -- Async shell commands
  "skywind3000/asyncrun.vim",

  -- Python indentation
  "vim-scripts/indentpython.vim",

  -- LSP / completion
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      local keyset = vim.keymap.set

      -- check_back_space: called via v:lua in the TAB expr mapping below
      function _G.check_back_space()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
      end

      -- show_docs: called via <CMD>lua in the K mapping below
      function _G.show_docs()
        local cw = vim.fn.expand('<cword>')
        if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
          vim.api.nvim_command('h ' .. cw)
        elseif vim.api.nvim_eval('coc#rpc#ready()') then
          vim.fn.CocActionAsync('doHover')
        else
          vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
      end

      -- Completion
      local expr_opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
      keyset("i", "<TAB>",   'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', expr_opts)
      keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], expr_opts)
      keyset("i", "<CR>",    [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], expr_opts)
      keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

      -- Float scroll
      local scroll_opts = { silent = true, nowait = true, expr = true }
      keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', scroll_opts)
      keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', scroll_opts)
      keyset("i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', scroll_opts)
      keyset("i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', scroll_opts)
      keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', scroll_opts)
      keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', scroll_opts)

      -- Diagnostics
      keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
      keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

      -- Navigation
      keyset("n", "gd", "<Plug>(coc-definition)",      { silent = true })
      keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
      keyset("n", "gi", "<Plug>(coc-implementation)",  { silent = true })
      keyset("n", "gr", "<Plug>(coc-references)",      { silent = true })

      -- Hover documentation
      keyset("n", "K", "<CMD>lua _G.show_docs()<CR>", { silent = true })

      -- Highlight symbol references on cursor hold
      vim.api.nvim_create_augroup("CocGroup", {})
      vim.api.nvim_create_autocmd("CursorHold", {
        group = "CocGroup",
        command = "silent call CocActionAsync('highlight')",
      })

      -- Rename / format / code actions
      local action_opts = { silent = true, nowait = true }
      keyset("n", "<leader>rn", "<Plug>(coc-rename)",                       { silent = true })
      keyset("x", "<leader>f",  "<Plug>(coc-format-selected)",              { silent = true })
      keyset("n", "<leader>f",  "<Plug>(coc-format-selected)",              { silent = true })
      keyset("x", "<leader>a",  "<Plug>(coc-codeaction-selected)",          action_opts)
      keyset("n", "<leader>a",  "<Plug>(coc-codeaction-selected)",          action_opts)
      keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)",            action_opts)
      keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)",            action_opts)
      keyset("n", "<leader>qf", "<Plug>(coc-fix-current)",                  action_opts)
      keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)",          { silent = true })
      keyset("x", "<leader>r",  "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
      keyset("n", "<leader>r",  "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
      keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)",              action_opts)

      -- Function / class text objects
      local obj_opts = { silent = true, nowait = true }
      keyset("x", "if", "<Plug>(coc-funcobj-i)",  obj_opts)
      keyset("o", "if", "<Plug>(coc-funcobj-i)",  obj_opts)
      keyset("x", "af", "<Plug>(coc-funcobj-a)",  obj_opts)
      keyset("o", "af", "<Plug>(coc-funcobj-a)",  obj_opts)
      keyset("x", "ic", "<Plug>(coc-classobj-i)", obj_opts)
      keyset("o", "ic", "<Plug>(coc-classobj-i)", obj_opts)
      keyset("x", "ac", "<Plug>(coc-classobj-a)", obj_opts)
      keyset("o", "ac", "<Plug>(coc-classobj-a)", obj_opts)

      -- Format expression for TypeScript / JSON
      vim.api.nvim_create_autocmd("FileType", {
        group = "CocGroup",
        pattern = "typescript,json",
        command = "setl formatexpr=CocAction('formatSelected')",
      })

      -- Commands
      vim.api.nvim_create_user_command("Format", "call CocAction('format')",                              {})
      vim.api.nvim_create_user_command("Fold",   "call CocAction('fold', <f-args>)",                     { nargs = "?" })
      vim.api.nvim_create_user_command("OR",     "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

      -- CocList
      local list_opts = { silent = true, nowait = true }
      keyset("n", "<leader>La", ":<C-u>CocList diagnostics<CR>", list_opts)
      keyset("n", "<leader>Le", ":<C-u>CocList extensions<CR>",  list_opts)
      keyset("n", "<leader>Lc", ":<C-u>CocList commands<CR>",    list_opts)
      keyset("n", "<leader>Lo", ":<C-u>CocList outline<CR>",     list_opts)
      keyset("n", "<leader>Ls", ":<C-u>CocList -I symbols<CR>",  list_opts)
      keyset("n", "<leader>Lj", ":<C-u>CocNext<CR>",             list_opts)
      keyset("n", "<leader>Lk", ":<C-u>CocPrev<CR>",             list_opts)
    end,
  },

  -- Image rendering (kitty backend) — used by molten for inline plots
  {
    "3rd/image.nvim",
    config = function()
      require("image").setup({
        backend = "kitty",
        max_width = 100,
        max_height = 12,
        max_height_window_percentage = math.huge,
        max_width_window_percentage = math.huge,
        window_overlap_clear_enabled = true,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      })
    end,
  },

  -- Jupyter kernel integration with inline output
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    dependencies = { "3rd/image.nvim" },
    init = function()
      vim.g.molten_image_provider          = "image.nvim"
      vim.g.molten_output_win_max_height   = 20
      vim.g.molten_auto_open_output        = false  -- toggle manually
      vim.g.molten_wrap_output             = true
      vim.g.molten_virt_text_output        = true   -- condensed output as virtual text
      vim.g.molten_virt_lines_off_by_1     = true
    end,
    config = function()
      local map = vim.keymap.set
      map("n", "<leader>mi", ":MoltenInit<CR>",                          { silent = true })              -- start kernel
      map("n", "<leader>mm", "vip:<C-u>MoltenEvaluateVisual<CR>", { silent = true })         -- run current cell
      map("n", "<leader>mc", ":MoltenEvaluateOperator<CR>",              { silent = true, expr = true }) -- run with motion (e.g. <leader>mcip)
      map("n", "<leader>ml", ":MoltenEvaluateLine<CR>",                  { silent = true })              -- run line
      map("n", "<leader>mr", ":MoltenReevaluateCell<CR>",                { silent = true })              -- re-run cell
      map("v", "<leader>mv", ":<C-u>MoltenEvaluateVisual<CR>gv",         { silent = true })              -- run selection
      map("n", "<leader>md", ":MoltenDelete<CR>",                { silent = true })  -- delete cell output
      map("n", "<leader>mh", ":MoltenHideOutput<CR>",            { silent = true })  -- hide output
      map("n", "<leader>ms", ":MoltenShowOutput<CR>",            { silent = true })  -- show output
      map("n", "<leader>me", ":MoltenExportOutput!<CR>",         { silent = true })  -- export to ipynb
      map("n", "<leader>mx", ":AsyncRun .venv/bin/jupytext --sync % && xdotool search --name '%:t:r.ipynb' key --clearmodifiers F5<CR>", { silent = true })  -- sync .py <-> .ipynb and refresh browser
    end,
  },

  -- UI components used by molten (kernel picker, notifications)
  "rcarriga/nvim-notify",
  "stevearc/dressing.nvim",

}, {
  rocks = { hererocks = false },
})
