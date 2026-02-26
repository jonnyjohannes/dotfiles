local vim = vim
return {
  {
    'chrisgrieser/nvim-various-textobjs',
    event = 'VeryLazy',
    opts = {
      keymaps = {
        useDefaults = true,
      },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    config = function()
      require('render-markdown').setup({
        code = {
          left_pad = 2,
          right_pad = 2,
        },
      })
      vim.api.nvim_set_hl(0, 'RenderMarkdownCode', {
        bg = '#111111',
      })
    end,
  },
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-tree/nvim-web-devicons' },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    opts = {
      ensure_installed = { 'markdown', 'markdown_inline' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'markdown' },
      },
      indent = { enable = true },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.opt.foldlevel = 99
      vim.opt.foldenable = true
    end,
  },
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
