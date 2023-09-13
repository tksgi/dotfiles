vim.api.nvim_exec(
  [[
    noremap <buffer> p  <CR>zz<C-w>p
    noremap <buffer> <C-o>  :<C-u>colder<CR>
    noremap <buffer> <C-i>  :<C-u>cnewer<CR>

    function! s:jk(motion)
      let max = line('$')
      let list = getloclist(0)
      if empty(list) || len(list) != max
        let list = getqflist()
      endif
      let cur = line('.') - 1
      let pos = g:V.modulo(cur + a:motion, max)
      let m = 0 < a:motion ? 1 : -1
      while cur != pos && list[pos].bufnr == 0
        let pos = g:V.modulo(pos + m, max)
      endwhile
      return (pos + 1) . 'G'
    endfunction

    setlocal statusline+=\ %L

    nnoremap <silent> <buffer> dd :call <SID>del_entry()<CR>
    nnoremap <silent> <buffer> x :call <SID>del_entry()<CR>
    vnoremap <silent> <buffer> d :call <SID>del_entry()<CR>
    vnoremap <silent> <buffer> x :call <SID>del_entry()<CR>
    nnoremap <silent> <buffer> u :<C-u>call <SID>undo_entry()<CR>

    if exists('*s:undo_entry')
      finish
    endif

    function! s:undo_entry()
      let history = get(w:, 'qf_history', [])
      if !empty(history)
        call setqflist(remove(history, -1), 'r')
      endif
    endfunction

    function! s:del_entry() range
      let qf = getqflist()
      let history = get(w:, 'qf_history', [])
      call add(history, copy(qf))
      let w:qf_history = history
      unlet! qf[a:firstline - 1 : a:lastline - 1]
      call setqflist(qf, 'r')
      execute a:firstline
    endfunction
  ]], false
)
