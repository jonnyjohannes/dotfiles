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
      statuscolumn = {
        enabled = true
      },
      terminal = {
        enabled = true
      },
      zen = {
        win = {
          width = 100,
          height = 0.9,
          backdrop = { blend = 0 },
        }
      },
    },
    config = function(_, opts)
      local Snacks = require('snacks')
      Snacks.setup(opts)

      vim.keymap.set({'n', 't'}, '<M-i>', Snacks.terminal.toggle)
      vim.keymap.set({'n', 'x'}, '<M-Z>', Snacks.zen.zen)

      local aliases = require('configs.aliases')
      local snacksPickerAliases = function()
        Snacks.picker({
          items = aliases,
          format = 'text',
          confirm = 'item_action',
          title = 'Aliases',
        })
      end

      local unifiedPickerSelector = function()
        local items = {}

        -- Add aliases to the list
        for _, alias in ipairs(aliases) do
          table.insert(items, {
            text = alias.text,
            action = alias.action,
            type = 'alias'
          })
        end

        -- Add Snacks picker functions to the list
        for name, func in pairs(Snacks.picker) do
          if type(func) == 'function' and name ~= 'pickers' then
            table.insert(items, {
              text = '[Picker] ' .. name,
              action = function() func() end,
              type = 'picker'
            })
          end
        end

        Snacks.picker({
          items = items,
          format = 'text',
          confirm = 'item_action',
          title = 'Pickers & Aliases',
        })
      end

      vim.api.nvim_create_user_command('S', function(others)
        local picker = others.fargs[1]
        if not picker or picker == "" then
          unifiedPickerSelector()
          return
        end

        -- Check if the picker matches an alias first
        for _, alias in ipairs(aliases) do
          if alias.text == picker then
            alias.action()
            return
          end
        end

        -- If not an alias, check for Snacks picker function
        local picker_func = Snacks.picker and Snacks.picker[picker]
        if type(picker_func) == 'function' then
          picker_func()
        else
          vim.notify(('No Snacks picker or alias found: %s'):format(picker), vim.log.levels.ERROR)
        end
      end, {
          nargs = '?',
          complete = function(ArgLead)
            local completions = {}

            -- Add aliases to completion
            for _, alias in ipairs(aliases) do
              if vim.startswith(alias.text, ArgLead) then
                table.insert(completions, alias.text)
              end
            end

            -- Add Snacks picker functions to completion
            for k, v in pairs(Snacks.picker) do
              if type(v) == 'function' and vim.startswith(k, ArgLead) then
                table.insert(completions, k)
              end
            end

            return completions
          end,
          desc = 'Call a Snacks.nvim picker by name or execute an alias'
        })
      end

      -- vim.keymap.set({'n', 'x'}, '<leader>:', Snacks.picker.command_history)
      -- vim.keymap.set({'n', 'x'}, '<leader>/', Snacks.picker.grep)
      -- vim.keymap.set({'n', 'x'}, '<leader>*', Snacks.picker.grep_word)
      -- vim.keymap.set({'n', 'x'}, '<leader>s', Snacks.picker.smart)
  }
}
