local vim = vim
return {
  {
    'ibhagwan/fzf-lua',
    opts = {
      fzf_opts = {
        ['--layout'] = 'reverse-list',
      },
      keymap = {
        builtin = {
          ['<c-d>'] = 'preview-page-down',
          ['<c-u>'] = 'preview-page-up',
        },
      },
      builtin = {
        winopts = {
          height = 0.4,
          width = 1.0
        }
      },
      winopts = {
        border = 'single',
        preview = {
          border = 'single',
          horizontal = 'right:60%',
          vertical = 'up:50%',
        },
        height = 0.4,
        width = 1,
        row = 1,
        col = 0,
      },
    },
    config = function(_, opts)
      local fzfLua = require('fzf-lua')
      fzfLua.setup(opts)
      vim.keymap.set({'n'}, '<leader>:', fzfLua.command_history)
      vim.keymap.set({'n'}, '<leader>/', fzfLua.blines)
      vim.keymap.set({'n'}, '<leader>f', fzfLua.builtin)
      vim.keymap.set({'n'}, '<leader>g', fzfLua.live_grep)
      vim.keymap.set({'x'}, '<leader>g', fzfLua.grep_visual)
      vim.keymap.set({'n'}, '<leader>s', function()
        fzfLua.combine({ pickers = 'buffers;files', line_query=true })
      end)
    end,
  },
}

