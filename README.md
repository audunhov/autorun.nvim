# Autorun
Automatically run commands on neovim save

## installation

```lua

-- using lazy.nvim
{
    'audunhov/autorun.nvim',
    opts = {}
}

```

## Usage

### Commands

All user commands are prefixed with :AutoRun

#### auto

Asks for an optional buffer number, a pattern and command. When a file matching the pattern is saved, the command is run automatically. If a buffer is provided, stdout and stderr is piped there

#### saved

Asks for a buffer number and a command, then runs the command and pipes stdout and stderr to the buffer

If no buffer is provided, the current buffer will be used

Buffer number and command is saved between each run

#### clear_saved

Clears saved buffer number and command used by `saved()`

### Keybinds

These are my keybindings. Feel free to chose other ones. You must configure these on your own

```lua
local builtin = require('autorun.builtin')
vim.keymap.set('n', '<leader>aa', builtin.auto, { desc = "[A]utoRun [A]uto"})
vim.keymap.set('n', '<leader>as', builtin.saved, { desc = "[A]utoRun [S]aved" })
vim.keymap.set('n', '<leader>ac', builtin.clear_saved, {desc = "[A]utoRun [C]lear"})

```
