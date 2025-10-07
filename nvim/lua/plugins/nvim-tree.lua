local vim = vim
return {
  {
    'nvim-tree/nvim-tree.lua',
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    opts = {
    },
    config = function(_, opts)
      require('nvim-tree').setup(opts)
      vim.keymap.set({'n'}, '<M-t>', ':NvimTreeFindFileToggle<cr>')
    end,
  },
}

