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
          height = 12,
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
        preview = {
          border = 'single',
          horizontal = 'right:60%',
          vertical = 'up:50%',
        },
        border = 'single',
        height = 12,
        width = 1,
        row = 1,
        col = 0,
      },
    },
  --   config = function(_, opts)
  --     local fzfLua = require('fzf-lua')
  --     local aliases = require('configs.aliases')
  --     local function fzfLuaAliases()
  --       fzfLua.fzf_exec(
  --         vim.tbl_map(function(alias) return alias.text end, aliases),
  --         {
  --           actions = {
  --             ['default'] = function(selected)
  --               print(selected[1])
  --               for _, alias in ipairs(aliases) do
  --                 if alias.text == selected[1] then
  --                   alias.action()
  --                 end
  --               end
  --             end,
  --           }
  --         }
  --       )
  --     end
  --     fzfLua.setup(opts)
  --
  --     vim.keymap.set({'n', 'x'}, '<leader>:', fzfLua.command_history)
  --     vim.keymap.set({'n', 'x'}, '<leader>/', fzfLua.live_grep)
  --     vim.keymap.set({'n'}, '<leader>*', fzfLua.grep_cword)
  --     vim.keymap.set({'x'}, '<leader>*', fzfLua.grep_visual)
  --     vim.keymap.set({'n', 'x'}, '<leader>f', fzfLuaAliases)
  --     vim.keymap.set({'n', 'x'}, '<leader>s', function()
  --       fzfLua.combine({ pickers = 'buffers;files', line_query=true })
  --     end)
  --   end,
  },
}

