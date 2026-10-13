return {
  {
    'tpope/vim-fugitive',
    config = function()
      local function is_fugitive_buffer(buf)
        return vim.bo[buf].filetype == 'fugitive'
          or vim.api.nvim_buf_get_name(buf):match('^fugitive://') ~= nil
      end

      local function gitfugitivefocus()
        local current_win = vim.api.nvim_get_current_win()
        local current_buf = vim.api.nvim_win_get_buf(current_win)

        if is_fugitive_buffer(current_buf) then
          if #vim.api.nvim_tabpage_list_wins(0) > 1 then
            vim.cmd.close()
          else
            vim.cmd.enew()
          end
          return
        end

        for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
          for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
            if is_fugitive_buffer(vim.api.nvim_win_get_buf(win)) then
              vim.api.nvim_set_current_tabpage(tab)
              vim.api.nvim_set_current_win(win)
              return
            end
          end
        end

        vim.cmd('G')
      end

      vim.api.nvim_create_user_command('GitFugitiveFocus', gitfugitivefocus, {
        desc = 'Toggle focus of the Fugitive status window',
      })
      vim.keymap.set('n', '<M-g>', gitfugitivefocus, {
        desc = 'Toggle focus of the Fugitive status window',
      })
      vim.keymap.set('t', '<M-g>', '<C-\\><C-n><cmd>GitFugitiveFocus<cr>', {
        desc = 'Toggle focus of the Fugitive status window',
      })
    end,
  }
}

