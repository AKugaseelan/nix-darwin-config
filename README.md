# nix-darwin-config

My declarative macOS configuration using [nix-darwin](https://github.com/nix-darwin/nix-darwin), [Home Manager](https://github.com/nix-community/home-manager), and [nix-homebrew](https://github.com/zhaofengli/nix-homebrew).

## Structure

```
.
├── flake.nix       # System-level config, packages, macOS defaults, Homebrew casks
├── home.nix        # User environment: shell, terminal, editor, prompt
└── dotfiles/
    └── .config/
        └── fastfetch/  # Fastfetch config
```

## What's Managed

### System (`flake.nix`)
- **Nix packages** — dev tools, CLI utilities, Terraform + Proxmox provider
- **Homebrew casks** — GUI apps (auto-updated and cleaned up on activation)
- **Fonts** — FiraCode Nerd Font
- **macOS defaults** — Dock (left, autohide, magnification), Finder, Trackpad, key repeat, screenshot path
- **Security** — Touch ID for `sudo`
- **Rosetta** — enabled for x86 compatibility

### User (`home.nix`)
- **Zsh** — completions, autosuggestions, syntax highlighting, aliases
- **Starship** — two-line prompt with Nord theme and Nerd Font icons
- **Neovim** — Nord theme, LSP, Treesitter, Telescope, file tree, autocomplete
- **Ghostty** — Nord theme, FiraCode Nerd Font, blur/transparency
- **tmux** — Nord theme, vi keys, mouse, session persistence (resurrect + continuum)
- **eza** — `ls` replacement with icons and git status
- **zoxide** — `cd` replacement (`z`)
- **fzf** — fuzzy finder with Zsh integration

## Usage

Apply the configuration:

```sh
sudo darwin-rebuild switch --flake ~/nix-darwin-config#MacBook-Pro
```

Or use the alias defined in the config:

```sh
drs
```

## Requirements

- [Determinate Nix](https://determinate.systems/nix-installer/) (or standard Nix with flakes enabled)
- macOS on Apple Silicon (`aarch64-darwin`)
