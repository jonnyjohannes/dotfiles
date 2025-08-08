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
    -- colorschemes
    { 'catppuccin/nvim' },
    { 'loctvl842/monokai-pro.nvim' },
    { 'rose-pine/neovim' },
    -- tools
    { 'ibhagwan/fzf-lua' },
    { 'mrjones2014/smart-splits.nvim' },
    { 'nvim-lualine/lualine.nvim' },
    { 'nvim-tree/nvim-tree.lua' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'tpope/vim-fugitive' },
    -- LSP/DAP
    { 'mfussenegger/nvim-dap' },
    { 'neovim/nvim-lspconfig' },
    { 'nvim-java/nvim-java' },
    { 'nvim-treesitter/nvim-treesitter' },
    { 'mason-org/mason.nvim', version = '^1.0.0' },
    { 'mason-org/mason-lspconfig.nvim', version = '^1.0.0' },
    { 'sheerun/vim-polyglot' },
    -- cmp completions
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-cmdline' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    -- AI Copilots
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
        model = 'gemini-2.5-pro',
      },
    },
    {
      'yetone/avante.nvim',
      dependencies = {
        'MunifTanjim/nui.nvim',
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim',
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
    { 'zbirenbaum/copilot.lua',
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
        require('copilot_cmp').setup({ })
      end,
    },
})

-- colorscheme
require('monokai-pro').setup({
  filter = 'spectrum',
})
require('catppuccin').setup({
  flavour = 'mocha',
  color_overrides = {
    mocha = {
      base = '#1f1f1f',
      crust = '#363738',
      mantle = '#1e1e1e',
      overlay0 = '#363738',
      surface1 = '#363738',
    },
  },
})
require('rose-pine').setup({
  variant = 'main',
  palette = {
    main = {
      base = '#1f1f1f',
      overlay = '#363738',
      surface = '#1e1e1e',
    },
  },
})
vim.cmd('colorscheme rose-pine')

-- splits
local smartSplits = require('smart-splits')
smartSplits.setup({
})
-- splits - resizing
vim.keymap.set({'n', 't'}, '<A-h>', smartSplits.resize_left)
vim.keymap.set({'n', 't'}, '<A-j>', smartSplits.resize_down)
vim.keymap.set({'n', 't'}, '<A-k>', smartSplits.resize_up)
vim.keymap.set({'n', 't'}, '<A-l>', smartSplits.resize_right)
-- splits - moving
vim.keymap.set({'n', 't'}, '<C-h>', smartSplits.move_cursor_left)
vim.keymap.set({'n', 't'}, '<C-j>', smartSplits.move_cursor_down)
vim.keymap.set({'n', 't'}, '<C-k>', smartSplits.move_cursor_up)
vim.keymap.set({'n', 't'}, '<C-l>', smartSplits.move_cursor_right)
-- splits - swapping
vim.keymap.set({'n', 't'}, '<leader><leader>h', smartSplits.swap_buf_left)
vim.keymap.set({'n', 't'}, '<leader><leader>j', smartSplits.swap_buf_down)
vim.keymap.set({'n', 't'}, '<leader><leader>k', smartSplits.swap_buf_up)
vim.keymap.set({'n', 't'}, '<leader><leader>l', smartSplits.swap_buf_right)

-- fzf
local fzfLua = require('fzf-lua')
fzfLua.setup({
  fzf_opts = {
    ['--layout'] = 'reverse-list',
  },
  keymap = {
    builtin = {
      ['<c-d>'] = 'preview-page-down',
      ['<c-u>'] = 'preview-page-up',
    },
    fzf = {
      ['ctrl-d'] = 'preview-page-down',
      ['ctrl-u'] = 'preview-page-up',
    },
  },
  winopts = {
    border = 'single',
    preview = {
      border = 'single',
      horizontal = 'right:60%',
      vertical = 'up:50%',
    },
    height = 0.30,
    width = 1,
    row = 1,
  },
})
vim.keymap.set('n', '<leader>f', fzfLua.grep_project)
vim.keymap.set('n', '<leader>s', fzfLua.buffers)
vim.keymap.set('n', '<leader>t', fzfLua.files)
vim.keymap.set('n', '<leader>:', fzfLua.command_history)

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
    },
    lualine_b = {
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
  inactive_sections = {
  },
})

-- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require('nvim-tree').setup({
})

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

-- LSP/DAP
local project_j2de_path = vim.fn.getcwd() .. '/j2de.lua'
if vim.fn.filereadable(project_j2de_path) == 1 then
  dofile(project_j2de_path)
end
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
mason.setup({})
mason_lspconfig.setup({})
mason_lspconfig.setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup({
      capabilities = capabilities,
      on_attach = function()
        vim.keymap.set('n', '<leader>gd', fzfLua.lsp_definitions)
        vim.keymap.set('n', '<leader>gr', fzfLua.lsp_references)
        vim.keymap.set('n', '<leader>dr', require('dap').continue)
        vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint)
        vim.keymap.set('n', '<leader>dc', '<cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<cr>')
      end,
    })
  end,
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
    completion = cmp.config.window.bordered({ border = 'single' }),
    documentation = cmp.config.window.bordered({ border = 'single' }),
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
  },
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

