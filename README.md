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

## Setup

Prerequisites for a fresh Mac before cloning this repo.

### 1. Install Xcode Command Line Tools

Required by Homebrew and other build tooling:

```sh
xcode-select --install
```

### 2. Install Nix

Use the [Determinate Nix Installer](https://determinate.systems/nix-installer/), which enables flakes out of the box:

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

> **Note:** Standard Nix also works, but requires manually enabling flakes in `/etc/nix/nix.conf`.



### 3. Install Homebrew

Homebrew is required for managing GUI apps and casks via `nix-homebrew`:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 4. Install Rosetta 2

Required for running x86 applications on Apple Silicon:

```sh
softwareupdate --install-rosetta --agree-to-license
```

### 5. Clone the Repository

```sh
git clone https://github.com/AKugaseelan/nix-darwin-config.git ~/nix-darwin-config
```

### 6. Apply the Configuration

See [Usage](#usage) below.

---

> **GUI Apps:** Applications installed via `environment.systemPackages` in `flake.nix` will **not** appear in Spotlight, as it does not index Nix symlinks. GUI apps are therefore managed through Homebrew casks instead — only CLI tools are installed via the Nix repository.

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