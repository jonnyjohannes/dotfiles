local vim = vim
return {
  { 'nvim-tree/nvim-web-devicons' },
  { 'nvim-lua/plenary.nvim' },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    config = function()
      require('render-markdown').setup({
        code = {
          left_pad = 2,
          right_pad = 2,
        },
      })
      vim.api.nvim_set_hl(0, "RenderMarkdownCode", {
        bg = "#111111",
      })
    end,
  },
  {
    "mohseenrm/marko.nvim",
    config = function()
      require("marko").setup()
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup({
        auto_install = true,
        highlight = { enable = true, },
        indent = { enable = true },
      })
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.opt.foldlevel = 99
      vim.opt.foldenable = true
    end,
  },
}

