local galaxyline = require'galaxyline'

local colors = {
  bg = '#282c34',
  fg = '#092236',
  white = '#c3ccdc',
  yellow = '#fabd2f',
  cyan = '#008080',
  darkblue = '#092236',
  green = '#afd700',
  orange = '#FF8800',
  purple = '#ae81ff',
  magenta = '#d16d9e',
  grey = '#c0c0c0',
  blue = '#82aaff',
  cadetblue = '#a1aab8',
  slateblue = '#2c3043'
}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

galaxyline.section.left[1] = {
  FirstElement = {
    provider = function() return ' ' end,
    highlight = { colors.blue, colors.blue }
  }
}

galaxyline.section.left[2] = {
  ViMode = {
    provider = function()
    local alias = { n = 'NORMAL', i = 'INSERT', c= 'COMMAND', V= 'L-VISUAL', [''] = 'B-VISUAL', v = 'VISUAL' }
    return alias[vim.fn.mode()] .. ' '
    end,
    separator = ' ',
    separator_highlight = { colors.blue, colors.slateblue },
    highlight = { colors.fg, colors.blue, 'bold' },
  }
}
