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
      local aliases = require('configs.aliases')

      local unifiedFzfPicker = function()
        local items = {}
        local item_map = {}

        for _, alias in ipairs(aliases) do
          local display_text = alias.text
          table.insert(items, display_text)
          item_map[display_text] = {
            action = alias.action,
            type = 'alias'
          }
        end

        for name, func in pairs(fzfLua) do
          table.insert(items, name)
          item_map[name] = {
            action = func,
            type = 'picker'
          }
        end

        fzfLua.fzf_exec(items, {
          actions = {
            ['default'] = function(selected)
              local item = item_map[selected[1]]
              if item then
                item.action()
              end
            end,
          },
          winopts = {
            title = ' Pickers & Aliases ',
          },
        })
      end

      -- Create F command (existing functionality)
      vim.api.nvim_create_user_command('F', function(others)
        local picker = others.fargs[1]
        if not picker or picker == "" then
          unifiedFzfPicker()
          return
        end

        for _, alias in ipairs(aliases) do
          if alias.text == picker then
            alias.action()
            return
          end
        end

        fzfLua[picker]()
      end, {
          nargs = '?',
          complete = function(ArgLead)
            local completions = {}

            for _, alias in ipairs(aliases) do
              if vim.startswith(alias.text, ArgLead) then
                table.insert(completions, alias.text)
              end
            end

            for k, _ in pairs(fzfLua) do
              if vim.startswith(k, ArgLead) then
                table.insert(completions, k)
              end
            end

            return completions
          end,
          desc = 'Call a fzf-lua picker by name or execute an alias'
        })

      vim.keymap.set({'n', 'x'}, '<leader>:', fzfLua.command_history)
      vim.keymap.set({'n', 'x'}, '<leader>/', fzfLua.live_grep)
      vim.keymap.set({'n'}, '<leader>*', fzfLua.grep_cword)
      vim.keymap.set({'x'}, '<leader>*', fzfLua.grep_visual)
      vim.keymap.set({'n', 'x'}, '<leader>s', function()
        fzfLua.combine({ pickers = 'buffers;files', line_query=true })
      end)
    end,
  },
}

