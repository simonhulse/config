return {
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
}
