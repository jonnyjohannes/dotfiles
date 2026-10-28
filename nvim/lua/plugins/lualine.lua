local vim = vim

return {
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = function()
          package.loaded['lualine.themes.auto'] = nil
          local theme = vim.deepcopy(require('lualine.themes.auto'))
          local theme_overrides = {
            normal = 'Comment',
          }
          for mode, highlight_group in pairs(theme_overrides) do
            local fg = vim.api.nvim_get_hl(0, {
              name = highlight_group,
              link = false,
            }).fg

            if fg and theme[mode] and theme[mode].a then
              theme[mode].a.bg = string.format('#%06x', fg)
            end
          end

          return theme
        end,
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
            color = function()
              return 'lualine_a' .. require('lualine.highlight').get_mode_suffix()
            end,
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
    config = function(_, opts)
      require('lualine').setup(opts)
    end,
    init = function()
      vim.cmd('set laststatus=3')
      vim.cmd('set showtabline=0')
    end,
  },
}

