local vim = vim
local dap = require('dap')

--  zsh
dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
    command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
    args = { '--port', '${port}' },
  },
}
dap.configurations.sh = {
  {
    name = '${file}',
    type = 'codelldb',
    request = 'launch',
    program = '/opt/homebrew/bin/zsh',
    args = { '${file}' },
    cwd = '${workspaceFolder}',
    terminalKind = 'integrated',
    showDebugOutput = true,
    stopOnEntry = false,
    env = { ZDOTDIR = vim.loop.os_homedir() },
  },
}

--  python
local python_path = vim.fn.getcwd() .. '/.venv/bin/python'
dap.adapters.python = {
  type = 'executable',
  command = python_path,
  args = { '-m', 'debugpy.adapter' },
}
dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = '${file}',
    program = '${file}',
    console = 'integratedTerminal',
    pythonPath = python_path,
  },
}

--  js
dap.adapters['pwa-node'] = {
  type = 'server',
  host = 'localhost',
  port = '${port}',
  executable = {
    command = 'node',
    args = {
      vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
      '${port}',
    },
  },
}
dap.configurations.javascript = {
  {
    type = 'pwa-node',
    request = 'launch',
    name = '${file}',
    program = '${file}',
    console = 'integratedTerminal',
    cwd = '${workspaceFolder}',
  },
}
