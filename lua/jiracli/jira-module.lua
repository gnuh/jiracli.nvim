local helper = require("helper")
local M = {}

-- This function opens the Jira terminal and shows the issues
-- assigned to the user
M.issues_me = function()
  helper.open_jira_terminal({ "issue", "list", "-a$(jira me)" })
end

-- This function finds the issue key associated with the current Git branch,
-- and opens the Jira terminal to show the issues associated with that key
M.issues_branch = function()
  local current_branch = helper.get_current_branch()
  local project_key = helper.get_project_key()
  local issue_key = helper.find_issue_from_repo(current_branch, project_key)
  if issue_key ~= nil then
    local jiraArgs = { "issue", "list", "-q 'key=" .. issue_key .. "'" }
    helper.open_jira_terminal(jiraArgs)
  else
    local simulate_branch = "feat/" .. project_key .. "-77/new-feature"
    local log = vim.log.levels.WARNING
    helper.notify("Invalid branch, use something like " .. simulate_branch, log)
  end
end

-- This function opens the Jira terminal
M.issues = function()
  helper.open_jira_terminal()
end

return M
