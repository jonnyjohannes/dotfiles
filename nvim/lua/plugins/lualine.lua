local vim = vim
return {
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        section_separators = '',
        component_separators = '',
      },
      sections = {
        lualine_a = {
          {
            'windows',
            symbols = '',
            use_mode_colors = true,
          },
        },
        lualine_b = {
        },
        lualine_c = {
          'diff',
        },
        lualine_x = {
          'lsp_status',
          'diagnostics',
        },
        lualine_y = {
        },
        lualine_z = {
          {
            'progress',
            fmt = function()
              local current = vim.fn.line('.')
              local total = vim.fn.line('$')
              local chars = {'█', '▇', '▆', '▅', '▄', '▃', '▂', '▁'}
              local idx = math.floor((current/total) * (#chars - 1)) + 1
              return chars[idx]
            end,
          },
        },
      },
    },
    init = function()
      vim.cmd('set laststatus=3')
      vim.cmd('set showtabline=0')
    end,
  },
}

