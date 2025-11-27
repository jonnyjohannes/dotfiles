local vim = vim

local Job = require("plenary.job")

local state = {
  win = nil,
  buf = nil,
}

local function get_or_create_window()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_set_current_win(state.win)
    return state.win
  end

  vim.cmd("belowright new")
  state.win = vim.api.nvim_get_current_win()
  state.buf = vim.api.nvim_get_current_buf()
  return state.win
end

local function ensure_results_buffer(win, buf_name)
  if not (state.buf and vim.api.nvim_buf_is_valid(state.buf)) then
    state.buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(state.buf, buf_name)
    vim.bo[state.buf].buftype = "nofile"
    vim.bo[state.buf].bufhidden = "wipe"
    vim.bo[state.buf].swapfile = false
    vim.bo[state.buf].wrap = false
  end
  vim.wo[win].wrap = false
  vim.api.nvim_win_set_buf(win, state.buf)
  return state.buf
end

local function get_visual_selection()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_row, start_col = start_pos[2], start_pos[3]
  local end_row, end_col = end_pos[2], end_pos[3]

  local lines = vim.fn.getline(start_row, end_row)
  if #lines == 0 then
    return nil
  end

  -- Handle single line selection
  if #lines == 1 then
    lines[1] = string.sub(lines[1], start_col, end_col)
  else
    -- Handle multi-line selection
    lines[1] = string.sub(lines[1], start_col)
    lines[#lines] = string.sub(lines[#lines], 1, end_col)
  end

  return table.concat(lines, "\n")
end

local function run_job_and_show(cmd, args, buf_name)
  local file = vim.fn.expand("%:p")

  local win = get_or_create_window()
  local buf = ensure_results_buffer(win)

  -- Initialize loading message
  local base_message = "GBQ'ing"
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { base_message })

  -- Create timer for animated loading dots
  local timer = vim.uv.new_timer()
  local dot_count = 0

  timer:start(1000, 1000, vim.schedule_wrap(function()
    -- Only update if buffer is still valid
    if vim.api.nvim_buf_is_valid(buf) then
      dot_count = dot_count + 1
      local new_dots = string.rep(".", dot_count)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, { base_message .. new_dots })
    end
  end))

  Job:new({
    command = cmd,
    args = args,
    cwd = vim.fn.fnamemodify(file, ":h"),
    on_exit = function(j, return_val)
      vim.schedule(function()
        if timer then
          timer:stop()
          timer:close()
        end

        if return_val ~= 0 then
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, j:stderr_result())
          vim.notify("GBQ whoops", vim.log.levels.ERROR)
          return
        end

        vim.api.nvim_buf_set_lines(buf, 0, -1, false, j:result())
        vim.notify("GBQ'd", vim.log.levels.INFO)
      end)
    end,
  }):start()
end

local M = {
  {
    text = "[GBQ] bq preview",
    action = function()
      local selection = get_visual_selection()
      local content

      if selection then
        content = selection
      else
        -- Fall back to whole file
        local file = vim.fn.expand("%:p")
        local file_lines = vim.fn.readfile(file)
        content = table.concat(file_lines, "\n")
      end

      -- Write content to temporary file
      local temp_file = vim.fn.tempname() .. ".sql"
      vim.fn.writefile(vim.split(content, "\n"), temp_file)

      run_job_and_show("bash", {
        "-lc",
        string.format("bq query --use_legacy_sql=false < %q && rm %q", temp_file, temp_file),
      })
    end,
  },
  {
    text = "[GBQ] bq count",
    action = function()
      local selection = get_visual_selection()
      local content

      if selection then
        content = selection
      else
        -- Fall back to whole file
        local file = vim.fn.expand("%:p")
        local file_lines = vim.fn.readfile(file)
        content = table.concat(file_lines, "\n")
      end

      local sql = string.format('SELECT count(1) as count FROM ( %s )', content)

      -- Write to temporary file and use input redirection like the preview action
      local temp_file = vim.fn.tempname() .. ".sql"
      vim.fn.writefile(vim.split(sql, "\n"), temp_file)

      run_job_and_show("bash", {
        "-lc",
        string.format("bq query --use_legacy_sql=false < %q && rm %q", temp_file, temp_file),
      })
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
