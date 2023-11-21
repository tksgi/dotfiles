local config = function()
  require('orgmode').setup({
    org_agenda_files = '~/orgfiles/**/*',
    org_default_notes_file = '~/orgfiles/refille.org',
  })
end
local build = function()
  local dir_path = '~/orgfiles'
  if vim.fn.empty(vim.fn.glob(dir_path)) > 0 then
    vim.fn.system({ 'mkdir', '-p', dir_path })
    vim.fn.system({ 'mkdir', '-p', dir_path })
  end
end

---@type LazySpec
local spec = {
  'nvim-orgmode/orgmode',
  dependencies = { 'nvim-treesitter', { 'akinsho/org-bullets.nvim', config = true } },
  config = config,
  build = build,
}
return spec
