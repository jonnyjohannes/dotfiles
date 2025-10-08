local vim = vim
return  {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('harpoon'):setup()
      local harpoon = require('harpoon')
      local harpoon_extensions = require("harpoon.extensions")

      harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
      harpoon:extend({
        UI_CREATE = function(cx)
          vim.api.nvim_win_set_config(cx.win_id, {
            relative = "editor",
            row = vim.o.lines - 12,
            col = 0,
            width = vim.o.columns,
            height = 12,
          })
          vim.keymap.set("n", "<C-v>", function()
            harpoon.ui:select_menu_item({ vsplit = true })
          end, { buffer = cx.bufnr })

          vim.keymap.set("n", "<C-s>", function()
            harpoon.ui:select_menu_item({ split = true })
          end, { buffer = cx.bufnr })

          vim.keymap.set("n", "<C-t>", function()
            harpoon.ui:select_menu_item({ tabedit = true })
          end, { buffer = cx.bufnr })
        end,
      })

      vim.keymap.set('n', 'mm', function() harpoon:list():prepend() end)
      vim.keymap.set('n', '<M-s>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      vim.keymap.set('n', '<M-r>', function() harpoon:list():select(1) end)
      vim.keymap.set('n', '<M-e>', function() harpoon:list():select(2) end)
      vim.keymap.set('n', '<M-w>', function() harpoon:list():select(3) end)
      vim.keymap.set('n', '<M-q>', function() harpoon:list():select(4) end)
    end,
  }
}
