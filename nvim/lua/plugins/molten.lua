
local vim = vim
return {
  {
    'goerz/jupytext.nvim',
    version = '0.2.0',
    opts = {},
  },
  {
    "benlubas/molten-nvim",
    dependencies = {
      "3rd/image.nvim"
    },
    config = function()
      vim.g.molten_image_provider = "image.nvim"

      local function select_between_fences()

        local bufnr = vim.api.nvim_get_current_buf()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local curr_line = cursor[1] - 1

        -- Search upwards for ```
        local start = curr_line
        while start > 0 do
          local line = vim.api.nvim_buf_get_lines(bufnr, start, start+1, false)[1]
          if line:match("^```") then break end
          start = start - 1
        end

        -- Search downwards for ```
        local stop = curr_line
        local line_count = vim.api.nvim_buf_line_count(bufnr)
        while stop < line_count do
          local line = vim.api.nvim_buf_get_lines(bufnr, stop, stop+1, false)[1]
          if line:match("^```") then break end
          stop = stop + 1
        end

        -- Move cursor to start of content (after opening ```
        vim.api.nvim_win_set_cursor(0, {start+2, 0})
        vim.cmd("normal! v")

        -- Find end column of line before closing ```
        local last_content_line = stop - 1
        local last_line_text = vim.api.nvim_buf_get_lines(bufnr, last_content_line, last_content_line+1, false)[1]
        local end_col = #last_line_text

        -- Move cursor to end of last line of content
        vim.api.nvim_win_set_cursor(0, {last_content_line+1, end_col})
      end

      vim.keymap.set('n', 'VV', select_between_fences)
      vim.keymap.set("n", "<leader>dk", ":MoltenReevaluateCell<CR>")
      vim.keymap.set("v", "<leader>dk", ":<C-u>MoltenEvaluateVisual<CR>gv")
      vim.keymap.set("n", "<leader>dj", ":noautocmd MoltenEnterOutput<CR>")
    end,
    build = ":UpdateRemotePlugins",
  }
}

