return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    build = 'make tiktoken',
    opts = {
      mappings = {
        reset = {
          normal = '<C-r>',
          insert = '<C-r>',
        },
      },
      model = 'gpt-4',
    },
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup({})
    end,
  },
  {
    'yetone/avante.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = { file_types = { 'markdown', 'Avante' } },
        ft = { 'markdown', 'Avante' },
      },
    },
    build = 'make',
    opts = {
      provider = 'copilot',
      providers = {
        openai = {
          extra_request_body = {
            max_completion_tokens = 8192,
          },
          model = 'o3',
        },
        copilot = {
          extra_request_body = {
            max_tokens = 8192,
          },
          model = 'claude-sonnet-4',
        },
      }
    },
  },
}

