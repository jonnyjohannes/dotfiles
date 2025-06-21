-- basics
local vim = vim
vim.cmd.source('~/.config/nvim/vimrc')

-- lazy.nvim
local lazypath = vim.fn.expand('~/.local/share/nvim/lazy/lazy.nvim')

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
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
        model = 'claude-3.7-sonnet',
      },
    },
    {
      "yetone/avante.nvim",
      dependencies = {
        "MunifTanjim/nui.nvim",
        "stevearc/dressing.nvim",
        {
          "MeanderingProgrammer/render-markdown.nvim",
          opts = { file_types = { "markdown", "Avante" } },
          ft = { "markdown", "Avante" },
        },
      },
      build = "make",
      opts = {
        provider = 'copilot',
        providers = {
          openai = {
            model = "o3",
          },
          copilot = {
            model = "gemini-2.5-pro",
          },
        }
      },
    },
    { "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({
          suggestion = { enabled = false },
          panel = { enabled = false },
        })
      end,
    },
    {
      'zbirenbaum/copilot-cmp',
      config = function()
        require('copilot_cmp').setup({ })
      end,
    },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-cmdline' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'ibhagwan/fzf-lua' },
    { 'mfussenegger/nvim-dap' },
    { 'mrjones2014/smart-splits.nvim' },
    { 'neovim/nvim-lspconfig' },
    { 'nvim-java/nvim-java' },
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-lualine/lualine.nvim' },
    { 'nvim-tree/nvim-tree.lua' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'nvim-treesitter/nvim-treesitter' },
    { 'sheerun/vim-polyglot' },
    { 'tpope/vim-fugitive' },
    { 'mason-org/mason.nvim', version = '^1.0.0' },
    { 'mason-org/mason-lspconfig.nvim', version = '^1.0.0' },
    -- colorschemes
    { 'catppuccin/nvim' },
    { 'loctvl842/monokai-pro.nvim' },
    { 'rose-pine/neovim' },
})

-- color scheme
require('monokai-pro').setup({
  filter = 'spectrum',
})
require('catppuccin').setup({
  flavour = 'mocha',
})
require('rose-pine').setup({
  variant = 'main',
  palette = {
    main = {
      base = '#1e1e1e',
      overlay = '#363738',
      surface = '#282828',
    },
  },
})
vim.opt.fillchars:append({ eob = " " })
vim.cmd('colorscheme rose-pine')

-- fzf
local fzfLua = require('fzf-lua')
fzfLua.setup({
  'borderless_full',
})
vim.keymap.set('n', '<Leader>b', fzfLua.buffers)
vim.keymap.set('n', '<Leader>f', fzfLua.grep_project)
vim.keymap.set('n', '<Leader>t', fzfLua.files)
vim.keymap.set('n', '<Leader>x', fzfLua.command_history)
vim.keymap.set('n', '<Leader>/', fzfLua.search_history)

-- lualine
vim.cmd('set laststatus=3')
vim.cmd('set showtabline=0')
require('lualine').setup({
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
      {
        'windows',
        use_mode_colors = true,
        symbols = '',
      },
    },
    lualine_b = {
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
      'mode',
    },
  },
  inactive_sections = {
  },
})

-- splits
local smartSplits = require('smart-splits')
smartSplits.setup({
})
-- resizing
vim.keymap.set({'n', 't'}, '<A-h>', smartSplits.resize_left)
vim.keymap.set({'n', 't'}, '<A-j>', smartSplits.resize_down)
vim.keymap.set({'n', 't'}, '<A-k>', smartSplits.resize_up)
vim.keymap.set({'n', 't'}, '<A-l>', smartSplits.resize_right)
-- moving between
vim.keymap.set({'n', 't'}, '<C-h>', smartSplits.move_cursor_left)
vim.keymap.set({'n', 't'}, '<C-j>', smartSplits.move_cursor_down)
vim.keymap.set({'n', 't'}, '<C-k>', smartSplits.move_cursor_up)
vim.keymap.set({'n', 't'}, '<C-l>', smartSplits.move_cursor_right)
-- swapping
vim.keymap.set({'n', 't'}, '<leader><leader>h', smartSplits.swap_buf_left)
vim.keymap.set({'n', 't'}, '<leader><leader>j', smartSplits.swap_buf_down)
vim.keymap.set({'n', 't'}, '<leader><leader>k', smartSplits.swap_buf_up)
vim.keymap.set({'n', 't'}, '<leader><leader>l', smartSplits.swap_buf_right)

-- treesitter
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
  highlight = {
    enable = true,
  },
})

-- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require('nvim-tree').setup({
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
})

-- completions
local cmp = require('cmp')
cmp.setup({
  completion = {
    autocomplete = false,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<ESC>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<TAB>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-TAB>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'copilot', group_index = 1 },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})
cmp.setup.cmdline({'/', '?'}, {
  formatting = {
    format = function(_, item)
      item.kind = ''
      return item
    end,
  },
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline(':', {
  formatting = {
    format = function(_, item)
      item.kind = ''
      return item
    end,
  },
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'path' },
    { name = 'cmdline' },
  },
})

-- LSPs
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Project specific LSP and DAP
local project_j2de_path = vim.fn.getcwd() .. "/j2de.lua"
if vim.fn.filereadable(project_j2de_path) == 1 then
  dofile(project_j2de_path)
  print("🐝 j2de.lua loaded 🐞")
end

mason.setup({})
mason_lspconfig.setup({})
mason_lspconfig.setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup({
    capabilities = capabilities,
    on_attach = function()
      -- lsp mappings
      vim.keymap.set("n", "<leader>gd", fzfLua.lsp_definitions)
      vim.keymap.set("n", "<leader>gr", fzfLua.lsp_references)

      -- dap mappings
      vim.keymap.set("n", "<leader>db", require('dap').toggle_breakpoint)
      vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
    end,
  })
  end,
})

vim.api.nvim_create_autocmd({"ModeChanged"}, {
  callback = function()
    local mode = vim.api.nvim_get_mode().mode
    local is_term_mode = mode == "t"
    vim.api.nvim_set_option_value("timeoutlen", is_term_mode and 0 or 1000, { scope = "local" })
  end,
})

