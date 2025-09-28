local vim = vim
return {
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set({'n'}, '<leader>oG', ':!gh browse<cr>')
      vim.keymap.set({'n'}, '<leader>og', ':!gh pr view --web<cr>')
    end,
  }
}

