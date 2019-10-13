function! hook#add#denite#load() abort
  nnoremap [denite] <Nop>
  nmap <C-s> [denite]

  "現在開いているファイルのディレクトリ下のファイル一覧。
  nnoremap <silent> [denite]f :<C-u>DeniteBufferDir
        \ -direction=topleft -cursor-wrap=true file file:new<CR>
  "バッファ一覧
  nnoremap <silent> [denite]b :<C-u>Denite -direction=topleft -cursor-wrap=true buffer<CR>
  "レジスタ一覧
  nnoremap <silent> [denite]r :<C-u>Denite -direction=topleft -cursor-wrap=true -buffer-name=register register<CR>
  "最近使用したファイル一覧
  nnoremap <silent> [denite]m :<C-u>Denite -direction=topleft -cursor-wrap=true file_mru<CR>
  "ブックマーク一覧
  nnoremap <silent> [denite]c :<C-u>Denite -direction=topleft -cursor-wrap=true bookmark<CR>
  "ブックマークに追加
  nnoremap <silent> [denite]a :<C-u>DeniteBookmarkAdd<CR>

  ".git以下のディレクトリ検索
  nnoremap <silent> [denite]k :<C-u>Denite -direction=topleft -cursor-wrap=true
        \ -path=`substitute(finddir('.git', './;'), '.git', '', 'g')`
        \ file_rec/git<CR>

  call denite#custom#source('file'    , 'matchers', ['matcher_cpsm', 'matcher_fuzzy'])

  call denite#custom#source('buffer'  , 'matchers', ['matcher_regexp'])
  call denite#custom#source('file_mru', 'matchers', ['matcher_regexp'])

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
  endfunction



  let s:denite_win_height_percent = 0.7
  " Change denite default options
  call denite#custom#option('default', {
      \ 'split': 'horizontal',
      \ 'winheight': 10,
      \ })
endfunction
