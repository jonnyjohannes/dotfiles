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
          height = 14,
          width = 1,
          row = 1,
          col = 0,
        },
      },
      keymap = {
        builtin = {
          ['<C-d>'] = 'preview-page-down',
          ['<C-u>'] = 'preview-page-up',
          ['<M-p>'] = 'toggle-preview',
        },
      },
      winopts = {
        preview = {
          hidden = true,
          border = 'single',
          horizontal = 'right:60%',
          vertical = 'up:50%',
        },
        title_pos = 'left',
        border = 'single',
        height = 14,
        width = 1,
        row = 1,
        col = 0,
      },
    },
    config = function(_, opts)
      local fzfLua = require('fzf-lua')
      fzfLua.setup(opts)

      local function fzfLuaAliases()
        local items = require('configs.aliases')
        fzfLua.fzf_exec(
          vim.tbl_map(function(item) return item.text end, items),
          {
            actions = {
              ['default'] = function(selected)
                for _, item in ipairs(items) do
                  if item.text == selected[1] then
                    item.action()
                  end
                end
              end,
            },
            winopts = {
              title = ' Aliases ',
            },
          }
        )
      end

      vim.keymap.set({'n', 'x'}, '<leader>:', fzfLua.command_history)
      vim.keymap.set({'n', 'x'}, '<leader>/', fzfLua.live_grep)
      vim.keymap.set({'n'}, '<leader>*', fzfLua.grep_cword)
      vim.keymap.set({'x'}, '<leader>*', fzfLua.grep_visual)
      vim.keymap.set({'n', 'x'}, '<leader>', fzfLuaAliases)
      vim.keymap.set({'n', 'x'}, '<leader>s', function()
        fzfLua.combine({ pickers = 'buffers;files', line_query=true })
      end)
    end,
  },
}

