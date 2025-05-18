return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000,
  config = function()
    require('gruvbox').setup {
      terminal_colors = true,
      undercurl = true,
      underline = true,
      italic = {
        strings = false,
        comments = true,
        operators = false,
        folds = true,
        emphasis = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_intend_guides = false,
      contrast = 'hard',
    }
    vim.o.background = 'dark'
    vim.cmd 'colorscheme gruvbox'
  end,
}
