local vim = vim
return {
  {
    'goerz/jupytext.nvim',
    version = '0.2.0',
    opts = {},
  },
  {
    'benlubas/molten-nvim',
    dependencies = {
      '3rd/image.nvim'
    },
    config = function()
      vim.g.molten_image_provider = 'image.nvim'

      vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        pattern = '*.ipynb',
        callback = function()
          vim.keymap.set('n', '<M-r>', ':MoltenReevaluateCell<CR>')
          vim.keymap.set('v', '<M-r>', ':<C-u>MoltenEvaluateVisual<CR>gv')
          vim.keymap.set('n', '<M-e>', ':noautocmd MoltenEnterOutput<CR>')
        end,
      })
    end,
    build = ':UpdateRemotePlugins',
  }
}
