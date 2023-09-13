local buflist = vim.fn.getbufinfo()
local termBufList = {}
local msg = 'select listed terminal buffer or type N to open new terminal'
local choices = ''
for _, bufinfo in ipairs(buflist) do
  print(bufinfo['name'])
  if string.find(bufinfo['name'], '^term://') then
    table.insert(termBufList, bufinfo)
    choices = choices .. '&' .. tostring(table.maxn(termBufList)) .. string.gsub(bufinfo['name'], 'term:.-:', '') .. '\n'
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
    vim.cmd({ cmd = 'buffer', args = { tostring(termBufList[choice]['bufnr']) }})
  end
end
