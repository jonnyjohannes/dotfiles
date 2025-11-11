local vim = vim

local M = {
  {
    text = '[GitHub] Line',
    action = function() vim.cmd(':lua Snacks.gitbrowse()') end,
  },
  {
    text = '[GitHub] PullRequest',
    action = function() vim.cmd(':!gh pr view --web') end,
  },
  {
    text = '[GitHub] Repo',
    action = function() vim.cmd(':!gh browse') end,
  },
}

return M
