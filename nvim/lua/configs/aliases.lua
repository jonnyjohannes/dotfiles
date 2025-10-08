local vim = vim

local M = {
  {
    text = '[GitHub] Line',
    action = function() vim.cmd(':lua Snacks.gitbrowse()') end,
  },
  {
    text = '[GitHub] Repo',
    action = function() vim.cmd(':!gh browse') end,
  },
  {
    text = '[GitHub] Pull Request',
    action = function() vim.cmd(':!gh pr view --web') end,
  },
}

return M
