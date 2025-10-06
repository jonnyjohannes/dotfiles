local vim = vim
return {
  {
    'folke/snacks.nvim',
    opts = {
      indent = {
        animate = {
          enabled = false
        },
      },
      input = {
        win = {
          relative = 'cursor',
          row = 1,
          col = 0,
        },
      },
      explorer = {
        enabled = false
      },
      picker = {
        layout = {
          preview = false,
          layout = {
            box = 'vertical',
            backdrop = true,
            row = -1,
            width = 0,
            height = 12,
            border = 'single',
            title = ' {title} {live} {flags}',
            title_pos = 'left',
            {
              box = 'horizontal',
              { win = 'list', border = 'none' },
              { win = 'preview', title = '{preview}', width = 0.6, border = 'left' },
            },
            { win = 'input', height = 1, border = 'top' },
          },
        },
      },
      gitbrowse = {
        enabled = true
      },
      statuscolumn = {
        enabled = true
      },
      terminal = {
        enabled = true
      },
    },
    config = function(_, opts)
      require('snacks').setup(opts)
      local Snacks = Snacks
      local aliases = require('configs.aliases')
      local snacksPickerAliases = function()
        Snacks.picker({
          items = aliases,
          format = 'text',
          confirm = 'item_action',
          title = 'Aliases',
        })
      end

      vim.keymap.set({'n', 't'}, '<M-i>', Snacks.terminal.toggle)
      vim.keymap.set({'n', 'x'}, '<leader>:', Snacks.picker.command_history)
      vim.keymap.set({'n', 'x'}, '<leader>/', Snacks.picker.grep)
      vim.keymap.set({'n', 'x'}, '<leader>*', Snacks.picker.grep_word)
      vim.keymap.set({'n', 'x'}, '<leader>f', snacksPickerAliases)
      vim.keymap.set({'n', 'x'}, '<leader>s', Snacks.picker.smart)
    end,
  }
}
