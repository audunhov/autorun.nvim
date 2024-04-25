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

These don't have user commands associated with them (yet?). Please provide some

#### auto

Asks for an optional buffer number, a pattern and command. When a file matching the pattern is saved, the command is run automatically. If a buffer is provided, stdout and stderr is piped there

#### saved

Asks for a buffer number and a command, then runs the command and pipes stdout and stderr to the buffer

Buffer number and command is saved between each run

#### clear_saved

Clears saved buffer number and command used by `saved()`

### Keybinds

These are my keybindings. Feel free to chose other ones. You must configure these on your own

```lua
local builtin = require('autorun.builtin')
vim.keymap.set('n', '<leader>aa', builtin.auto, {})
vim.keymap.set('n', '<leader>as', builtin.saved, {})
vim.keymap.set('n', '<leader>ac', builtin.clear_saved, {})

```
