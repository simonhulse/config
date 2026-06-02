return {
  "SirVer/ultisnips",
  config = function()
    vim.g.UltiSnipsExpandTrigger       = "<esc>"
    vim.g.UltiSnipsJumpForwardTrigger  = "<c-j>"
    vim.g.UltiSnipsJumpBackwardTrigger = "<c-k>"
    vim.g.UltiSnipsEditSplit           = "vertical"
    vim.g.UltiSnipsListSnippets        = "<c-tab>"
    vim.g.UltiSnipsSnippetDirectories  = { vim.env.HOME .. "/.config/snippets" }
    vim.keymap.set("x", "<Esc>", "<Esc>", { noremap = true })
  end,
}
