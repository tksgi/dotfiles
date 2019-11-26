function! EvalCodeBlock()
  let block_start = search('^[`]\{3}\S*\s*$', 'bnW')
  let block_end = search('^[`]\{3}', 'nW')
  if !block_start || !block_end
    return
  endif
  let language = matchlist(getline(block_start), '\([`]\{3}\)\(\S\+\)\?')[2]
  if language == 'result'
    return
  end
  execute block_start + 1 ',' block_end - 1 "QuickRun " language


  " 変数内に結果が代入されるまでにラグがあるっぽい-> エラー
  " execute block_start + 1 ',' block_end - 1 "QuickRun " language '-outputter variable:name=output'
  " call append(block_end, ['', '```result'])
  " call append(block_end + 2, split(output, '\(\r\|\n\)') + ['```'])

endfunction

nnoremap <buffer> <C-c><C-c> :<C-U>call EvalCodeBlock()<CR>

" スニペットの方が楽？
iab <buffer> `R ```ruby<CR><CR>```<UP>
iab <buffer> `P ```python<CR><CR>```<UP>
iab <buffer> `S ```shell<CR><CR>```<UP>

command! TableFormat :Tabularize /|

" table整形 with Tabular
" inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
"
" function! s:align()
"   let p = '^\s*|\s.*\s|\s*$'
"   if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
"     let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
"     let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
"     Tabularize/|/l1
"     normal! 0
"     call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
"   endif
" endfunction
