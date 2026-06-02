vim.opt_local.commentstring = "% %s"
vim.opt_local.iskeyword:append(":")

vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
vim.api.nvim_set_hl(0, "SpellBad", { underline = true })

local spellfile = vim.fn.getcwd() .. "/vimspell.utf-8.add"
if vim.fn.filereadable(spellfile) == 1 then
  vim.opt_local.spellfile = spellfile
end
