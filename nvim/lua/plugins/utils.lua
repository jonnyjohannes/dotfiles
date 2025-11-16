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
    dependencies = {
      'RRethy/nvim-treesitter-textobjects',
    },
    config = function()
      require('nvim-treesitter.configs').setup({
        auto_install = true,
        highlight = { enable = true, },
        indent = { enable = true },
        textobjects = {
          select = {
            enable = true,
            disable = {
              'lua',
            },
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ['as'] = '@local.scope',
            },
          },
        },
      })
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
