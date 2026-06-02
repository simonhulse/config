return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
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
}
