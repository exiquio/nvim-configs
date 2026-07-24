# nvim-configs

A heavily customized [Neovim](https://neovim.io/) configuration forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). Built around the native Neovim package system with a custom bootstrap mechanism — no `lazy.nvim` or `packer.nvim` required.

---

## Features

- **No plugin manager** — Uses Neovim's built-in `pack` system with a custom bootstrap that clones, loads, and self-cleans unused plugins on every startup
- **Dracula Pro** theme (private repository, requires SSH access)
- **AI-assisted coding** with [CodeCompanion](https://github.com/olimorris/codecompanion.nvim) + DeepSeek models (v4-flash / v4-pro)
- **Blazing-fast completion** via [blink.cmp](https://github.com/saghen/blink.cmp) (v1.3.0)
- **Full LSP ecosystem** with [mason.nvim](https://github.com/williamboman/mason.nvim) for auto-installing servers/linters
- **Syntax highlighting & indentation** via [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- **Fuzzy finding** with [Telescope](https://github.com/nvim-telescope/telescope.nvim) + fzf-native
- **Custom `@audit-*` keyword system** for `todo-comments.nvim` (8 audit keywords)
- **Auto-reload** on external file changes (timer + event-driven, no plugins)
- **Dynamic `colorcolumn`** — only shows when any line exceeds 120 characters
- **Self-cleaning** — removes plugin directories no longer listed in the configuration

---

## Plugin Table

### AI & Completion
| Plugin | Description |
|--------|-------------|
| [olimorris/codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim) | AI coding assistant (DeepSeek v4-flash / v4-pro) |
| [saghen/blink.cmp](https://github.com/saghen/blink.cmp) | Fast completion engine (pinned to v1.3.0) |

### UI / Editor Experience
| Plugin | Description |
|--------|-------------|
| [dracula-pro/vim](https://github.com/dracula-pro/vim) | Dracula Pro colorscheme (private repo, SSH) |
| [folke/which-key.nvim](https://github.com/folke/which-key.nvim) | Keymap popup helper |
| [stevearc/aerial.nvim](https://github.com/stevearc/aerial.nvim) | Code outline / symbol sidebar |
| [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-close brackets and quotes |
| [echasnovski/mini.nvim](https://github.com/echasnovski/mini.nvim) | Modular UI/utility library (mini.\*) |
| [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | Filetype icons (Nerd Font required) |

### LSP & Language Tooling
| Plugin | Description |
|--------|-------------|
| [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client configuration |
| [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) | LSP server / linter installer |
| [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Mason ↔ lspconfig bridge |
| [WhoIsSethDaniel/mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | Auto-install Mason tools |
| [j-hui/fidget.nvim](https://github.com/j-hui/fidget.nvim) | LSP status spinner |
| [folke/lazydev.nvim](https://github.com/folke/lazydev.nvim) | Lua language server enhancements |
| [bilal2453/luvit-meta](https://github.com/bilal2453/luvit-meta) | `vim.uv` type annotations |
| [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) | Formatter dispatcher |

### Fuzzy Finding
| Plugin | Description |
|--------|-------------|
| [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Lua utility library (Telescope dependency) |
| [nvim-telescope/telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | FZF-native sorting for Telescope |
| [nvim-telescope/telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim) | Telescope-style `vim.ui.select` |

### Syntax & Parsing
| Plugin | Description |
|--------|-------------|
| [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Treesitter parser integration |

### Git
| Plugin | Description |
|--------|-------------|
| [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git signs in the gutter |

### Markdown
| Plugin | Description |
|--------|-------------|
| [MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | In-buffer Markdown rendering |
| [mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint) | Linting engine (Markdown lint) |
| [bullets-vim/bullets.nvim](https://github.com/bullets-vim/bullets.nvim) | Auto-formatting Markdown lists |
| [dhruvasagar/vim-table-mode](https://github.com/dhruvasagar/vim-table-mode) | Markdown table formatting |

### Search
| Plugin | Description |
|--------|-------------|
| [windwp/nvim-spectre](https://github.com/windwp/nvim-spectre) | Multi-file search & replace |

### Annotations
| Plugin | Description |
|--------|-------------|
| [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlighted TODO/FIXME comments |

### Utilities
| Plugin | Description |
|--------|-------------|
| [NMAC427/guess-indent.nvim](https://github.com/NMAC427/guess-indent.nvim) | Auto-detect indentation style |

---

## Language Support

| Language | LSP Server | Formatter / Linter | Treesitter Parser |
|----------|-----------|-------------------|-------------------|
| Elixir | `expert` | — | `elixir`, `eex`, `heex` |
| Fish | `fish_lsp` | — | `fish` |
| JavaScript / TypeScript | `vtsls` | `eslint_d` | `javascript` |
| Lua | `lua_ls` | `stylua` | `lua`, `luadoc` |
| Markdown | `marksman` | `mdformat`, `markdownlint-cli2` | `markdown`, `markdown_inline` |
| Python | `basedpyright` | `ruff` | `python` |
| Solidity | `solidity_ls_nomicfoundation` | — | `solidity` |
| YAML | — | — | `yaml` |
| HTML | — | — | `html` |
| Diff | — | — | `diff` |

---

## Custom `@audit-*` Keyword System

`todo-comments.nvim` is configured with 8 custom audit keywords in addition to the built-in `TODO`/`FIXME`/`HACK`/etc.

| Keyword | Icon | Color |
|---------|------|-------|
| `@audit-info` | `` | hint |
| `@audit-ok` | `` | test |
| `@audit-warn` | `` | warning |
| `@audit-fail` | `` | error |
| `@audit-fix` | `` | error |
| `@audit-todo` | `` | info |
| `@audit-note` | `` | hint |
| `@audit-question` | `` | hint |

A custom `blink.cmp` source provides auto-completion for all these keywords in comments (with Solidity block-comment awareness).

---

## Setup

### Prerequisites

- **Neovim** ≥ 0.10 (uses `vim.loader`, `vim.lsp.config`, etc.)
- **Git** (for cloning plugins on first run)
- **Nerd Font** (required for UI icons)
- **Dracula Pro SSH access** — the theme is cloned via `git@github.com:dracula-pro/vim.git`

### Installation

```bash
git clone https://github.com/exiquio/nvim-configs.git ~/.config/nvim
```

On first launch, Neovim will automatically clone all plugins into its `pack` directory and apply configurations. Unused plugins are cleaned up automatically.

### Dracula Pro Theme

The Dracula Pro theme is a **private repository** and requires SSH access. If you do not have access, the configuration will fail on the `colorscheme dracula_pro` call. To use an alternative theme:

1. Edit `lua/custom/plugins/theme.lua` to replace the plugin entry.
2. Change the `vim.cmd.colorscheme(...)` call to your preferred theme.

### CodeCompanion

CodeCompanion is configured with DeepSeek models. Set the `DEEPSEEK_API_KEY` environment variable before launching Neovim:

```bash
export DEEPSEEK_API_KEY="your-api-key-here"
nvim
```

---

## Project Structure

```
~/.config/nvim/
├── init.lua                          # Entry point — bootstrap, load plugins, run configs
├── lua/
│   ├── config/
│   │   ├── options.lua               # Global editor options
│   │   ├── keymaps.lua               # Core key mappings
│   │   ├── autocommands.lua          # Autocmds (yank highlight, dynamic colorcolumn, treesitter)
│   │   └── autoreload.lua            # External file change detection (timer + events)
│   └── custom/
│       ├── plugins/                  # Plugin definitions — each file exports { plugins, config }
│       │   ├── init.lua              # Dynamic plugin loader (scans this directory)
│       │   ├── theme.lua             # Dracula Pro
│       │   ├── treesitter.lua
│       │   ├── lsp.lua               # LSP servers, Mason, lazydev
│       │   ├── blink.lua             # blink.cmp completion
│       │   ├── telescope.lua         # Fuzzy finder
│       │   ├── codecompanion.lua     # AI assistant
│       │   ├── gitsigns.lua
│       │   ├── todo-comments.lua     # @audit-* keywords
│       │   ├── conform.lua           # Formatter
│       │   ├── aerial.lua
│       │   ├── autopairs.lua
│       │   ├── bullets.lua
│       │   ├── guess-indent.lua
│       │   ├── markdown-lint.lua
│       │   ├── markdown-render.lua
│       │   ├── markdown-keymaps.lua
│       │   ├── mini.lua
│       │   ├── spectre.lua
│       │   ├── table-mode.lua
│       │   └── which-key.lua
│       └── blink/
│           └── todo-keywords.lua     # blink.cmp source for @audit-* completions
```

---

## Key Bindings

| Shortcut | Action |
|----------|--------|
| `<Space>` | Leader key |
| `<leader>sh` | Telescope: search help |
| `<leader>sf` | Telescope: find files |
| `<leader>sg` | Telescope: live grep |
| `<leader>ss` | Telescope: select built-in |
| `<leader>sn` | Telescope: Neovim config files |
| `<leader><leader>` | Telescope: buffers |
| `<leader>/` | Fuzzy search in current buffer |
| `<leader>gr` | LSP: references |
| `<leader>gd` | LSP: go to definition |
| `<leader>rn` | LSP: rename |
| `<leader>ca` | LSP: code action |
| `<leader>th` | LSP: toggle inlay hints |

---

## Requirements

| Dependency | Minimum Version | Notes |
|-----------|-----------------|-------|
| Neovim | 0.10+ | `vim.loader`, `vim.lsp.config`, `vim.uv` |
| Git | — | Required for plugin cloning |
| Nerd Font | — | Required for UI icons |
| Dracula Pro | — | **SSH access required** (private repo on GitHub) |
| DEEPSEEK_API_KEY | — | Required for CodeCompanion AI features |
