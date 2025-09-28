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
        lualine_b = {
          {
            'windows',
            symbols = '',
            use_mode_colors = true,
          },
        },
        lualine_c = {
        },
        lualine_x = {
          'lsp_status',
          'diagnostics',
          'branch',
          'diff',
        },
        lualine_y = {
        },
        lualine_z = {
        },
      },
    },
    init = function()
      vim.cmd('set laststatus=3')
      vim.cmd('set showtabline=0')
    end,
  },
}

