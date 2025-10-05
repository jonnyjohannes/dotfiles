local vim = vim
return {
  {
    'ibhagwan/fzf-lua',
    opts = {
      fzf_opts = {
        ['--layout'] = 'reverse-list',
      },
      builtin = {
        winopts = {
          border = 'single',
          height = 0.3,
          width = 1,
          row = 1,
          col = 0,
        },
      },
      keymap = {
        builtin = {
          ['<c-d>'] = 'preview-page-down',
          ['<c-u>'] = 'preview-page-up',
        },
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
    config = function(_, opts)
      local fzfLua = require('fzf-lua')
      local aliases = require('configs.aliases')
      local function alias_picker()
        fzfLua.fzf_exec(
          vim.tbl_map(function(alias) return alias.name end, aliases.aliases),
          {
            prompt = '(⌐■_■) ',
            actions = {
              ['default'] = function(selected)
                aliases.get_alias(selected[1]).action()
              end,
            }
          }
        )
      end
      fzfLua.setup(opts)
      vim.keymap.set({'n'}, '<leader>:', fzfLua.command_history)
      vim.keymap.set({'n'}, '<leader>/', fzfLua.blines)
      vim.keymap.set({'n'}, '<leader>*', fzfLua.grep_cword)
      vim.keymap.set({'n'}, '<leader>f', alias_picker)
      vim.keymap.set({'n'}, '<leader>g', fzfLua.live_grep)
      vim.keymap.set({'x'}, '<leader>g', fzfLua.grep_visual)
      vim.keymap.set({'n'}, '<leader>s', function()
        fzfLua.combine({ pickers = 'buffers;files', line_query=true })
      end)
    end,
  },
}

