# Neovim Configuration Specification

> Personal reference document for maintenance and future development.
> macOS-only. Infrastructure/DevOps focus.

---

## Table of Contents

1. [Overview](#overview)
2. [Requirements](#requirements)
3. [Architecture](#architecture)
4. [Plugin Ecosystem](#plugin-ecosystem)
5. [AI Integration](#ai-integration)
6. [LSP & Development Tooling](#lsp--development-tooling)
7. [Keymap Taxonomy](#keymap-taxonomy)
8. [Git Workflow](#git-workflow)
9. [Terraform Workflow](#terraform-workflow)
10. [UI & UX](#ui--ux)
11. [Session Management](#session-management)
12. [Known Concerns](#known-concerns)
13. [Cleanup Candidates](#cleanup-candidates)
14. [Maintenance](#maintenance)
15. [Learning Resources](#learning-resources)

---

## Overview

### Purpose

This Neovim configuration provides a modern, AI-assisted development environment optimized for Infrastructure/DevOps work, including:

- Terraform/OpenTofu infrastructure code
- Python scripting and automation
- Bash/shell scripting
- Lua (Neovim configuration/plugin development)
- Occasional web development (JavaScript/TypeScript)

### Philosophy

- **AI-First Development**: Claude Code for architecture and complex tasks; Copilot for inline completions
- **Modal Awareness**: Statusline colors are the primary visual indicator for current mode
- **Per-Plugin Organization**: Each plugin has its own configuration file for easy maintenance
- **Lazy Loading**: Maximize startup performance through event-based plugin loading
- **Session Persistence**: Always restore previous session state on startup

### Scope

- **Platform**: macOS only (no cross-platform considerations)
- **Upstream**: Fully independent from kickstart.nvim (no upstream tracking)
- **Audience**: Personal reference for maintenance

---

## Requirements

### System Dependencies

| Dependency | Required | Notes |
|------------|----------|-------|
| Neovim | >= 0.10 | Supports both 0.10 (stable) and 0.11 (nightly) |
| Nerd Font | **Yes** | Hard requirement for icons/glyphs |
| Git | Yes | Version control integration |
| Node.js | Yes | For prettier, eslint_d, and LSP servers |
| Python 3 | Yes | For black, isort, pylint |
| Terraform | Yes | For terraform_fmt |
| LazyGit | Recommended | Git UI (`<leader>lg`) |

### External Tools (Auto-installed via Mason)

| Tool | Purpose |
|------|---------|
| stylua | Lua formatting |
| lua_ls | Lua LSP |
| prettier | JS/TS/Web formatting |
| eslint_d | JS/TS linting |
| black | Python formatting |
| isort | Python import sorting |
| pylint | Python linting |
| terraform_fmt | Terraform formatting |

---

## Architecture

### Directory Structure

```
~/.config/nvim/
├── init.lua                    # Main configuration (~627 lines)
├── lazy-lock.json              # Plugin version lock file
├── SPEC.md                     # This specification
└── lua/
    ├── custom/
    │   └── plugins/            # 29 individual plugin configs
    │       ├── init.lua        # Loads plenary.nvim
    │       ├── ai.lua          # Avante + Copilot
    │       ├── alpha.lua       # Dashboard
    │       ├── autopairs.lua   # Auto-pairing
    │       ├── auto-session.lua # Session persistence
    │       ├── bufferline.lua  # Buffer tabs
    │       ├── claudecode.lua  # Claude Code AI
    │       ├── colorscheme.lua # TokyoNight theme
    │       ├── comment.lua     # Commenting
    │       ├── dressing.lua    # UI enhancements
    │       ├── flash.lua       # Motion/jumping
    │       ├── formatting.lua  # conform.nvim
    │       ├── gitsigns.lua    # Git integration
    │       ├── grug-far.lua    # Search & replace
    │       ├── indent-blankline.lua # Indent guides
    │       ├── lazygit.lua     # LazyGit integration
    │       ├── linting.lua     # nvim-lint
    │       ├── lualine.lua     # Statusline
    │       ├── noice.lua       # Modern UI
    │       ├── nvim-cmp.lua    # Completion
    │       ├── oil.lua         # File explorer (buffer-based)
    │       ├── precommit.lua   # Pre-commit hooks
    │       ├── snacks.lua      # Terminal utilities
    │       ├── telescope.lua   # Fuzzy finder
    │       ├── todo-comments.lua # TODO highlighting
    │       ├── treesitter.lua  # Syntax parsing
    │       ├── trouble.lua     # Diagnostics list
    │       ├── vim-maximizer.lua # Split maximizing
    │       └── which-key.lua   # Keybinding help
    └── kickstart/
        └── plugins/
            └── debug.lua       # nvim-dap (optional, planned)
```

### Rationale: Per-Plugin Organization

Each plugin has its own file because:

1. **Easy to remove**: Delete one file to remove a plugin completely
2. **Clear ownership**: Each file is self-contained with all related config
3. **Reduces merge conflicts**: Changes to one plugin don't affect others
4. **Lazy.nvim compatible**: `{ import = 'custom.plugins' }` auto-loads all

### Plugin Manager: lazy.nvim

**Why lazy.nvim:**
- Modern, fast plugin manager with built-in lazy loading
- Excellent UI for plugin management (`:Lazy`)
- Automatic dependency resolution
- Lockfile for reproducible installs

**Loading Strategies Used:**

| Strategy | Example | Use Case |
|----------|---------|----------|
| `event` | `BufReadPre` | Load when file opened |
| `cmd` | `LazyGit` | Load on command |
| `keys` | `<leader>lg` | Load on keypress |
| `ft` | `lua` | Load for filetype |
| `VeryLazy` | which-key | Load after startup |
| `priority` | colorscheme | Load early |

---

## Plugin Ecosystem

### Complete Plugin List (~55 plugins)

#### Core

| Plugin | Purpose | Rationale |
|--------|---------|-----------|
| lazy.nvim | Plugin manager | Modern, fast, lazy-loading |
| plenary.nvim | Utility library | Required by many plugins |
| nvim-web-devicons | File icons | Visual file type indicators |

#### LSP & Completion

| Plugin | Purpose | Rationale |
|--------|---------|-----------|
| nvim-lspconfig | LSP configuration | Official LSP client config |
| mason.nvim | Tool installer | Easy LSP/linter installation |
| mason-lspconfig.nvim | Mason + LSP bridge | Automatic server setup |
| mason-tool-installer.nvim | Tool auto-install | Ensures required tools |
| nvim-cmp | Completion engine | Best-in-class completion |
| cmp-nvim-lsp | LSP source | LSP-powered completions |
| cmp-buffer | Buffer source | Text from current buffer |
| cmp-path | Path source | Filesystem paths |
| LuaSnip | Snippet engine | Modern snippet support |
| cmp_luasnip | Snippet source | LuaSnip integration |
| friendly-snippets | Snippet library | VSCode-style snippets |
| lspkind.nvim | Completion icons | VSCode-like icons |
| lazydev.nvim | Neovim Lua support | Neovim API completions |
| fidget.nvim | LSP status | Progress notifications |

#### Syntax & Parsing

| Plugin | Purpose | Rationale |
|--------|---------|-----------|
| nvim-treesitter | Syntax parsing | Modern syntax highlighting |
| nvim-ts-autotag | Auto-tag | HTML/JSX tag management |
| ts-comments.nvim | Smart comments | Context-aware commenting |

#### File Navigation

| Plugin | Purpose | Rationale |
|--------|---------|-----------|
| telescope.nvim | Fuzzy finder | Best fuzzy finder experience |
| telescope-fzf-native.nvim | FZF backend | Native performance |
| telescope-frecency.nvim | Frecency | Smart file ordering |
| oil.nvim | File explorer | Buffer-based directory editing |

#### Git Integration

| Plugin | Purpose | Rationale |
|--------|---------|-----------|
| gitsigns.nvim | Git signs | In-buffer git status |
| lazygit.nvim | Git UI | Full git interface |
| pre-commit.nvim | Pre-commit hooks | Hook enforcement |

#### AI Assistants

| Plugin | Purpose | Rationale |
|--------|---------|-----------|
| claudecode.nvim | Claude Code | Architecture/complex tasks |
| avante.nvim | AI assistant | Copilot-backed AI |
| copilot.lua | GitHub Copilot | Inline completions |

#### Formatting & Linting

| Plugin | Purpose | Rationale |
|--------|---------|-----------|
| conform.nvim | Formatting | Unified formatter interface |
| nvim-lint | Linting | Async linting |

#### UI Enhancements

| Plugin | Purpose | Rationale |
|--------|---------|-----------|
| tokyonight.nvim | Colorscheme | Custom dark theme |
| lualine.nvim | Statusline | Mode-aware status |
| bufferline.nvim | Buffer tabs | Tab-style buffers |
| alpha-nvim | Dashboard | Startup screen |
| noice.nvim | Modern UI | Better messages |
| dressing.nvim | UI improvements | Better input/select |
| indent-blankline.nvim | Indent guides | Visual indentation |
| which-key.nvim | Keymap help | Discoverable keybinds |

#### Editing

| Plugin | Purpose | Rationale |
|--------|---------|-----------|
| nvim-autopairs | Auto-pairing | Bracket/quote pairs |
| Comment.nvim | Commenting | Toggle comments |
| flash.nvim | Motion | Fast jumping |
| vim-maximizer | Split maximize | Focus on one split |
| mini.nvim | Text objects | Better a/i motions |

#### Utilities

| Plugin | Purpose | Rationale |
|--------|---------|-----------|
| trouble.nvim | Diagnostics | Diagnostic list view |
| todo-comments.nvim | TODO tracking | Highlight/find TODOs |
| grug-far.nvim | Search/replace | Project-wide replace |
| persistence.nvim | Sessions | Auto-save/restore |
| snacks.nvim | Terminal | Floating terminal |
| guess-indent.nvim | Auto-indent | Detect indentation |

---

## AI Integration

### Strategy: Division of Labor

```
┌─────────────────────────────────────────────────────────────┐
│                     AI Integration                          │
├─────────────────────────────────────────────────────────────┤
│  CLAUDE CODE (Primary)              │  COPILOT (Secondary)  │
│  • Architecture decisions           │  • Inline completions │
│  • Multi-file refactoring           │  • Quick suggestions  │
│  • Complex problem solving          │  • Code snippets      │
│  • Code review                      │                       │
│  • Documentation                    │                       │
├─────────────────────────────────────────────────────────────┤
│  AVANTE (Exploration)                                       │
│  • Rarely used, exploring capabilities                      │
│  • Copilot backend for suggestions                          │
└─────────────────────────────────────────────────────────────┘
```

### Claude Code Configuration

**File**: `lua/custom/plugins/claudecode.lua`

```lua
opts = {
  git_repo_cwd = true,           -- Use git root as cwd
  terminal_provider = 'auto',     -- Auto-detect terminal
  selection_tracking = {
    enabled = true,
    debounce_ms = 100,            -- 100ms debounce
  },
  diff_opts = {
    auto_show = true,             -- Auto-show diffs
  },
}
```

**Keymaps:**

| Key | Action | Mode |
|-----|--------|------|
| `<leader>cc` | Toggle Claude Code | n |
| `<leader>cf` | Focus Claude Code | n |
| `<leader>cm` | Select Model | n |
| `<leader>cs` | Send Selection | v |
| `<leader>ca` | Accept Changes | n |
| `<leader>cd` | Reject Changes | n |

---

## LSP & Development Tooling

### LSP Servers

**Currently Enabled:**

| Server | Language | Notes |
|--------|----------|-------|
| lua_ls | Lua | Full config with callSnippet |

**Available (commented, enable as needed):**

- clangd (C/C++)
- gopls (Go)
- pyright (Python)
- rust_analyzer (Rust)
- ts_ls (TypeScript/JavaScript)

### Formatters (conform.nvim)

| Filetype | Formatter(s) |
|----------|--------------|
| javascript, typescript, jsx, tsx | prettier |
| svelte, css, html, json, yaml | prettier |
| markdown, graphql, liquid | prettier |
| lua | stylua |
| python | isort → black |
| terraform, tf | terraform_fmt |

**Behavior:**
- Format on save (sync, 1s timeout)
- LSP fallback enabled
- Manual: `<leader>mp`

### Linters (nvim-lint)

| Filetype | Linter |
|----------|--------|
| javascript, typescript, jsx, tsx, svelte | eslint_d |
| python | pylint |

**Triggers:** BufEnter, BufWritePost, InsertLeave

### Treesitter

**Installed Parsers (22):**
```
json, javascript, typescript, tsx, yaml, html, css, prisma,
markdown, markdown_inline, svelte, graphql, bash, lua, vim,
dockerfile, gitignore, query, vimdoc, terraform, c
```

**Note:** Dynamic installation preferred. Consider reducing to essential subset.

### Planned: Debugging (nvim-dap)

Located in `lua/kickstart/plugins/debug.lua` (commented out).

When enabled, provides:
- F5: Start/Continue
- F1: Step Into
- F2: Step Over
- F3: Step Out
- `<leader>b`: Toggle Breakpoint
- `<leader>B`: Conditional Breakpoint
- F7: Toggle DAP UI

---

## Keymap Taxonomy

### Leader Key Groups

| Prefix | Domain | Rationale |
|--------|--------|-----------|
| `<leader>c` | Claude Code | AI assistant operations |
| `<leader>e` | Explorer | File tree operations |
| `<leader>f` | Find/Flash | Search and motion |
| `<leader>h` | Hunks | Git hunk operations |
| `<leader>l` | Lint | Linting operations |
| `<leader>m` | Make/Format | Code formatting |
| `<leader>p` | Pre-commit | Git hooks |
| `<leader>q` | Quickfix | Diagnostic list |
| `<leader>s` | Split/Search | Window and search ops |
| `<leader>t` | Toggle | Toggle features |
| `<leader>w` | Workspace | Session management |
| `<leader>x` | Trouble | Diagnostics/TODOs |

### Complete Keymap Reference

#### Global Keymaps (init.lua)

| Key | Action | Mode |
|-----|--------|------|
| `<Esc>` | Clear search highlights | n |
| `<leader>q` | Diagnostic quickfix | n |
| `<Esc><Esc>` | Exit terminal mode | t |

#### LSP Keymaps (on attach)

| Key | Action | Mode |
|-----|--------|------|
| `grn` | Rename symbol | n |
| `gra` | Code action | n, x |
| `grr` | Find references (Telescope) | n |
| `gri` | Find implementations | n |
| `grd` | Go to definition | n |
| `grD` | Go to declaration | n |
| `gO` | Document symbols | n |
| `gW` | Workspace symbols | n |
| `grt` | Type definition | n |
| `<leader>th` | Toggle inlay hints | n |

#### Telescope (`<leader>f*`)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files in cwd |
| `<leader>fr` | Frecency (frequent files) |
| `<leader>fo` | Old files (recent) |
| `<leader>fs` | Live grep (search text) |
| `<leader>fc` | Grep word under cursor |
| `<leader>ft` | Find TODOs |

**Insert mode (Telescope picker):**
- `<C-k>`: Previous result
- `<C-j>`: Next result
- `<C-q>`: Send to quickfix

#### File Explorer (oil.nvim)

| Key | Action |
|-----|--------|
| `-` | Open parent directory |
| `<leader>-` | Open parent (floating) |
| `<M-h>` | Open in split |

#### Git Hunks (`<leader>h*`)

| Key | Action | Mode |
|-----|--------|------|
| `]h` | Next hunk | n |
| `[h` | Previous hunk | n |
| `<leader>hs` | Stage hunk | n, v |
| `<leader>hr` | Reset hunk | n, v |
| `<leader>hS` | Stage buffer | n |
| `<leader>hR` | Reset buffer | n |
| `<leader>hu` | Undo stage hunk | n |
| `<leader>hp` | Preview hunk | n |
| `<leader>hb` | Blame line (full) | n |
| `<leader>hB` | Toggle line blame | n |
| `<leader>hd` | Diff this | n |
| `<leader>hD` | Diff this ~ | n |
| `ih` | Select hunk (text object) | o, x |

#### LazyGit

| Key | Action |
|-----|--------|
| `<leader>lg` | Open LazyGit |

#### Trouble (`<leader>x*`)

| Key | Action |
|-----|--------|
| `<leader>xw` | Workspace diagnostics |
| `<leader>xd` | Document diagnostics |
| `<leader>xq` | Quickfix list |
| `<leader>xl` | Location list |
| `<leader>xt` | TODOs in Trouble |

#### TODO Navigation

| Key | Action |
|-----|--------|
| `]t` | Next TODO |
| `[t` | Previous TODO |

#### Flash (Motion)

| Key | Action | Mode |
|-----|--------|------|
| `<leader>f` | Flash jump | n, x, o |
| `<leader>F` | Flash treesitter | n, x, o |

#### Formatting & Linting

| Key | Action | Mode |
|-----|--------|------|
| `<leader>mp` | Format file/range | n, v |
| `<leader>l` | Trigger linting | n |

#### Search & Replace

| Key | Action | Mode |
|-----|--------|------|
| `<leader>sr` | Open grug-far | n, v |

#### Session Management (`<leader>w*`)

| Key | Action |
|-----|--------|
| `<leader>wr` | Restore session for cwd |
| `<leader>ws` | Save session for cwd |
| `<leader>wl` | Restore last session |

#### Splits

| Key | Action |
|-----|--------|
| `<leader>sm` | Maximize/minimize split |

#### Pre-commit

| Key | Action |
|-----|--------|
| `<leader>pc` | Run pre-commit (current file) |

#### Claude Code (`<leader>c*`)

| Key | Action | Mode |
|-----|--------|------|
| `<leader>cc` | Toggle Claude Code | n |
| `<leader>cf` | Focus Claude Code | n |
| `<leader>cm` | Select Model | n |
| `<leader>cs` | Send Selection | v |
| `<leader>ca` | Accept Changes | n |
| `<leader>cd` | Reject Changes | n |

#### Treesitter Selection

| Key | Action |
|-----|--------|
| `<C-space>` | Init/expand selection |
| `<BS>` | Shrink selection |

### Known Keybinding Collisions

#### Flash vs Telescope (`<leader>f` prefix)

- **Flash**: `<leader>f` (single key) triggers jump
- **Telescope**: `<leader>ff`, `<leader>fr`, etc. (two keys)

**Impact**: Pressing `<leader>f` waits for timeout before triggering Flash.

**Workaround**: The 500ms timeout allows Telescope bindings to complete.

#### C-hjkl Conflicts

- **Oil**: Disables `<C-h/j/k/l>` to prevent conflicts
- **tmux.nvim**: Uses these for tmux pane navigation

**Status**: Considering tmux.nvim removal.

#### LSP Default Overrides

- Custom `gr*` mappings override some Neovim defaults
- This is intentional for Telescope integration

---

## Git Workflow

### Branch Naming Convention

Use conventional prefixes:

| Prefix | Use Case |
|--------|----------|
| `feature/` | New functionality |
| `fix/` | Bug fixes |
| `chore/` | Maintenance tasks |
| `docs/` | Documentation changes |
| `refactor/` | Code refactoring |
| `test/` | Test additions/changes |

**Examples:**
- `feature/add-terraform-validation`
- `fix/lsp-diagnostic-display`
- `chore/update-plugins`

### Commit Message Format

Use imperative mood without prefixes:

```
Add Terraform state file handling
Fix LSP diagnostic underline for errors only
Update plugin versions to latest stable
Refactor completion source ordering
```

**Guidelines:**
- Start with a verb (Add, Fix, Update, Remove, Refactor)
- Keep first line under 72 characters
- Body for additional context if needed

### Protected Branches

Pre-commit guards prevent direct commits on:

- `main`
- `master`
- `prod`

**Behavior:** Running `<leader>pc` on protected branches shows warning.

### Git Keybindings Quick Reference

| Key | Action |
|-----|--------|
| `<leader>lg` | Open LazyGit UI |
| `<leader>hs` | Stage hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hu` | Undo stage |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>pc` | Run pre-commit |
| `]h` / `[h` | Navigate hunks |

---

## Terraform Workflow

### Module Navigation

Use Telescope for navigating Terraform modules:

1. `<leader>ff` - Find files (use `*.tf` filter mentally or type in picker)
2. `<leader>fs` - Search for resource names, module references
3. `<leader>fc` - Search word under cursor (useful for resource references)

**Pattern:** Navigate from module calls → module definitions → resource implementations

### Plan/Apply Integration

LazyGit (`<leader>lg`) can be used for:
- Reviewing terraform plan output files
- Committing state-related documentation

For terraform commands, use terminal:
- snacks.nvim terminal (via Claude Code dependency)
- Native terminal (`:terminal`)

### HCL Formatting

**Formatter:** `terraform_fmt`

**Configuration:** (in `formatting.lua`)
```lua
terraform = { 'terraform_fmt' },
tf = { 'terraform_fmt' },
```

**Behavior:**
- Auto-format on save
- Manual: `<leader>mp`

### State File Handling

**Best Practice:** Never commit state files.

**gitignore patterns:**
```
*.tfstate
*.tfstate.*
.terraform/
```

---

## UI & UX

### Modal Awareness

**Critical Design Decision:** Statusline color is the primary mode indicator.

**lualine.lua** defines custom mode colors:

| Mode | Color | Hex |
|------|-------|-----|
| Normal | Blue | #65D1FF |
| Insert | Green | #3EFFDC |
| Visual | Violet | #FF61EF |
| Command | Yellow | #FFDA7B |
| Replace | Red | #FF4A4A |
| Inactive | Gray | #2c3043 |

**Rationale:** No cursor shape changes or other indicators; statusline is sufficient.

### TokyoNight Customization

**File:** `colorscheme.lua`

Custom dark blue variant:

| Element | Color |
|---------|-------|
| Background | #011628 |
| Background (dark) | #011423 |
| Background (highlight) | #143652 |
| Search | #0A64AC |
| Visual | #275378 |
| Foreground | #CBE0F0 |
| Gutter | #627E97 |

### Alpha Dashboard

Personalized startup screen with:
- macOS user's first name (via `dscl` lookup)
- Quick action buttons (new file, explorer, find, session)
- NEOVIM ASCII art header

### Diagnostic Display

| Severity | Icon | Underline | Virtual Text |
|----------|------|-----------|--------------|
| ERROR | 󰅚 | Yes | Yes |
| WARN | 󰀪 | No | Yes |
| INFO | 󰋽 | No | Yes |
| HINT | 󰌶 | No | Yes |

**Rationale:** Only ERROR gets underline to reduce visual noise.

---

## Session Management

### Behavior

**Plugin:** persistence.nvim

**Auto-restore:** Enabled on VimEnter when:
- `vim.fn.argc() == 0` (no files specified on command line)

**Session stores:**
- buffers
- curdir
- tabpages
- winsize

### Keybindings

| Key | Action |
|-----|--------|
| `<leader>wr` | Restore session for cwd |
| `<leader>ws` | Save session for cwd |
| `<leader>wl` | Restore last session |

### Session Location

```
~/.local/state/nvim/sessions/
```

---

## Known Concerns

### Plugin Conflicts

#### AI Plugins

- **Issue:** Claude Code, Copilot, and Avante can potentially compete
- **Current Status:** Managed by using each for different purposes
- **Monitoring:** Watch for completion interference

#### Navigation Plugins

- **Status:** Resolved - using oil.nvim as sole file explorer
- **Rationale:** Telescope + oil.nvim is sufficient for Infrastructure/DevOps workflow

#### LSP-Related

- **Issue:** Multiple plugins touch LSP (nvim-cmp, conform, lint)
- **Current Status:** Working but complex
- **Monitoring:** Watch for capability conflicts

### Keybinding Collisions

#### Flash vs Telescope

- **Issue:** `<leader>f` (Flash) vs `<leader>ff` (Telescope)
- **Impact:** 500ms delay when using Flash
- **Status:** Acceptable tradeoff

#### C-hjkl Navigation

- **Status:** Resolved - native split navigation via C-hjkl in init.lua
- **Note:** oil.nvim disables C-hjkl within oil buffers to avoid conflicts

#### LSP Overrides

- **Issue:** Custom `gr*` mappings override defaults
- **Status:** Intentional for Telescope integration

### Performance

- **Current Status:** Acceptable
- **Strategy:** Prevent regression through lazy loading
- **Monitoring:** Watch startup time with `:Lazy profile`

---

## Cleanup Log

The following cleanup items have been completed:

| Item | Status | Action Taken |
|------|--------|--------------|
| hardtime.nvim | ✅ Removed | Deleted plugin file |
| tmux.nvim | ✅ Removed | Deleted plugin file, added native C-hjkl split nav |
| nvim-tree.lua | ✅ Removed | Deleted plugin file, using oil.nvim instead |
| nvim-ts-autotag | ✅ Removed | Removed from treesitter dependencies |
| Trouble TODO binding | ✅ Removed | Removed `<leader>xt`, use `<leader>ft` instead |
| Treesitter parsers | ✅ Reduced | 22 → 10 essential parsers |

### Remaining Considerations

#### snacks.nvim Optimization

**Rationale:** Only using terminal feature for Claude Code dependency.

**Current State:** Full plugin installed, most features unused.

**Status:** Keep for now (Claude Code dependency)

---

## Maintenance

### Update Strategy

**Frequency:** Regular updates

**Process:**
1. Run `:Lazy update`
2. Check for breaking changes in `:Lazy log`
3. Test critical workflows (LSP, completion, formatting)
4. Commit `lazy-lock.json` if stable

### Testing Strategy

Before committing config changes:

1. **Syntax Check:**
   ```bash
   nvim --headless -c "luafile init.lua" -c "q"
   ```

2. **Plugin Load Test:**
   ```bash
   nvim --headless -c "Lazy" -c "q"
   ```

3. **Startup Profile:**
   ```
   :Lazy profile
   ```

4. **LSP Test:**
   - Open a Lua file
   - Verify `lua_ls` attaches (`:LspInfo`)
   - Test completion (`<C-Space>`)
   - Test formatting (`<leader>mp`)

5. **Keybinding Test:**
   - `<leader>ff` - Telescope files
   - `-` - oil.nvim (file explorer)
   - `<leader>cc` - Claude Code
   - `grr` - LSP references

### Backup & Recovery

#### Backup

```bash
# Full config backup
cp -r ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d)

# Just lock file (for plugin versions)
cp ~/.config/nvim/lazy-lock.json ~/nvim-lazy-lock.backup.json
```

#### Recovery from Broken Config

1. **Quick fix - disable custom plugins:**
   ```bash
   mv ~/.config/nvim/lua/custom/plugins ~/.config/nvim/lua/custom/plugins.disabled
   ```

2. **Full reset:**
   ```bash
   rm -rf ~/.local/share/nvim    # Plugin installations
   rm -rf ~/.local/state/nvim    # Sessions, undo history
   rm -rf ~/.cache/nvim          # Caches
   ```

3. **Restore from backup:**
   ```bash
   rm -rf ~/.config/nvim
   cp -r ~/.config/nvim.backup.YYYYMMDD ~/.config/nvim
   ```

#### Plugin Lock Restoration

```bash
# Restore specific plugin versions
cp ~/nvim-lazy-lock.backup.json ~/.config/nvim/lazy-lock.json
nvim --headless -c "Lazy restore" -c "q"
```

---

## Learning Resources

### Neovim

- [Neovim Documentation](https://neovim.io/doc/)
- [Lua Guide](https://neovim.io/doc/user/lua-guide.html)
- [Learn X in Y Minutes: Lua](https://learnxinyminutes.com/docs/lua/)

### Plugin Documentation

| Plugin | Documentation |
|--------|---------------|
| lazy.nvim | [GitHub](https://github.com/folke/lazy.nvim) |
| nvim-lspconfig | [GitHub](https://github.com/neovim/nvim-lspconfig) |
| nvim-cmp | [GitHub](https://github.com/hrsh7th/nvim-cmp) |
| telescope.nvim | [GitHub](https://github.com/nvim-telescope/telescope.nvim) |
| nvim-treesitter | [GitHub](https://github.com/nvim-treesitter/nvim-treesitter) |
| gitsigns.nvim | [GitHub](https://github.com/lewis6991/gitsigns.nvim) |
| conform.nvim | [GitHub](https://github.com/stevearc/conform.nvim) |
| trouble.nvim | [GitHub](https://github.com/folke/trouble.nvim) |
| claudecode.nvim | [GitHub](https://github.com/coder/claudecode.nvim) |
| mason.nvim | [GitHub](https://github.com/mason-org/mason.nvim) |

### LSP Servers

- [lua_ls (Lua)](https://luals.github.io/)
- [pyright (Python)](https://github.com/microsoft/pyright)
- [terraform-ls](https://github.com/hashicorp/terraform-ls)

### Formatters & Linters

- [stylua](https://github.com/JohnnyMorganz/StyLua)
- [prettier](https://prettier.io/)
- [black](https://black.readthedocs.io/)
- [eslint](https://eslint.org/)

---

*Last updated: Document creation*
*Configuration version: ~55 plugins via lazy.nvim*
