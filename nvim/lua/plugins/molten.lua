
local vim = vim
return {
  {
    'goerz/jupytext.nvim',
    version = '0.2.0',
    opts = {},
  },
  {
    "benlubas/molten-nvim",
    dependencies = {
      "3rd/image.nvim"
    },
    config = function()
      vim.g.molten_image_provider = "image.nvim"

      -- Autocommand for *.ipynb files
      vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
        pattern = "*.ipynb",
        callback = function()
          -- Apply molten-specific keymaps
          vim.keymap.set("n", "<leader>dr", ":MoltenReevaluateCell<CR>")
          vim.keymap.set("v", "<leader>dr", ":<C-u>MoltenEvaluateVisual<CR>gv")
          vim.keymap.set("n", "<leader>dj", ":noautocmd MoltenEnterOutput<CR>")
        end,
      })

    end,
    build = ":UpdateRemotePlugins",
  }
}

