-- フォントずれ確認用
-- 0123456789012345678901234567890123456789
-- ｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵ
-- あいうえおあいうえおあいうえおあいうえお


vim.opt.fenc = 'utf-8'
vim.opt.undofile = true
vim.opt.termguicolors = true

vim.opt.cmdheight = 2
vim.opt.backupskip = '/tmp/*'
vim.opt.smartindent = true
vim.opt.visualbell = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.scrolloff = 3
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.hidden = true -- 編集中でも別bufferを開ける様に
vim.opt.wrap = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.wrapscan = true
vim.opt.hlsearch = true
vim.opt.inccommand = 'split'

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
vim.opt.listchars:append 'tab:▸-'

vim.api.nvim_exec('autocmd QuickFixCmdPost *grep* cwindow', false)

-- ESC連打でハイライト解除
vim.api.nvim_set_keymap("n", "<Esc><Esc>", '<CMD>nohlsearch<CR>', { silent = true })

--ターミナルで<c-w>でバッファ操作
vim.api.nvim_set_keymap("t", "<C-w><C-w>", '<C-\\><C-n>', { noremap = true, desc = '<C-w>連打でノーマルモード' })
vim.api.nvim_set_keymap("t", "<C-w>h", '<C-\\><C-n><C-w>h', { noremap = true, desc = '<C-w>hでバッファ移動' })
vim.api.nvim_set_keymap("t", "<C-w>j", '<C-\\><C-n><C-w>j', { noremap = true, desc = '<C-w>jでバッファ移動' })
vim.api.nvim_set_keymap("t", "<C-w>k", '<C-\\><C-n><C-w>k', { noremap = true, desc = '<C-w>kでバッファ移動' })
vim.api.nvim_set_keymap("t", "<C-w>l", '<C-\\><C-n><C-w>l', { noremap = true, desc = '<C-w>lでバッファ移動' })


-- vim.keymap.set("c", "P<TAB>", function() return vim.fn.expand('%:h') end, { desc = 'current dirのパスを展開' })
-- vim.keymap.set("c", "%<TAB>", function() return vim.fn.expand('%') end, { desc = 'current fileのパスを展開' })
vim.api.nvim_exec(
  [[
  cmap <expr> P<TAB> expand('%:h')
  cmap <expr> %<TAB> expand('%')
  ]], false
)


-- : Ter コマンドでBufferにterminalがあればそれを表示、なければ:terコマンド実行
function Ter()
  local buflist = vim.fn.getbufinfo({ buflisted = 1 })
  local termBufList = {}
  local msg = 'select listed terminal buffer or type N to open new terminal'
  local choices = ''
  for _, bufinfo in ipairs(buflist) do
    if string.find(bufinfo['name'], '^term://') then
      table.insert(termBufList, bufinfo)
      choices = choices ..
          '&' .. tostring(table.maxn(termBufList)) .. string.gsub(bufinfo['name'], 'term:.-:', '') .. '\n'
    end
  end
  choices = choices .. 'Type &N to open new terminal'
  if table.maxn(termBufList) == 0 then
    vim.api.nvim_cmd({ cmd = 'terminal' }, {})
  else
    local choice = vim.fn.confirm(msg, choices, 0, "General")
    if choice > table.maxn(termBufList) then
      vim.api.nvim_cmd({ cmd = 'terminal' }, {})
    elseif choice ~= 0 then
      vim.cmd({ cmd = 'buffer', args = { tostring(termBufList[choice]['bufnr']) } })
    end
  end
end

vim.api.nvim_create_user_command("Ter", function() Ter() end, {})


-- Terminal内でenter押したタイミングでbuffer名をupdate
vim.api.nvim_exec(
  [[
    function! s:set_title(prompt_pattern, max_length) abort
        let path = nvim_buf_get_name(0)
        let shell = split(fnamemodify(path, ':t'), ':')[0]
        let term_path = printf('%s/%s', fnamemodify(path, ':h'), shell)

        let prompt_line = getline(search(a:prompt_pattern, 'nbcW'))
        let prompt = matchstr(prompt_line, a:prompt_pattern)
        let cmd = prompt_line[strlen(prompt) : a:max_length]
        let cmd = substitute(cmd, '/', '\\', 'g') " fnamemodify(path, ':t') の邪魔なので置き換えちゃう

        call nvim_buf_set_name(0, printf('%s:%s', term_path, cmd))
        redrawtabline " nvim_buf_set_name()は`:file {name}`と異なり純粋にバッファ名を変えるだけなので必要に応じて
    endfunction

    tnoremap <CR> <Cmd>call <SID>set_title('^\$ ', 24)<CR><CR>
  ]], false
)

vim.api.nvim_del_keymap('n', 'Y')
vim.api.nvim_set_keymap("n", "<F1>", '<cmd>e ~/.config/nvim/init.lua<cr>', { noremap = true, desc = '<F1>でinit.luaを開く' })
vim.api.nvim_set_keymap("n", "<F2>", '<cmd>e ~/.config/nvim/lua/<cr>', { noremap = true, desc = '<F2>でluaディレクトリを開く' })


-- Neovide用の設定
function NeovideConfig()
  if vim.g.neovide then
    vim.o.guifont = "Cica:h12"
    vim.g.neovide_cursor_animation_length = 0.0
    vim.g.neovide_scroll_animation_length = 0.1
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_refresh_rate = 120

    vim.keymap.set('n', '<D-s>', ':w<CR>')      -- Save
    vim.keymap.set('v', '<D-c>', '"+y')         -- Copy
    vim.keymap.set('n', '<D-v>', '"+P')         -- Paste normal mode
    vim.keymap.set('v', '<D-v>', '"+P')         -- Paste visual mode
    vim.keymap.set('c', '<D-v>', '<C-R>+')      -- Paste command mode
    vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
    -- Allow clipboard copy paste in neovim
    vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })

    vim.g.neovide_scale_factor = 1.0
    Change_scale_factor = function(delta)
      vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-=>", function() Change_scale_factor(1.25) end)
    vim.keymap.set("n", "<C-->", function() Change_scale_factor(1/1.25) end)
  end
end

-- neovim server へ neovide から接続したときに設定を適用する
vim.api.nvim_create_autocmd({ "UIEnter" }, {
  pattern = "*",
  callback = NeovideConfig,
})



require 'plugin-config'
