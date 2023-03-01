local jiracli = require("jiracli.jira-module")
local keymap = vim.api.nvim_set_keymap
local default_config = {
  auto_cmd = {
    enable = true,
    which_key = true,
  },
}

-- Setup key mappings or which-key integration
local setup_key_mappings = function(config)
  if config.auto_cmd.which_key and pcall(require, "which-key") then
    local wk = require("which-key")
    wk.register({
      ["j"] = {
        name = "Jira",
        i = { "<cmd>JiraCliIssues<CR>", "Issues" },
        m = { "<cmd>JiraCliIssuesMe<CR>", "Issues Me" },
        c = { "<cmd>JiraCliIssuesBranch<CR>", "Issues Current" },
      },
    }, { prefix = "<leader>" })
  else
    -- Define key mappings for non-which-key setup
    vim.cmd("nnoremap <silent> <leader>ji :JiraCliIssues<CR>")
    vim.cmd("nnoremap <silent> <leader>jm :JiraCliIssuesMe<CR>")
    vim.cmd("nnoremap <silent> <leader>jc :JiraCliIssuesBranch<CR>")
  end
end

-- Define commands for opening Jira issues
local define_commands = function()
  vim.cmd("command! JiraCliIssues lua require'jiracli'.issues()")
  vim.cmd("command! JiraCliIssuesMe lua require'jiracli'.issues_me()")
  vim.cmd("command! JiraCliIssuesBranch lua require'jiracli'.issues_branch()")
end

-- Setup JiraCli plugin
local setup = function(config)
  config = config or default_config
  if config.auto_cmd.enable then
    setup_key_mappings(config)
  end
  define_commands()
end

return {
  issues = jiracli.issues,
  issues_me = jiracli.issues_me,
  issues_branch = jiracli.issues_branch,
  setup = setup,
}
