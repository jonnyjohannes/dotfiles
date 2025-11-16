local vim = vim

local M = {
  {
    text = '[GBQ] bq preview',
    action = function() vim.cmd(':exe "new | read !bq query --use_legacy_sql=false < " . expand("%:p")') end,
  },
  {
    text = '[GBQ] bq count',
    action = function()
      local f = vim.fn.expand('%:p')
      vim.cmd(':execute "new | read !echo \\"SELECT count(1) FROM ( $(cat ' ..
        f .. ') )\\" | bq query --use_legacy_sql=false"')
    end,
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
