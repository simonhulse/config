return {
  "neoclide/coc.nvim",
  branch = "release",
  config = function()
    local keyset = vim.keymap.set

    function _G.check_back_space()
      local col = vim.fn.col('.') - 1
      return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
    end

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
}
