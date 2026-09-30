local vim = vim
return {
  { 'MeanderingProgrammer/render-markdown.nvim' },
  {
    'MeanderingProgrammer/treesitter-modules.nvim',
    config = function()
      require('render-markdown').setup({
        code = {
          left_pad = 2,
          right_pad = 2,
        },
        heading = {
          enabled = false,
        },
        custom_handlers = require('customs.markdown-constellation').handlers(),
      })
      require('treesitter-modules').setup({
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-tree/nvim-web-devicons' },
  { 'nvim-treesitter/nvim-treesitter' },
  {
    'nvim-zh/colorful-winsep.nvim',
    opts = {
      border = 'single',
      highlight = 'white',
      animate = {
        enabled = false,
      },
      indicator_for_2wins = {
        position = false,
      },
    },
    config = true,
    event = { 'WinLeave' },
  },
}
