local vim = vim
return {
  {
    'mrjones2014/smart-splits.nvim',
    opts = {
    },
    config = function()
      local smartSplits = require('smart-splits')
      vim.keymap.set({'n'}, '<A-h>', smartSplits.resize_left)
      vim.keymap.set({'n'}, '<A-j>', smartSplits.resize_down)
      vim.keymap.set({'n'}, '<A-k>', smartSplits.resize_up)
      vim.keymap.set({'n'}, '<A-l>', smartSplits.resize_right)
      vim.keymap.set({'n'}, '<C-h>', smartSplits.move_cursor_left)
      vim.keymap.set({'n'}, '<C-j>', smartSplits.move_cursor_down)
      vim.keymap.set({'n'}, '<C-k>', smartSplits.move_cursor_up)
      vim.keymap.set({'n'}, '<C-l>', smartSplits.move_cursor_right)
      vim.keymap.set({'n'}, '<leader>{', smartSplits.swap_buf_left)
      vim.keymap.set({'n'}, '<leader>}', smartSplits.swap_buf_right)
    end,
  },
}

