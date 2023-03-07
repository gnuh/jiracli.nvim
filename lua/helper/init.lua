local M = {}
local logLevel = vim.log.levels.ERROR
local api = vim.api
local fn = vim.fn

M.notify = function(msg, log)
  vim.notify(msg, log, {})
end

-- searches for an issue key in the given string that starts with the given prefix
M.find_issue_from_repo = function(str, prefix)
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

-- extracts the value associated with the 'key' field in a multi-line string
M.extract_key_value = function(str)
  local key_value = nil
  for line in str:gmatch("[^\r\n]+") do
    if line:find("^%s*key:%s*") then
      key_value = line:match("^%s*key:%s*(.-)%s*$")
    end
  end

  return key_value
end

-- retrieves the current Git branch name
M.get_current_branch = function()
  local git_cmd = "git rev-parse --abbrev-ref HEAD"
  local git_branch = fn.system(git_cmd)
  return git_branch:gsub("%s+", "")
end

-- retrieves the Jira project key from a configuration file
M.get_project_key = function()
  local jira_config = os.getenv("HOME") .. "/.config/.jira/.config.yml"
  local file = io.open(jira_config, "r")
  local contents = file:read("*all")
  if file then
    file:close()
  end
  return M.extract_key_value(contents)
end

-- opens a new terminal window with a Jira CLI command
M.open_jira_terminal = function(jira_args)
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
  vim.cmd("startinsert")
end

return M
