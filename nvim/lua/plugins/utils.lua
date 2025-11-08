local vim = vim
return {
  { 'nvim-tree/nvim-web-devicons' },
  { 'nvim-lua/plenary.nvim' },
  {
    "nvim-zh/colorful-winsep.nvim",
    opts = {
      border = 'single',
      highlight = 'gray',
      animate = {
        enabled = false,
      },
      indicator_for_2wins = {
        position = false,
      },
    },
    config = true,
    event = { "WinLeave" },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    config = function()
      require('render-markdown').setup({
        code = {
          left_pad = 2,
          right_pad = 2,
        },
      })
      vim.api.nvim_set_hl(0, "RenderMarkdownCode", {
        bg = "#111111",
      })
    end,
  },
  {
    "mohseenrm/marko.nvim",
    config = function()
      require("marko").setup()

      -- -- priveledged marks
      -- vim.keymap.set({'n', 'x'}, 'ma', 'mA')
      -- vim.keymap.set({'n', 'x'}, 'ms', 'mS')
      -- vim.keymap.set({'n', 'x'}, 'md', 'mD')
      -- vim.keymap.set({'n', 'x'}, 'mf', 'mF')
      -- vim.keymap.set({'n', 'x'}, '<M-a>', "'Azz")
      -- vim.keymap.set({'n', 'x'}, '<M-s>', "'Szz")
      -- vim.keymap.set({'n', 'x'}, '<M-d>', "'Dzz")
      -- vim.keymap.set({'n', 'x'}, '<M-f>', "'Fzz")
    end
  },
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

      vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end)
      vim.keymap.set('n', '<M-a>', function() harpoon:list():select(1) end)
      vim.keymap.set('n', '<M-s>', function() harpoon:list():select(2) end)
      vim.keymap.set('n', '<M-d>', function() harpoon:list():select(3) end)
      vim.keymap.set('n', '<M-f>', function() harpoon:list():select(4) end)
      vim.keymap.set('n', '<M-g>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'RRethy/nvim-treesitter-textobjects',
    },
    config = function()
      require('nvim-treesitter.configs').setup({
        auto_install = true,
        highlight = { enable = true, },
        indent = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ['as'] = '@local.scope',
            },
          },
        },
      })
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.opt.foldlevel = 99
      vim.opt.foldenable = true
    end,
  },
  {
    'chrisgrieser/nvim-various-textobjs',
    event = 'VeryLazy',
    opts = {
      keymaps = {
        useDefaults = true,
      },
    },
  }
}


