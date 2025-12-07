---@type LazySpec
local spec = {
  'martineausimon/nvim-lilypond-suite',
  opts = {
    player = {
      options = {
        soundfont_path = "/etc/timidity/fluidr3_gm.cfg"
      }
    }
  }
}
return spec
