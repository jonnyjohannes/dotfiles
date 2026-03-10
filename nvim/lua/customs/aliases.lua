local gbq = require("customs.gbq")

return {
  {
    text = "[GBQ] bq preview",
    action = function() gbq.preview() end,
  },
  {
    text = "[GBQ] bq count",
    action = function() gbq.count() end,
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
  {
    text = '[Conform] Format',
    action = function()
      require("conform").format({
        lsp_fallback = true,
        async = false,
      })
    end,
  },
}
