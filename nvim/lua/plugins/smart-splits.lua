local vim = vim
return {
  {
    'smart-splits-nvim/smart-splits.nvim',
    opts = {
      mux = { backend = 'smart-splits-backend-tmux' },
      move = { at_edge = 'split' },
    },
    dependencies = {
      { 'smart-splits-nvim/backend-tmux', main = 'smart-splits-backend-tmux' },
    },
    config = function(_, opts)
      local smartSplits = require('smart-splits')
      smartSplits.setup(opts)

      vim.keymap.set({ 'n', 't', 'x' }, '<C-h>', smartSplits.move_cursor_left)
      vim.keymap.set({ 'n', 't', 'x' }, '<C-j>', smartSplits.move_cursor_down)
      vim.keymap.set({ 'n', 't', 'x' }, '<C-k>', smartSplits.move_cursor_up)
      vim.keymap.set({ 'n', 't', 'x' }, '<C-l>', smartSplits.move_cursor_right)

      vim.keymap.set({ 'n', 't', 'x' }, '<M-h>', smartSplits.resize_left)
      vim.keymap.set({ 'n', 't', 'x' }, '<M-j>', smartSplits.resize_down)
      vim.keymap.set({ 'n', 't', 'x' }, '<M-k>', smartSplits.resize_up)
      vim.keymap.set({ 'n', 't', 'x' }, '<M-l>', smartSplits.resize_right)
    end,
  },
}
