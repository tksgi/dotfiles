function! hook#add#denite#load() abort
  " nnoremap [denite] <Nop>
  " nmap <C-s> [denite]

  " "ブックマーク関連
  " nnoremap [denite-dirmark] <Nop>
  " nmap [denite]<C-b> [denite-dirmark]
  " "ブックマーク一覧
  " nnoremap <silent> [denite-dirmark]l :<C-u>Denite dirmark<CR>
  " "ブックマークに追加
  " nnoremap <silent> [denite-dirmark]a :<C-u>Denite dirmark/add<CR>

  nnoremap <leader>df <cmd>Denite file/rec<CR>
  nnoremap <leader>db <cmd>Denite buffer<cr>
  nnoremap <leader>dm <cmd>Denite file_mru<cr>
  nnoremap <leader>dgr <cmd>Denite grep<cr>
  nnoremap <leader>dh <cmd>Denite help<cr>
  nnoremap <leader>dr <cmd>Denite -resume<cr>

  nnoremap <leader>dgl <cmd>Denite gitlog:all<cr>
  nnoremap <leader>dgs <cmd>Denite gitstatus<cr>
  nnoremap <leader>dgb <cmd>Denite gitbranch<cr>

  call denite#custom#source('file'    , 'matchers', ['matcher_fuzzy'])
  call denite#custom#source('buffer'  , 'matchers', ['matcher_fuzzy'])
  call denite#custom#source('file_mru', 'matchers', ['matcher_fuzzy'])

  " call denite#custom#alias('source', 'file_rec/git', 'file_rec')
  if executable('ag')
    call denite#custom#var('file_rec/git', 'command',
          \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
  elseif executable('rg')
    call denite#custom#var('file/rec', 'command',
          \ ['rg', '--files', '--glob', '!.git'])
  endif

  if executable('rg')
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts',
          \ ['-i', '--vimgrep', '--no-heading'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
  endif

  call denite#custom#map('insert', '<C-N>', '<denite:move_to_next_line>', 'noremap')
  call denite#custom#map('insert', '<C-P>', '<denite:move_to_previous_line>', 'noremap')
  call denite#custom#map('insert', '<C-W>', '<denite:move_up_path>', 'noremap')

  autocmd FileType denite call s:denite_my_settings()
  function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q denite#do_map('quit')
    nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'

    " for git
    nnoremap <silent><buffer><expr> a denite#do_map('do_action', 'add')
    nnoremap <silent><buffer><expr> r denite#do_map('do_action', 'reset')
  endfunction



  let s:denite_win_height_percent = 0.7
  " Change denite default options
  call denite#custom#option('default', {
      \ 'split': 'horizontal',
      \ 'winheight': 10,
      \ })

  " grepする
  command! Dgrep execute(":Denite grep -buffer-name=grep-buffer-denite")
  " Denite grep結果を再表示する
  command! Dresume execute(":Denite -resume -buffer-name=grep-buffer-denite")
  " resumeしたgrep結果の次の行の結果へ飛ぶ
  command! Dnext execute(":Denite -resume -buffer-name=grep-buffer-denite -select=+1 -immediately")
  " resumeしたgrep結果の前の行の結果へ飛ぶ
  command! Dprev execute(":Denite -resume -buffer-name=grep-buffer-denite -select=-1 -immediately")
endfunction
