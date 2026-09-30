local M = {}

local palette_groups = {
  'DiagnosticError',
  'DiagnosticWarn',
  'DiagnosticInfo',
  'DiagnosticHint',
  'DiagnosticOk',
  'Statement',
  'Function',
  'Constant',
  'Special',
  'Type',
  'String',
  'Number',
  'Boolean',
  'Operator',
}

local palette = {}
local spread_order = {}
local queries = {
  markdown = vim.treesitter.query.parse('markdown', [[
    (atx_heading) @heading
    (setext_heading (paragraph) @heading)
  ]]),
  markdown_inline = vim.treesitter.query.parse('markdown_inline', [[
    (strong_emphasis) @constellation
    (emphasis) @constellation
    (code_span) @constellation
  ]]),
}

local cache = {}

local function hash(value)
  local result = 5381
  for i = 1, #value do
    result = (result * 33 + value:byte(i)) % 2147483647
  end
  return result
end

local function key(language, node)
  local sr, sc, er, ec = node:range()
  return table.concat({ language, sr, sc, er, ec }, ':')
end

local function ordered_nodes(buf)
  local changedtick = vim.api.nvim_buf_get_changedtick(buf)
  local cached = cache[buf]
  if cached and cached.changedtick == changedtick then
    return cached.slots
  end

  local nodes = {}
  local parser = vim.treesitter.get_parser(buf, 'markdown')
  parser:parse(true)
  parser:for_each_tree(function(tree, language_tree)
    local language = language_tree:lang()
    local query = queries[language]
    if query then
      for capture_id, node in query:iter_captures(tree:root(), buf) do
        local capture = query.captures[capture_id]
        nodes[#nodes + 1] = {
          language = language,
          node = node,
          capture = capture,
        }
      end
    end
  end)

  table.sort(nodes, function(a, b)
    local ar, ac, aer, aec = a.node:range()
    local br, bc, ber, bec = b.node:range()
    if ar ~= br then return ar < br end
    if ac ~= bc then return ac < bc end
    if aer ~= ber then return aer > ber end
    return aec > bec
  end)

  local name = vim.api.nvim_buf_get_name(buf)
  local seed = name == '' and ('scratch:' .. buf) or vim.fn.fnamemodify(name, ':p')
  local offset = hash(seed) % #spread_order
  local slots = {}
  for index, item in ipairs(nodes) do
    local color_index = ((offset + index - 1) % #spread_order) + 1
    slots[key(item.language, item.node)] = spread_order[color_index]
  end

  cache[buf] = { changedtick = changedtick, slots = slots }
  return slots
end

local function luminance(hex)
  local red = tonumber(hex:sub(2, 3), 16) / 255
  local green = tonumber(hex:sub(4, 5), 16) / 255
  local blue = tonumber(hex:sub(6, 7), 16) / 255
  local function linear(value)
    return value <= 0.04045 and value / 12.92 or ((value + 0.055) / 1.055) ^ 2.4
  end
  return 0.2126 * linear(red) + 0.7152 * linear(green) + 0.0722 * linear(blue)
end

local function contrast(foreground, background)
  local first, second = luminance(foreground), luminance(background)
  if first < second then first, second = second, first end
  return (first + 0.05) / (second + 0.05)
end

local function blend(foreground, target, amount)
  local channels = {}
  for index = 2, 6, 2 do
    local source = tonumber(foreground:sub(index, index + 1), 16)
    local destination = tonumber(target:sub(index, index + 1), 16)
    channels[#channels + 1] = math.floor(source + (destination - source) * amount + 0.5)
  end
  return ('#%02x%02x%02x'):format(channels[1], channels[2], channels[3])
end

local function readable_accent(accent, text, backgrounds)
  local amount = 0
  while amount < 1 do
    local candidate = blend(accent, text, amount)
    local readable = true
    for _, background in ipairs(backgrounds) do
      if contrast(candidate, background) < 4.5 then
        readable = false
        break
      end
    end
    if readable then return candidate end
    amount = amount + 0.05
  end
  return text
end

local function color(group, attribute)
  local highlight = vim.api.nvim_get_hl(0, { name = group })
  local value = highlight[attribute]
  return value and ('#%06x'):format(value) or nil
end

local function active_palette()
  local result, seen = {}, {}
  for _, group in ipairs(palette_groups) do
    local value = color(group, 'fg')
    if value and not seen[value] then
      result[#result + 1] = value
      seen[value] = true
      if #result == 7 then break end
    end
  end
  return result
end

local function make_spread_order(size)
  local preferred = { 1, 5, 3, 7, 2, 6, 4 }
  local result, included = {}, {}
  for _, slot in ipairs(preferred) do
    if slot <= size then
      result[#result + 1] = slot
      included[slot] = true
    end
  end
  for slot = 1, size do
    if not included[slot] then result[#result + 1] = slot end
  end
  return result
end

local function refresh_highlights()
  palette = active_palette()
  if #palette == 0 then
    palette = { color('Normal', 'fg') or '#ffffff' }
  end
  spread_order = make_spread_order(#palette)

  local background = color('Normal', 'bg') or '#000000'
  local code_background = color('CursorLine', 'bg') or color('ColorColumn', 'bg') or background
  local heading_background = color('NormalFloat', 'bg') or background
  local text = color('Normal', 'fg') or '#ffffff'
  local backgrounds = { background, code_background }
  for index, accent in ipairs(palette) do
    vim.api.nvim_set_hl(0, 'MarkdownConstellation' .. index, {
      fg = readable_accent(accent, text, backgrounds),
    })

    local heading_tint = blend(heading_background, accent, 0.2)
    vim.api.nvim_set_hl(0, 'MarkdownConstellationHeading' .. index, {
      fg = readable_accent(accent, text, { background, heading_tint }),
      bg = heading_tint,
    })
  end

  vim.api.nvim_set_hl(0, 'RenderMarkdownCode', { bg = code_background })
end

local function handler(language)
  return {
    extends = true,
    parse = function(ctx)
      local slots = ordered_nodes(ctx.buf)
      local query = queries[language]
      local marks = {}
      for capture_id, node in query:iter_captures(ctx.root, ctx.buf) do
        local capture = query.captures[capture_id]
        local slot = slots[key(language, node)]
        if slot and (capture == 'heading' or capture == 'constellation') then
          local start_row, start_col, end_row, end_col = node:range()
          marks[#marks + 1] = {
            conceal = true,
            start_row = start_row,
            start_col = start_col,
            opts = {
              end_row = end_row,
              end_col = end_col,
              hl_group = capture == 'heading'
                  and ('MarkdownConstellationHeading' .. slot)
                  or ('MarkdownConstellation' .. slot),
              hl_eol = capture == 'heading',
              hl_mode = 'combine',
              priority = capture == 'heading' and 150 or 200,
            },
          }
        end
      end
      return marks
    end,
  }
end

function M.setup()
  refresh_highlights()
  local group = vim.api.nvim_create_augroup('MarkdownConstellation', { clear = true })
  vim.api.nvim_create_autocmd('ColorScheme', {
    group = group,
    callback = refresh_highlights,
  })
  vim.api.nvim_create_autocmd('BufWipeout', {
    group = group,
    callback = function(event)
      cache[event.buf] = nil
    end,
  })
end

function M.handlers()
  M.setup()
  return {
    markdown = handler('markdown'),
    markdown_inline = handler('markdown_inline'),
  }
end

return M
