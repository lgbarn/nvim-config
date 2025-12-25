# Neovim Configuration

[![Neovim](https://img.shields.io/badge/Neovim-0.9+-57A143?style=flat&logo=neovim&logoColor=white)](https://neovim.io/)
[![Lua](https://img.shields.io/badge/Lua-5.1-blue?style=flat&logo=lua&logoColor=white)](https://www.lua.org/)

A modern Neovim configuration based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) with extensive customizations for a productive development workflow.

## Features

- **AI-Powered Coding** - GitHub Copilot, Claude Code, and Avante integration
- **Modern LSP** - Language server support with Mason for easy installation
- **Fuzzy Finding** - Telescope with frecency-based file finding
- **Git Integration** - Gitsigns for in-buffer changes + LazyGit UI
- **File Navigation** - nvim-tree sidebar + oil.nvim for directory editing
- **Treesitter** - Advanced syntax highlighting and text objects
- **Session Management** - Auto-save and restore sessions
- **Beautiful UI** - TokyoNight theme, bufferline, lualine, and noice

## Prerequisites

### Required

| Tool | Purpose | Install (macOS) |
|------|---------|-----------------|
| Neovim >= 0.9 | Editor | `brew install neovim` |
| git | Version control | `brew install git` |
| make | Build tool | `xcode-select --install` |
| gcc | C compiler | `xcode-select --install` |
| ripgrep | Fast text search | `brew install ripgrep` |
| fd | Fast file finder | `brew install fd` |
| [Nerd Font](https://www.nerdfonts.com/) | Icons & glyphs | `brew install --cask font-hack-nerd-font` |

### Recommended

| Tool | Purpose | Install (macOS) |
|------|---------|-----------------|
| lazygit | Git UI | `brew install lazygit` |
| Node.js | JS/TS tooling | `brew install node` |
| Python 3 | Python tooling | `brew install python` |

### For Full Functionality

Formatters and linters (auto-installed by Mason when possible):

```bash
# JavaScript/TypeScript/Web
npm install -g prettier eslint_d

# Lua
# stylua is auto-installed by Mason

# Python
pip install black isort pylint
```

## Installation

1. **Backup existing config** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak
   mv ~/.local/state/nvim ~/.local/state/nvim.bak
   mv ~/.cache/nvim ~/.cache/nvim.bak
   ```

2. **Clone this repository**:
   ```bash
   git clone https://github.com/lgbarn/nvim.git ~/.config/nvim
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```
   Plugins will auto-install on first launch via lazy.nvim.

4. **Install language servers** (optional):
   Run `:Mason` and install servers for your languages.

## Plugins

### Plugin Manager

| Plugin | Description |
|--------|-------------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Modern plugin manager with lazy loading |

### LSP & Completion

| Plugin | Description |
|--------|-------------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configuration |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP/DAP/Linter/Formatter installer |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Mason + LSP integration |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion engine |
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | LSP completion source |
| [cmp-buffer](https://github.com/hrsh7th/cmp-buffer) | Buffer text completion |
| [cmp-path](https://github.com/hrsh7th/cmp-path) | File path completion |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | VSCode-style snippets |
| [lspkind.nvim](https://github.com/onsails/lspkind.nvim) | VSCode-like icons in completion |
| [lazydev.nvim](https://github.com/folke/lazydev.nvim) | Neovim Lua API completions |
| [fidget.nvim](https://github.com/j-hui/fidget.nvim) | LSP progress notifications |

### Syntax & Treesitter

| Plugin | Description |
|--------|-------------|
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting & parsing |
| [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) | Auto-close/rename HTML tags |
| [ts-comments.nvim](https://github.com/folke/ts-comments.nvim) | Context-aware commenting |

### Formatting & Linting

| Plugin | Description |
|--------|-------------|
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Code formatter (prettier, stylua, black) |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Code linter (eslint_d, pylint) |

### File Navigation

| Plugin | Description |
|--------|-------------|
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer sidebar |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | Edit directories like buffers |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | Native fzf integration |
| [telescope-frecency.nvim](https://github.com/nvim-telescope/telescope-frecency.nvim) | Frequency-based file finding |

### Git

| Plugin | Description |
|--------|-------------|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git signs in gutter |
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | LazyGit integration |

### AI & Code Assistance

| Plugin | Description |
|--------|-------------|
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | GitHub Copilot |
| [avante.nvim](https://github.com/yetone/avante.nvim) | AI coding assistant |
| [claudecode.nvim](https://github.com/coder/claudecode.nvim) | Claude Code integration |

### UI Enhancements

| Plugin | Description |
|--------|-------------|
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Color scheme |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status line |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Buffer tabs |
| [alpha-nvim](https://github.com/goolord/alpha-nvim) | Dashboard |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indentation guides |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keybinding help |
| [noice.nvim](https://github.com/folke/noice.nvim) | Modern UI for messages |
| [dressing.nvim](https://github.com/stevearc/dressing.nvim) | Improved UI elements |
| [nvim-notify](https://github.com/rcarriga/nvim-notify) | Notification system |

### Editing

| Plugin | Description |
|--------|-------------|
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-pair brackets/quotes |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Toggle comments |
| [flash.nvim](https://github.com/folke/flash.nvim) | Fast motion/jumping |
| [mini.nvim](https://github.com/echasnovski/mini.nvim) | Collection of modules (mini.ai) |
| [vim-maximizer](https://github.com/szw/vim-maximizer) | Maximize/restore splits |

### Utilities

| Plugin | Description |
|--------|-------------|
| [persistence.nvim](https://github.com/folke/persistence.nvim) | Session management |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlight TODO/FIXME |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnostics list |
| [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) | Search and replace |
| [snacks.nvim](https://github.com/folke/snacks.nvim) | Terminal and utilities |
| [tmux.nvim](https://github.com/aserowy/tmux.nvim) | Tmux integration (navigation + resize) |
| [hardtime.nvim](https://github.com/m4xshen/hardtime.nvim) | Break bad habits |

## Key Mappings

**Leader Key:** `<Space>`

### General

| Key | Action |
|-----|--------|
| `<Esc>` | Clear search highlights |
| `<C-h/j/k/l>` | Navigate splits (tmux-aware) |
| `<leader>q` | Open diagnostics quickfix |

### LSP

| Key | Action |
|-----|--------|
| `grn` | Rename symbol |
| `gra` | Code action |
| `grr` | Find references |
| `gri` | Go to implementation |
| `grd` | Go to definition |
| `grD` | Go to declaration |
| `gO` | Document symbols |
| `gW` | Workspace symbols |
| `<leader>th` | Toggle inlay hints |

### File Navigation

| Key | Action |
|-----|--------|
| `<leader>ee` | Toggle file explorer |
| `<leader>ef` | Find file in explorer |
| `<leader>ec` | Collapse explorer |
| `-` | Open oil.nvim (parent dir) |
| `<leader>ff` | Find files |
| `<leader>fr` | Frecency files |
| `<leader>fo` | Recent files |
| `<leader>fs` | Live grep |
| `<leader>fc` | Grep word under cursor |

### Git

| Key | Action |
|-----|--------|
| `<leader>lg` | Open LazyGit |
| `]h` / `[h` | Next/prev hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |

### AI / Claude Code

| Key | Action |
|-----|--------|
| `<leader>cc` | Toggle Claude Code |
| `<leader>cf` | Focus Claude Code |
| `<leader>cs` | Send selection |
| `<leader>ca` | Accept changes |
| `<leader>cd` | Reject changes |

### Editing

| Key | Action |
|-----|--------|
| `<leader>f` | Flash jump |
| `<leader>F` | Flash treesitter |
| `<leader>sm` | Maximize split |
| `<leader>mp` | Format file |
| `<leader>sr` | Search and replace |

### Diagnostics

| Key | Action |
|-----|--------|
| `<leader>xw` | Workspace diagnostics |
| `<leader>xd` | Document diagnostics |
| `<leader>xq` | Quickfix list |
| `<leader>xt` | TODOs |
| `]t` / `[t` | Next/prev TODO |

### Sessions

| Key | Action |
|-----|--------|
| `<leader>wr` | Restore session |
| `<leader>ws` | Save session |
| `<leader>wl` | Last session |

## Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Main entry point
├── lazy-lock.json           # Plugin lock file
└── lua/
    ├── custom/
    │   └── plugins/         # Plugin configurations (32 files)
    │       ├── alpha.lua
    │       ├── avante.lua
    │       ├── claudecode.lua
    │       ├── lsp.lua
    │       ├── telescope.lua
    │       └── ...
    └── kickstart/
        └── plugins/         # Kickstart framework plugins
```

## Customization

### Adding Plugins

Create a new file in `lua/custom/plugins/`:

```lua
-- lua/custom/plugins/example.lua
return {
  'author/plugin-name',
  config = function()
    require('plugin-name').setup({})
  end,
}
```

### Adding LSP Servers

Edit the LSP configuration in `init.lua` and add to the `servers` table:

```lua
local servers = {
  lua_ls = { ... },
  -- Add more:
  tsserver = {},
  pyright = {},
  gopls = {},
}
```

Then run `:Mason` to install the servers.

### Changing Theme

The colorscheme is set in `init.lua`:

```lua
vim.cmd.colorscheme 'tokyonight-night'
```

## Troubleshooting

### Plugins not loading
Run `:Lazy` to open the plugin manager and press `S` to sync.

### LSP not working
1. Run `:Mason` and verify the server is installed
2. Run `:LspInfo` to check server status
3. Ensure the filetype is correct with `:set ft?`

### Icons not showing
Ensure you have a Nerd Font installed and configured in your terminal.

### Treesitter errors
Run `:TSUpdate` to update parsers, or `:TSInstall <language>` for specific languages.

## Credits

- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) - Base configuration
- All plugin authors for their excellent work
