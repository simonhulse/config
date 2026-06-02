return {
  "embear/vim-localvimrc",
  config = function()
    vim.g.localvimrc_enable  = 1
    vim.g.localvimrc_ask     = 0
    vim.g.localvimrc_reverse = 1
    vim.g.localvimrc_sandbox = 0
  end,
}
