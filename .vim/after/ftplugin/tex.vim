setlocal commentstring=%\ %s
setlocal iskeyword+=:
setlocal spell spelllang=en_us
hi clear SpellBad
hi SpellBad cterm=underline

let s:spellfile = getcwd() . '/vimspell.utf-8.add'
if filereadable(s:spellfile)
  let &l:spellfile = s:spellfile
endif
