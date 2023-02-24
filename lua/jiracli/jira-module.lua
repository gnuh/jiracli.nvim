local helper = require("helper")
local M = {}

function M.issues_me()
  helper.open_jira_terminal({ "issue", "list", "-a$(jira me)" })
end

function M.issues_branch()
  local current_branch = helper.get_current_branch()
  local project_key = helper.get_project_key()
  local issue_key = helper.find_issue_from_repo(current_branch, project_key)
  if issue_key ~= nil then
    helper.open_jira_terminal({
      "issue",
      "list",
      "-q 'key = " .. issue_key .. "'",
    })
  else
    local simulateBranch = "feat/" .. project_key .. "-77/new-feature"
    local log = vim.log.levels.WARNING
    helper.notify("Invalid Branch, use something like " .. simulateBranch, log)
  end
end

function M.issues()
  helper.open_jira_terminal()
end

return M
