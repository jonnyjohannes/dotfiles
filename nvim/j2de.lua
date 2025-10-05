local vim = vim
local dap = require('dap')

--  bash 
dap.adapters.bashdb = {
  type = 'executable',
  command = vim.fn.stdpath('data') .. '/mason/packages/bash-debug-adapter/bash-debug-adapter',
  name = 'bashdb'
}
dap.configurations.sh = {
  {
    type = 'bashdb',
    request = 'launch',
    name = '(ba)sh it: ${file}',
    program = '${file}',
    pathBash = '/opt/homebrew/bin/bash',
    pathCat = '/bin/cat',
    pathMkfifo = '/usr/bin/mkfifo',
    pathPkill = '/usr/bin/pkill',
    pathBashdb = vim.fn.stdpath('data') .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb',
    pathBashdbLib = vim.fn.stdpath('data') .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir',
    cwd = '${workspaceFolder}',
    args = {},
    env = {},
    terminalKind = 'integrated',
    showDebugOutput = true,
  }
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

