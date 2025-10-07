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
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
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
          height = 0,
          backdrop = { blend = 0 },
        }
      },
    },
    config = function(_, opts)
      local Snacks = require('snacks')
      Snacks.setup(opts)

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
      vim.keymap.set({'n', 'x'}, '<leader>Z', Snacks.zen.zen)

      -- vim.keymap.set({'n', 'x'}, '<leader>:', Snacks.picker.command_history)
      -- vim.keymap.set({'n', 'x'}, '<leader>/', Snacks.picker.grep)
      -- vim.keymap.set({'n', 'x'}, '<leader>*', Snacks.picker.grep_word)
      -- vim.keymap.set({'n', 'x'}, '<leader>f', snacksPickerAliases)
      -- vim.keymap.set({'n', 'x'}, '<leader>s', Snacks.picker.smart)

      vim.api.nvim_create_user_command('S', function(others)
        local picker = others.fargs[1]
        if not picker or picker == "" then
          Snacks.picker.pickers()
          return
        end
        local picker_func = Snacks.picker and Snacks.picker[picker]
        if type(picker_func) == 'function' then
          picker_func()
        else
          vim.notify(('No Snacks picker found: %s'):format(picker), vim.log.levels.ERROR)
        end
      end, {
          nargs = '?',
          complete = function(ArgLead)
            local pickers = {}
            if Snacks.picker then
              for k, v in pairs(Snacks.picker) do
                if type(v) == 'function' then
                  if vim.startswith(k, ArgLead) then
                    table.insert(pickers, k)
                  end
                end
              end
            end
            return pickers
          end,
          desc = 'Call a Snacks.nvim picker by name'
        })
    end,
  }
}
