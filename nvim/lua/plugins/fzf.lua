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
          height = 0.3,
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
        height = 0.3,
        width = 1,
        row = 1,
        col = 0,
      },
    },
  },
}

