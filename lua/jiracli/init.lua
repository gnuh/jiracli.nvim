local jiracli = require("jiracli.jira-module")
local keymap = vim.api.nvim_set_keymap
local default_config = {
  auto_cmd = {
    enable = true,
    which_key = true,
  },
}

local function auto_cmd(auto_cmd)
  if auto_cmd.which_key and pcall(require, "which-key") then
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
    local opts = { noremap = true, silent = true }
    keymap("n", "<leader>ji", ":JiraCliIssues<CR>", opts)
    keymap("n", "<leader>jm", ":JiraCliIssuesMe<CR>", opts)
    keymap("n", "<leader>jc", ":JiraCliIssuesBranch<CR>", opts)
  end
end

local function setup(config)
  config = config or default_config
  if config.auto_cmd.enable then
    auto_cmd(config.auto_cmd)
  end
  vim.cmd([[
    command! JiraCliIssues lua require'jiracli'.issues()
    command! JiraCliIssuesMe lua require'jiracli'.issues_me()
    command! JiraCliIssuesBranch lua require'jiracli'.issues_branch()
  ]])
end

return {
  issues = jiracli.issues,
  issues_me = jiracli.issues_me,
  issues_branch = jiracli.issues_branch,
  setup = setup,
}
