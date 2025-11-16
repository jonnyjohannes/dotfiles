local vim = vim
return {
  {
    'igorlfs/nvim-dap-view',
    opts = {
      winbar = {
        sections = { 'console', 'watches', 'scopes', 'exceptions', 'breakpoints', 'threads', 'repl' },
        default_section = 'console',
      },
    },
  },
  {
    'mason-org/mason.nvim',
    opts = {
    },
  },
  {
    'mason-org/mason-lspconfig.nvim',
    config = function()
      local global_j2de_path = vim.fn.fnamemodify(vim.env.MYVIMRC, ':h') .. '/j2de.lua'
      if vim.fn.filereadable(global_j2de_path) == 1 then
        dofile(global_j2de_path)
      end
      local project_j2de_path = vim.fn.getcwd() .. '/.j2de.lua'
      if vim.fn.filereadable(project_j2de_path) == 1 then
        dofile(project_j2de_path)
      end

      local mason_lspconfig = require('mason-lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
        vim.lsp.config[server_name] = {
          capabilities = capabilities,
          on_attach = function()
            vim.keymap.set('n', 'gd', require('fzf-lua').lsp_definitions)
            vim.keymap.set('n', 'gr', require('fzf-lua').lsp_references)
            vim.keymap.set('n', '<M-R>', require('dap').continue)
            vim.keymap.set('n', '<M-r>', require('dap').step_over)
            vim.keymap.set('n', '<M-e>', require('dap').step_into)
            vim.keymap.set('n', '<M-w>', require('dap').step_out)
            vim.keymap.set('n', '<M-x>', require('dap').terminate)
            vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint)
            vim.keymap.set('n', '<leader>dB', function()
              vim.ui.input({ prompt = 'Breakpoint condition: ' }, function(cond)
                require('dap').set_breakpoint(cond)
              end)
            end)
            vim.keymap.set('n', '<leader>dr', require('dap-view').toggle)
          end,
        }
        vim.lsp.enable(server_name)
      end

      vim.keymap.set('n', 'K', function()
        vim.lsp.buf.hover({ border = 'single' })
      end)

      local diagnosticVirtualTextEnable = false
      vim.keymap.set('n', '<leader>dd', function()
        diagnosticVirtualTextEnable = not diagnosticVirtualTextEnable
        vim.diagnostic.config({ virtual_text = diagnosticVirtualTextEnable })
      end)

      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚',
            [vim.diagnostic.severity.WARN]  = '󰀪',
            [vim.diagnostic.severity.HINT]  = '󰌶',
            [vim.diagnostic.severity.INFO]  = '»',
          },
        },
      })
    end,
  },
  { 'mfussenegger/nvim-dap' },
  { 'neovim/nvim-lspconfig' },
  { 'nvim-java/nvim-java' },
  {
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          python = { 'black' },
          sh = { 'beautysh' },
          json = { 'jq' },
        },
        format_on_save = {
          lsp_format = 'fallback',
          timeout_ms = 3000,
        },
      })
    end,
  },
}
