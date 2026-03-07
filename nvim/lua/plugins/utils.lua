local vim = vim
return {
  { 'MeanderingProgrammer/render-markdown.nvim' },
  {
    'MeanderingProgrammer/treesitter-modules.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('render-markdown').setup({
        code = {
          left_pad = 2,
          right_pad = 2,
        },
      })
      require('treesitter-modules').setup({
        auto_install = false,
      })
      vim.api.nvim_set_hl(0, 'RenderMarkdownCode', {
        bg = '#111111',
      })
    end,
  }
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-tree/nvim-web-devicons' },
  { 'nvim-treesitter/nvim-treesitter' },
  {
    'nvim-zh/colorful-winsep.nvim',
    opts = {
      border = 'single',
      highlight = 'gray',
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
