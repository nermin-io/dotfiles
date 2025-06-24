return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local theme = require 'custom.themes.lualine.kanso'

    require('lualine').setup {
      options = {
        icons_enabled = vim.g.have_nerd_font,
        theme = theme,
      },
    }
  end,
}
