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
    { 'CopilotC-Nvim/CopilotChat.nvim',
      build = 'make tiktoken',
      dependencies = {
        { 'github/copilot.vim' },
        { 'nvim-lua/plenary.nvim' },
      },
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
    { 'gelguy/wilder.nvim' },
    { 'github/copilot.vim' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'ibhagwan/fzf-lua', commit = 'ed8761eaa58ff77312a877a4de63d016d58dfc58' },
    { 'loctvl842/monokai-pro.nvim' },
    { 'mfussenegger/nvim-dap' },
    { 'mrjones2014/smart-splits.nvim' },
    { 'neovim/nvim-lspconfig' },
    { 'nvim-lualine/lualine.nvim' },
    { 'nvim-tree/nvim-tree.lua' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'nvim-treesitter/nvim-treesitter' },
    { 'rose-pine/neovim' },
    { 'sheerun/vim-polyglot' },
    { 'tpope/vim-fugitive' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
})

-- color scheme
require('monokai-pro').setup({
  filter = 'spectrum',
})
vim.cmd('colorscheme monokai-pro')

-- require('rose-pine').setup({})
-- vim.cmd('colorscheme rose-pine')

-- remaps
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

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
require('lualine').setup({
  options = {
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_a = {
      {
        'windows',
        use_mode_colors = true,
        symbols = '',
      }
    },
    lualine_b = {
    },
    lualine_c = {
    },
    lualine_x = {
      'location',
    },
    lualine_y = {
      'filetype',
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
vim.keymap.set('n', '<A-h>', smartSplits.resize_left)
vim.keymap.set('n', '<A-j>', smartSplits.resize_down)
vim.keymap.set('n', '<A-k>', smartSplits.resize_up)
vim.keymap.set('n', '<A-l>', smartSplits.resize_right)
-- moving between
vim.keymap.set('n', '<C-h>', smartSplits.move_cursor_left)
vim.keymap.set('n', '<C-j>', smartSplits.move_cursor_down)
vim.keymap.set('n', '<C-k>', smartSplits.move_cursor_up)
vim.keymap.set('n', '<C-l>', smartSplits.move_cursor_right)
-- swapping
vim.keymap.set('n', '<leader><leader>h', smartSplits.swap_buf_left)
vim.keymap.set('n', '<leader><leader>j', smartSplits.swap_buf_down)
vim.keymap.set('n', '<leader><leader>k', smartSplits.swap_buf_up)
vim.keymap.set('n', '<leader><leader>l', smartSplits.swap_buf_right)

-- treesitter
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'java',
    'javascript',
    'lua',
    'markdown',
    'markdown_inline',
    'python',
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
})

-- wilder
local wilder = require('wilder')
wilder.setup({
  modes = {':', '/', '?'},
  enable_cmdline_enter = 0,
})
wilder.set_option('renderer', wilder.popupmenu_renderer(
  wilder.popupmenu_border_theme({
    highlighter = wilder.basic_highlighter(),
    min_width = '100%',
    min_height = '20%',
    max_height = '20%',
    reverse = 0,
  })
))
wilder.set_option('pipeline', {
  wilder.branch(
    wilder.cmdline_pipeline({
      language = 'vim',
      fuzzy = 2,
    }),
    wilder.search_pipeline({
      language = 'vim',
      fuzzy = 2,
    })
  )
})

-- LSP and completion
local cmp = require('cmp')
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- nvim-cmp setup
cmp.setup({
  completion = {
    autocomplete = false,
  },
  snippet = {
    expand = function(args)
      -- You'll need a snippet engine - add one to your dependencies if needed
      -- e.g., luasnip: require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  }),
})

mason.setup({})

local dap = require('dap')
dap.adapters.python = {
  type = 'executable',
  command = '/Users/jj678a/.pyenv/versions/novibedj/bin/python',
  args = { '-m', 'debugpy.adapter' },
}
dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch file',
    program = "${file}",
    console = "integratedTerminal",
    justMyCode = false,
    pythonPath = function()
      if vim.env.VIRTUAL_ENV then
        return vim.env.VIRTUAL_ENV .. '/bin/python'
      end
      return '/Users/jj678a/.pyenv/versions/novibedj/bin/python'
    end,
  },
}

-- vim.api.nvim_create_autocmd({"FileType"}, {
--   pattern = {"python"},
--   callback = function()
--     -- Check for project-specific .nvim/dap.lua file
--     local project_config = vim.fn.getcwd() .. "/.dap.lua"
--     if vim.fn.filereadable(project_config) == 1 then
--       -- Create a unique module name for this project's config
--       local module_name = "project_dap_" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
--       -- Add the directory to package.path temporarily
--       package.loaded[module_name] = nil
--       local old_path = package.path
--       package.path = vim.fn.getcwd() .. "/?.lua;" .. package.path
--       -- Require the module
--       pcall(require, module_name)
--       -- Restore package.path
--       package.path = old_path
--     end
--   end
-- })

mason_lspconfig.setup({})
mason_lspconfig.setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup({
    capabilities = capabilities,
    on_attach = function()
      vim.keymap.set("n", "<leader>gd", fzfLua.lsp_definitions)
      vim.keymap.set("n", "<leader>gr", fzfLua.lsp_references)

      -- dap mappings
      vim.keymap.set("n", "<leader>db", require('dap').toggle_breakpoint)
      vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
    end,
  })
  end,
})

