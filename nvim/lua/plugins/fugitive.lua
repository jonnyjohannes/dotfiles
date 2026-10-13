return {
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set({'n', 't'}, '<M-g>', '<C-\\><C-n><cmd>G<cr>')
    end,
  }
}

