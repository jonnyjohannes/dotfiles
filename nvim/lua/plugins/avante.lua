return {
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
