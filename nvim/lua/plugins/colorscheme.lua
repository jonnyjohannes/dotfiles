local vim = vim
return {
  {
    'rose-pine/neovim',
    opts = {
      variant = 'main',
      palette = {
        main = {
          base = '#1f1f1f',
          overlay = '#363738',
          surface = '#1e1e1e',
        },
      },
    },
    config = function(_, opts)
      require('rose-pine').setup(opts)
      vim.cmd('colorscheme rose-pine')
      vim.api.nvim_set_hl(0, "Visual", { reverse = true })
    end,
  },
}

