local vim = vim

local mode_color_groups = {
  normal = 'Identifier',
  terminal = 'String',
}

local function apply_mode_colors()
  for mode, source_group in pairs(mode_color_groups) do
    local source = vim.api.nvim_get_hl(0, { name = source_group, link = false })
    if source.fg then
      local group = 'lualine_a_' .. mode
      local colors = vim.api.nvim_get_hl(0, { name = group, link = false })
      colors.bg = source.fg
      vim.api.nvim_set_hl(0, group, colors)
    end
  end
end

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
      vim.schedule(apply_mode_colors)
      vim.api.nvim_create_autocmd('ColorScheme', {
        callback = function()
          vim.schedule(apply_mode_colors)
        end,
      })
    end,
    init = function()
      vim.cmd('set laststatus=3')
      vim.cmd('set showtabline=0')
    end,
  },
}

