return {
  "embear/vim-localvimrc",
  -- init, not config: the plugin reads these globals when it loads, which is
  -- before lazy.nvim runs config
  init = function()
    vim.g.localvimrc_enable  = 1
    vim.g.localvimrc_reverse = 1
    vim.g.localvimrc_sandbox = 0
  end,
}
