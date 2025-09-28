local vim = vim
return {
  { 'mfussenegger/nvim-dap' },
  { 'neovim/nvim-lspconfig' },
  { 'nvim-java/nvim-java' },
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'java',
          'javascript',
          'lua',
          'markdown',
          'markdown_inline',
          'python',
          'sql',
          'vim',
        },
        highlight = { enable = true, },
        indent = { enable = true },
      })
    end,
  },
  { 'mason-org/mason.nvim',
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
            vim.keymap.set('n', '<leader>dr', require('dap').continue)
            vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint)
            vim.keymap.set('n', '<leader>dB', function()
              require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
            end)
          end,
        }
        vim.lsp.enable(server_name)
      end
    end,
  },
}

