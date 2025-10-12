local vim = vim

local M = {
  {
    text = '[Hacking] Buffers + Files',
    action = function() vim.cmd(':lua require("fzf-lua").combine({ pickers = "buffers;files", line_query=true })') end,
  },
  {
    text = '[Hacking] Note',
    action = function() vim.cmd(':lua Snacks.scratch.open()') end,
  },
  {
    text = '[Hacking] Tree',
    action = function() vim.cmd(':NvimTreeFindFileToggle') end,
  },
  {
    text = '[Hacking] Zoom',
    action = function() vim.cmd(':lua Snacks.zen.zoom()') end,
  },
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
