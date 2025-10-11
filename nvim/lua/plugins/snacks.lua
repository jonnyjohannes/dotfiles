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
        enabled = false,
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
            max_height = 12,
            min_height = 12,
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
        win = {
          input = {
            keys = {
              ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
            },
          },
        },
      },
      gitbrowse = {
        enabled = true
      },
      scratch = {
        ft = 'markdown',
        win = {
          width = 90,
          height = 0.95,
          border = 'single',
          backdrop = {
            transparent = true,
            blend = 80,
          },
        },
      },
      statuscolumn = {
        enabled = true
      },
      terminal = {
        enabled = true
      },
      zen = {
        zoom = {
          win = {
            width = 90,
            height = 0.95,
            border = 'none',
            backdrop = {
              transparent = false,
              blend = 99,
            },
          }
        }
      },
    },
    config = function(_, opts)
      local Snacks = require('snacks')
      Snacks.setup(opts)

      vim.keymap.set({'n', 't', 'x'}, '<M-n>', Snacks.scratch.open)
      vim.keymap.set({'n', 't', 'x'}, '<M-t>', Snacks.terminal.toggle)
      vim.keymap.set({'n', 't', 'x'}, '<M-z>', Snacks.zen.zoom)

      local aliases = require('configs.aliases')
      local unifiedPickerSelector = function()
        local items = {}

        for _, alias in ipairs(aliases) do
          table.insert(items, {
            text = alias.text,
            action = alias.action,
            type = 'alias'
          })
        end

        for name, func in pairs(Snacks.picker) do
          table.insert(items, {
            text = name,
            action = function() func() end,
            type = 'picker'
          })
        end

        Snacks.picker({
          items = items,
          format = 'text',
          confirm = 'item_action',
          title = ' Pickers & Aliases ',
        })
      end

      vim.api.nvim_create_user_command('S', function(others)
        local picker = others.fargs[1]
        if not picker or picker == "" then
          unifiedPickerSelector()
          return
        end

        for _, alias in ipairs(aliases) do
          if alias.text == picker then
            alias.action()
            return
          end
        end

        Snacks.picker[picker]()
      end, {
          nargs = '?',
          complete = function(ArgLead)
            local completions = {}

            for _, alias in ipairs(aliases) do
              if vim.startswith(alias.text, ArgLead) then
                table.insert(completions, alias.text)
              end
            end

            for k, _ in pairs(Snacks.picker) do
              if vim.startswith(k, ArgLead) then
                table.insert(completions, k)
              end
            end

            return completions
          end,
          desc = 'Call a Snacks.nvim picker by name or execute an alias'
        })

      -- vim.keymap.set({'n', 'x'}, '<leader>:', Snacks.picker.command_history)
      -- vim.keymap.set({'n', 'x'}, '<leader>/', Snacks.picker.grep)
      -- vim.keymap.set({'n', 'x'}, '<leader>*', Snacks.picker.grep_word)
      -- vim.keymap.set({'n', 'x'}, '<leader>s', Snacks.picker.smart)
    end
  }
}
