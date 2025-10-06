local vim = vim
local Snacks = Snacks

local M = {
  {
    text = "[Picker] Snacks",
    action = function() Snacks.picker() end,
  },
  {
    text = '[Picker] FZF',
    action = function() vim.cmd(':F') end,
  },
  {
    text = '[Marks] Marks set',
    action = function() Snacks.picker.marks() end,
  },
  {
    text = '[Yank] Copy Buffer To Clipboard',
    action = function() vim.cmd(':%y') end,
  },
  {
    text = '[DAP] Run It',
    action = function() require('dap').continue() end,
  },
  {
    text = '[DAP] Breakpoint Toggle',
    action = function() require('dap').toggle_breakpoint() end,
  },
  {
    text = '[DAP] Conditional Breakpoint',
    action = function()
      vim.ui.input({ prompt = 'Breakpoint condition: ' }, function(cond)
        require('dap').set_breakpoint(cond)
      end)
    end,
  },
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
