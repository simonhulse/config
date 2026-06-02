return {
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

  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    dependencies = { "3rd/image.nvim", "rcarriga/nvim-notify", "stevearc/dressing.nvim" },
    init = function()
      vim.g.molten_image_provider          = "image.nvim"
      vim.g.molten_output_win_max_height   = 20
      vim.g.molten_auto_open_output        = false
      vim.g.molten_wrap_output             = true
      vim.g.molten_virt_text_output        = true
      vim.g.molten_virt_lines_off_by_1     = true
    end,
    config = function()
      local map = vim.keymap.set
      map("n", "<leader>mi", ":MoltenInit<CR>",                                     { silent = true })
      map("n", "<leader>mm", "vip:<C-u>MoltenEvaluateVisual<CR>",                   { silent = true })
      map("n", "<leader>mc", ":MoltenEvaluateOperator<CR>",                         { silent = true, expr = true })
      map("n", "<leader>ml", ":MoltenEvaluateLine<CR>",                             { silent = true })
      map("n", "<leader>mr", ":MoltenReevaluateCell<CR>",                           { silent = true })
      map("v", "<leader>mv", ":<C-u>MoltenEvaluateVisual<CR>gv",                    { silent = true })
      map("n", "<leader>md", ":MoltenDelete<CR>",                                   { silent = true })
      map("n", "<leader>mh", ":MoltenHideOutput<CR>",                               { silent = true })
      map("n", "<leader>ms", ":MoltenShowOutput<CR>",                               { silent = true })
      map("n", "<leader>me", ":MoltenExportOutput!<CR>",                            { silent = true })
      map("n", "<leader>mx", ":AsyncRun .venv/bin/jupytext --sync % && xdotool search --name '%:t:r.ipynb' key --clearmodifiers F5<CR>", { silent = true })
    end,
  },

  "rcarriga/nvim-notify",
  "stevearc/dressing.nvim",
}
