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
          -- vim.api.nvim_win_set_config(cx.win_id, {
          --   relative = "editor",
          --   row = 10,
          --   col = vim.o.columns - 60,
          --   width = 50,
          --   height = 10,
          -- })
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

      vim.keymap.set('n', '<leader>g', function() harpoon:list():add() end)
      vim.keymap.set('n', '<leader>h', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
      vim.keymap.set('n', '<leader>A', function() harpoon:list():select(1) end)
      vim.keymap.set('n', '<leader>S', function() harpoon:list():select(2) end)
      vim.keymap.set('n', '<leader>D', function() harpoon:list():select(3) end)
      vim.keymap.set('n', '<leader>F', function() harpoon:list():select(4) end)

      vim.keymap.set('n', '<leader>Am', function()
          require("harpoon"):list():add({ value = vim.api.nvim_buf_get_name(0) }, 1)
      end)
      vim.keymap.set('n', '<leader>Sm', function()
          require("harpoon"):list():add({ value = vim.api.nvim_buf_get_name(0) }, 2)
      end)
      vim.keymap.set('n', '<leader>Dm', function()
          require("harpoon"):list():add({ value = vim.api.nvim_buf_get_name(0) }, 3)
      end)
      vim.keymap.set('n', '<leader>Dm', function()
          require("harpoon"):list():add({ value = vim.api.nvim_buf_get_name(0) }, 4)
      end)
    end,
  }
}
