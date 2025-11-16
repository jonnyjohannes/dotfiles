local vim = vim
return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    config = function()
      local harpoon = require('harpoon')
      harpoon:setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        },
      })
      local harpoon_extensions = require('harpoon.extensions')
      harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
      harpoon:extend({
        UI_CREATE = function(cx)
          vim.api.nvim_win_set_config(cx.win_id, {
            relative = 'editor',
            row = vim.o.lines - 12,
            col = 0,
            width = vim.o.columns,
            height = 12,
          })
          vim.keymap.set('n', '<C-v>', function()
            harpoon.ui:select_menu_item({ vsplit = true })
          end, { buffer = cx.bufnr })

          vim.keymap.set('n', '<C-s>', function()
            harpoon.ui:select_menu_item({ split = true })
          end, { buffer = cx.bufnr })

          vim.keymap.set('n', '<C-t>', function()
            harpoon.ui:select_menu_item({ tabedit = true })
          end, { buffer = cx.bufnr })
        end,
      })

      vim.keymap.set('n', '<M-a>', function() harpoon:list():select(1) end)
      vim.keymap.set('n', '<M-s>', function() harpoon:list():select(2) end)
      vim.keymap.set('n', '<M-d>', function() harpoon:list():select(3) end)
      vim.keymap.set('n', '<M-f>', function() harpoon:list():select(4) end)
      vim.keymap.set('n', '<M-g>', function()
        harpoon:list():add()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)
    end,
  },
}
