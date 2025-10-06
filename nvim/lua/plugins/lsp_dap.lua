local vim = vim
return {
  { 'mfussenegger/nvim-dap' },
  { 'neovim/nvim-lspconfig' },
  { 'nvim-java/nvim-java' },
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup({
        auto_install = true,
        highlight = { enable = true, },
        indent = { enable = true },
      })
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.opt.foldlevel = 99
      vim.opt.foldenable = true
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
              vim.ui.input({ prompt = 'Breakpoint condition: ' }, function(cond)
                require('dap').set_breakpoint(cond)
              end)
            end)
          end,
        }
        vim.lsp.enable(server_name)
      end

      vim.keymap.set('n', 'K', function()
        vim.lsp.buf.hover({ border = 'single' })
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
}

