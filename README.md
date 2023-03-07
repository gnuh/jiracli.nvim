<div align='center'>
  <h1>
    <a href='https://github.com/arctouch-magnochiabai/gnu.vim' target='_blank'>
     <span>JiraCli.<img src='https://user-images.githubusercontent.com/101122677/220782485-0e5ea839-4f00-434d-94af-80d45f209bef.png'/>VIM</span>
    </a>
  </h1>
  <h3 align='center'> <code>JiraCli.Nvim</code> is a <a href='https://github.com/neovim/neovim'>Nvim</a> plugin that bridges <a href='https://github.com/ankitpokhrel/jira-cli' target='_blank'>Jira-Cli</a> with your favorite editor</h3>
  <br/>
</div>
<div align='center'>
  <img src='https://img.shields.io/github/last-commit/gnuh/jiracli.nvim' />
  <img src='https://img.shields.io/github/issues/gnuh/jiracli.nvim' />
  <img src='https://img.shields.io/github/forks/gnuh/jiracli.nvim' />
  <p>
  <br/>
  · <a href='https://github.com/gnuh/jiracli.nvim/issues' target='_blank'>
      Bug Report
    </a>
  · <a href='https://github.com/gnuh/jiracli.nvim/issues' target='_blank'>
      Request Feature
    </a>
  </p>
  <img src='https://user-images.githubusercontent.com/101122677/221088657-a75ec85e-c0ca-4be0-bb30-9ba989eae616.png' />
  <br/>
  <img src='https://user-images.githubusercontent.com/101122677/221088629-07126b37-0bab-4170-b21a-e2cd5c92f839.png' />
  <br/>
</div>

# Prerequisites

| Required                                             |
| ---------------------------------------------------- |
| [Jira-Cli](https://github.com/ankitpokhrel/jira-cli) |
| [Neovim 0.8+](https://github.com/neovim/neovim)      |

# Installation

```lua
use {
  "gnuh/jiracli.nvim",
  config = function()
    require("jiracli").setup()
  end
}
```

### Default Setup Options

```lua
-- Default
require("jiracli").setup({
  auto_cmd = {
    enable = true, -- enable auto command
    which_key = true, -- automatically creates which-key bindings
  }
})
```

<b>You need to call <code>require("jiracli").setup()</code> to make it work</b>

# Commands

| Action                 |                  Description                  |
| :--------------------- | :-------------------------------------------: |
| `:JiraCliIssues`       |                Get all issues                 |
| `:JiraCliIssuesMe`     |         Get all issues related to YOU         |
| `:JiraCliIssuesBranch` | Get Issues based on the branch that you're in |
| `k or up`              |            JiraCli navigation key             |
| `j or down`            |            JiraCli navigation key             |
| `v`                    |           View the selected `issue`           |
| `<CR> or Enter`        |   Open the selected `issue` in the browser    |

<b>`:JiraCliIssuesBranch` explanation:</b>

```
Get the "Issue" based on the branch that you're in.
"feat/ABCD-77/new-feature"
or
"bug-ABCD-77-found-a-bug"
The pattern is "ABCD-77" where "ABCD" is your "PROJECT-KEY"
and "77" is the "ISSUE-ID"
```

# Keybindings

```lua
local opts = { noremap = true, silent = true }
keymap("n", "<leader>ja", ":JiraCliIssues<CR>", opts)
keymap("n", "<leader>jm", ":JiraCliIssuesMe<CR>", opts)
keymap("n", "<leader>jb", ":JiraCliIssuesBranch<CR>", opts)
```

# Todo List

`Comming soon`
