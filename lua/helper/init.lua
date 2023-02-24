local M = {}
local logLevel = vim.log.levels.ERROR
local api = vim.api
local fn = vim.fn
local cmd = vim.cmd

function M.notify(msg, log)
  vim.notify(msg, log, {})
end

function M.find_issue_from_repo(str, prefix)
  local start = str:find(prefix, 1, true)
  if not start then
    return nil
  end
  local pattern = "-%d+"
  local _, finish = str:find(pattern, start)
  if not finish then
    return nil
  end
  local substring = str:sub(start, finish)
  return substring
end

function M.extract_key_value(str)
  local lines = {}
  for line in str:gmatch("[^\r\n]+") do
    table.insert(lines, line)
  end
  local key_value = nil
  for _, line in ipairs(lines) do
    if line:find("^%s*key:%s*") then
      key_value = line:match("^%s*key:%s*(.-)%s*$")
    end
  end

  return key_value
end

function M.get_current_branch()
  local git_cmd = "git rev-parse --abbrev-ref HEAD"
  local git_branch = fn.system(git_cmd)
  return git_branch:gsub("%s+", "")
end

function M.get_project_key()
  local jira_config = os.getenv("HOME") .. "/.config/.jira/.config.yml"
  local file = io.open(jira_config, "r")
  local contents = file:read("*all")
  if file then
    file:close()
  end
  return M.extract_key_value(contents)
end

function M.open_jira_terminal(jira_args)
  local args = jira_args or { "issue", "list" }
  local opts = {
    relative = "editor",
    row = 1,
    col = 1,
    border = "single",
    style = "minimal",
    width = math.floor(vim.o.columns * 0.985),
    height = math.floor(vim.o.lines * 0.8),
  }

  local jira_cmd = "jira"
  local jira_input = ""
  local buf = api.nvim_create_buf(false, true)
  local win = api.nvim_open_win(buf, true, opts)
  local term_job_id = fn.termopen(jira_cmd .. " " .. table.concat(args, " "), {
    on_exit = function(_, exit_code, _)
      if exit_code == 0 then
        api.nvim_win_close(win, true)
      else
        if exit_code == 127 then
          api.nvim_win_close(win, true)
          M.notify("JiraCli not found", logLevel)
        end
      end
    end,
  })
  fn.chansend(term_job_id, jira_input)
  cmd("startinsert")
end

return M
