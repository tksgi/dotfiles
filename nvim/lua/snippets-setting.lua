local snippets = require'snippets'
local U = require'snippets.utils'

snippets.use_suggested_mappings()

-- C-Kでexpand and jump
-- vim.fn.nvim_set_keymap('i', '<c-k>', [[<cmd>lua return require'snippets'.expand_or_advance(1)<CR>]], { noremap: true });
-- C-Jで前のfieldにjump
-- vim.fn.nvim_set_keymap('i', '<c-j>', [[<cmd>lua return require'snippets'.advance_snippet(-1)<CR>]], {})

vim.api.nvim_exec(
  [[
  " <c-k> will either expand the current snippet at the word or try to jump to
  " the next position for the snippet.
  inoremap <c-k> <cmd>lua return require'snippets'.expand_or_advance(1)<CR>

  " <c-j> will jump backwards to the previous field.
  " If you jump before the first field, it will cancel the snippet.
  " inoremap <c-K> <cmd>lua return require'snippets'.advance_snippet(-1)<CR>
  ]],
  false
)

snippets.set_ux(require'snippets.inserters.text_markers')

snippets.snippets = {
  _global = {
    todo = 'TODO(tksgi): ';
    uname = function() return vim.loop.os_uname().sysname end;
    date = os.date;
    epoch = function() return os.time() end;
  },
  lua = {
    req = [[local ${2:${1|S.v:match"([^.()]+)[()]*$"}} = require '$1']];
    func = [[function${1|vim.trim(S.v):gsub("^%S"," %0")}(${2|vim.trim(S.v)})$0 end]];
    ["local"] = [[local ${2:${1|S.v:match"([^.()]+)[()]*$"}} = ${1}]];
    -- Match the indentation of the current line for newlines.
    ["for"] = U.match_indentation [[
for ${1:i}, ${2:v} in ipairs(${3:t}) do
  $0
end]];
  },
  dart = {
    req = [[require '$1';]];
    func = U.match_indentation [[${1} ${2}(${3}) {
    return ${4}();
    }]];
    widgetFunc = U.match_indentation [[Widget ${1}(${2}) {
    return ${3}();
    }]];
    build = U.match_indentation [[@override
    Widget build(BuildContext context){
    return ${1}();
    }]];
    statelessWidget = U.match_indentation [[class ${1} extends StatelessWidget {
    ${1}();

    @override
    Widget build(BuildContext context){
    return ${2}();
    }
    }]];
    ['if'] = U.match_indentation [[if (${1}) {
    ${2}
    }]];
    lambda = [[(${1}) => ${2}]];
    get = [[${1} get ${2}{
    ${3}
    }]];
    getl = [[${1} get ${2} => ${3: _${2}};]];
    set = [[set ${1}(${2}){
    ${3}
    }]];
    setl = [[set ${1}(${2}) => ${3};]];
    map = U.match_indentation [[map((${1:i}) {
    ${2}
    })]];
    mapl = [[map((${1:i}) => ${2})]];
  }
}
