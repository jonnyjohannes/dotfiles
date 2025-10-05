local vim = vim

local M = {}

M.aliases = {
  {
    name = '[Marks] Marks set',
    action = function() vim.cmd(':F marks') end,
  },
  {
    name = '[Yank] Copy Buffer To Clipboard',
    action = function() vim.cmd(':%y') end,
  },
  {
    name = '[FZF] Builtins',
    action = function() vim.cmd(':F') end,
  },
  {
    name = '[DAP] Run It',
    action = function() require('dap').continue() end,
  },
  {
    name = '[DAP] Breakpoint Toggle',
    action = function() require('dap').toggle_breakpoint() end,
  },
  {
    name = '[DAP] Conditional Breakpoint',
    action = function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')).toggle_breakpoint() end,
  },
  {
    name = '[Diagnostics] Document',
    action = function() vim.cmd(':F lsp_document_diagnostics') end,
  },
  {
    name = '[Diagnostics] Workspace',
    action = function() vim.cmd(':F lsp_workspace_diagnostics') end,
  },
  {
    name = '[GitHub] Line',
    action = function() vim.cmd(':lua Snacks.gitbrowse()') end,
  },
  {
    name = '[GitHub] Repo',
    action = function() vim.cmd(':!gh browse') end,
  },
  {
    name = '[GitHub] Pull Request',
    action = function() vim.cmd(':!gh pr view --web') end,
  },
}

function M.get_alias(name)
  for _, cmd in ipairs(M.aliases) do
    if cmd.name == name then
      return cmd
    end
  end
  return nil
end

return M
