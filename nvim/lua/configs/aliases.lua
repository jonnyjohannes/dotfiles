local vim = vim
local Snacks = require('snacks')

local M = {
  {
    text = '[Diagnostics] Document',
    action = function() Snacks.picker.diagnostics_buffer() end,
  },
  {
    text = '[Diagnostics] Workspace',
    action = function() Snacks.picker.diagnostics() end,
  },
  {
    text = '[GitHub] Line',
    action = function() Snacks.gitbrowse() end,
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
