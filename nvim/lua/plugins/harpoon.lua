local vim = vim
return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    config = function()
      local harpoon = require('harpoon')
      local select_file = harpoon.config.default.select

      local function live_pi_buffer(item)
        if not (item and item.context and item.context.pi) then
          return nil
        end
        local bufnr = vim.fn.bufnr(item.value)
        if bufnr < 1 or not vim.api.nvim_buf_is_loaded(bufnr)
          or vim.bo[bufnr].buftype ~= 'terminal' or not vim.b[bufnr].pi then
          return nil
        end
        local job = vim.b[bufnr].terminal_job_id
        return job and vim.fn.jobwait({ job }, 0)[1] == -1 and bufnr or nil
      end

      local function pi_focus()
        local list = harpoon:list()
        local bufnr = live_pi_buffer(list:get(1))
        if bufnr then
          if vim.api.nvim_get_current_buf() ~= bufnr then
            local visible_win = vim.fn.bufwinid(bufnr)
            local state = vim.b[bufnr].pi_view
            if visible_win ~= -1 then
              vim.api.nvim_set_current_win(visible_win)
            else
              vim.api.nvim_set_current_buf(bufnr)
              if state then
                local row = math.max(1, math.min(state.cursor[1], vim.api.nvim_buf_line_count(bufnr)))
                local line = vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1]
                vim.api.nvim_win_set_cursor(0, { row, math.min(state.cursor[2], #line) })
              end
            end
            if state and state.terminal_mode then
              vim.cmd.startinsert()
            end
          end
          return
        end

        vim.cmd('terminal pi')
        bufnr = vim.api.nvim_get_current_buf()
        vim.b[bufnr].pi = true
        vim.api.nvim_create_autocmd('BufLeave', {
          buffer = bufnr,
          callback = function()
            vim.b[bufnr].pi_view = {
              cursor = vim.api.nvim_win_get_cursor(0),
              terminal_mode = vim.api.nvim_get_mode().mode:sub(1, 1) == 't',
            }
          end,
        })
        list:replace_at(1, {
          value = vim.api.nvim_buf_get_name(bufnr),
          context = { row = 1, col = 0, pi = true },
        })
        harpoon:sync()
        vim.cmd.startinsert()
      end

      harpoon:setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        },
        default = {
          select = function(item, list, options)
            if item and item.context and item.context.pi then
              pi_focus()
            else
              select_file(item, list, options)
            end
          end,
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

      vim.keymap.set('n', '<leader>a', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
      vim.keymap.set('n', '<leader><M-s>', function() harpoon:list():replace_at(2) end)
      vim.keymap.set('n', '<leader><M-d>', function() harpoon:list():replace_at(3) end)
      vim.keymap.set('n', '<leader><M-f>', function() harpoon:list():replace_at(4) end)
      vim.keymap.set({'n', 't'}, '<M-a>', pi_focus)
      vim.keymap.set({'n', 't'}, '<M-s>', function() harpoon:list():select(2) end)
      vim.keymap.set({'n', 't'}, '<M-d>', function() harpoon:list():select(3) end)
      vim.keymap.set({'n', 't'}, '<M-f>', function() harpoon:list():select(4) end)
    end,
  },
}
