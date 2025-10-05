local vim = vim
return {
  {
    'jpalardy/vim-slime',
    config = function()
      vim.g.slime_target = 'tmux'
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_default_config = {
        socket_name = 'default',
        target_pane = '{last}'
      }
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_python_ipython = 1
      vim.g.slime_no_mappings = 1

      vim.keymap.set({'n'}, '<leader>dl', ':SlimeSendCurrentLine<cr>')
      vim.keymap.set({'x'}, '<leader>dl', ':SlimeSend<cr>')
      vim.keymap.set({'n'}, '<leader>dL', ':%SlimeSend<cr>')
      vim.keymap.set({'x'}, '<leader>dL', ':SlimeSend<cr>')
    end,
  },
}

