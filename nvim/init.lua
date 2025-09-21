local vim = vim
-- pen + paper
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
  -- tools
  { 'ibhagwan/fzf-lua' },
  { 'mrjones2014/smart-splits.nvim' },
  { 'jpalardy/vim-slime' },
  { 'nvim-lualine/lualine.nvim' },
  { 'nvim-tree/nvim-tree.lua' },
  { 'nvim-tree/nvim-web-devicons' },
  { 'rose-pine/neovim' },
  { 'tpope/vim-fugitive' },
  -- LSP/DAP
  { 'mfussenegger/nvim-dap' },
  { 'neovim/nvim-lspconfig' },
  { 'nvim-java/nvim-java' },
  { 'nvim-treesitter/nvim-treesitter' },
  { 'mason-org/mason.nvim', version = '^1.0.0' },
  { 'mason-org/mason-lspconfig.nvim', version = '^1.0.0' },
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
      model = 'gpt-4',
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
      require('copilot_cmp').setup({ })
    end,
  },
})

-- colorscheme
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
vim.keymap.set({'n'}, '<A-h>', smartSplits.resize_left)
vim.keymap.set({'n'}, '<A-j>', smartSplits.resize_down)
vim.keymap.set({'n'}, '<A-k>', smartSplits.resize_up)
vim.keymap.set({'n'}, '<A-l>', smartSplits.resize_right)
-- splits - moving
vim.keymap.set({'n'}, '<C-h>', smartSplits.move_cursor_left)
vim.keymap.set({'n'}, '<C-j>', smartSplits.move_cursor_down)
vim.keymap.set({'n'}, '<C-k>', smartSplits.move_cursor_up)
vim.keymap.set({'n'}, '<C-l>', smartSplits.move_cursor_right)
-- splits - swapping
vim.keymap.set({'n'}, '<leader>{', smartSplits.swap_buf_up)
vim.keymap.set({'n'}, '<leader>}', smartSplits.swap_buf_down)

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
  },
  builtin = {
    winopts = {
      height = 0.3,
      width = 1.0
    }
  },
  winopts = {
    border = 'single',
    preview = {
      border = 'single',
      horizontal = 'right:60%',
      vertical = 'up:50%',
    },
    height = 0.3,
    width = 1,
    row = 1,
    col = 0,
  },
})
vim.keymap.set('n', '<leader>f', fzfLua.live_grep)
vim.keymap.set('x', '<leader>f', fzfLua.grep_visual)
vim.keymap.set('n', '<leader>s', function()
  fzfLua.combine({ pickers = 'buffers;files', line_query=true })
end)
vim.keymap.set('n', '<leader>:', fzfLua.command_history)
vim.keymap.set('n', '<leader>/', fzfLua.blines)

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
})

-- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require('nvim-tree').setup({
})
vim.keymap.set({'n'}, '<leader>t', ':NvimTreeFindFileToggle<cr>')

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
  highlight = { enable = true, },
  indent = { enable = true },
})

-- LSP/DAP
local global_j2de_path = vim.fn.fnamemodify(vim.env.MYVIMRC, ':h') .. '/j2de.lua'
if vim.fn.filereadable(global_j2de_path) == 1 then
  dofile(global_j2de_path)
end
local project_j2de_path = vim.fn.getcwd() .. '/.j2de.lua'
if vim.fn.filereadable(project_j2de_path) == 1 then
  dofile(project_j2de_path)
end

local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
mason.setup({})
mason_lspconfig.setup({})
mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      capabilities = capabilities,
      on_attach = function()
        vim.keymap.set('n', 'gd', fzfLua.lsp_definitions)
        vim.keymap.set('n', 'gr', fzfLua.lsp_references)
        vim.keymap.set('n', '<leader>dr', require('dap').continue)
        vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint)
        vim.keymap.set('n', '<leader>dB', function()
          require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end)
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

-- vim slime
vim.g.slime_target = 'tmux'
vim.g.slime_dont_ask_default = 1
vim.g.slime_default_config = {
  socket_name = 'default',
  target_pane = '{last}'
}
vim.g.slime_bracketed_paste = 1
vim.g.slime_python_ipython = 1
vim.g.slime_no_mappings = 1

vim.keymap.set({'n'}, '<leader>dl', ':SlimeSendCurrentLine<cr>')
vim.keymap.set({'x'}, '<leader>ds', ':SlimeSend<cr>')
vim.keymap.set({'n'}, '<leader>df', ':%SlimeSend<cr>')
vim.keymap.set({'n'}, '<leader>gh', ':!gh pr view --web<cr>')
