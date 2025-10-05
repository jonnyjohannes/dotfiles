local vim = vim
return {
  {
    'folke/snacks.nvim',
    opts = {
      indent = {
        enabled = true,
        animate = { enabled = false },
      },
      gitbrowse = {
        enabled = true
      },
      statuscolumn = {
        enabled = true
      },
      terminal = {
        enabled = true
      },
    },
    config = function(_, opts)
      require('snacks').setup(opts)
      vim.keymap.set({'n', 't'}, '<M-,>', function()
        Snacks.terminal.toggle()
      end)
    end,
  }
}
