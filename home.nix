{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "akugaseelan";
  home.homeDirectory = "/Users/akugaseelan";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Enable the WezTerm terminal emulator.
  programs.wezterm.enable = true;

  # Enable the .zrshrc file
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      drs = "sudo darwin-rebuild switch --flake ~/nix-darwin-config#MacBook-Pro";
      cd = "z";
      cat = "bat";
      lg = "lazygit";
      tamain = "tmux attach -t main";
      tnmain = "tmux new -s main";
      ic = "cd ~/Library/Mobile\\ Documents/com~apple~CloudDocs";
    };
    initContent = ''
      fastfetch -l small
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;

      # Fixed: Uses a literal newline to solve the 'expected escaped_char' error.
      # This recreates your two-line layout from the initial config.
      format = ''
        $nix_shell$fill$git_metrics
        $directory$git_branch$git_status$username$character '';

      fill = {
        symbol = " ";
        style = "none"; # Ensures transparency in tmux
      };

      # Core symbols from your initial config
      character = {
        success_symbol = "[◎](bold italic bright-yellow)";
        error_symbol = "[○](italic purple)";
        vimcmd_symbol = "[■](italic dimmed green)";
      };

      directory = {
        home_symbol = "⌂";
        style = "italic blue";
        truncation_length = 2;
      };

      git_branch = {
        symbol = "[△](bold italic bright-blue)";
        style = "italic bright-blue";
      };

      nix_shell = {
        style = "bold italic dimmed blue";
        symbol = "✶";
        format = "[$symbol nix⎪$state⎪]($style) ";
      };

      username = {
        style_user = "bright-yellow bold italic";
        style_root = "purple bold italic";
        format = "[⭘ $user]($style) ";
        disabled = false;
        show_always = false;
      };

      # Integrated Nerd Font icons from your conversion request
      aws.symbol = " ";
      buf.symbol = " ";
      bun.symbol = " ";
      c.symbol = " ";
      cpp.symbol = " ";
      cmake.symbol = " ";
      conda.symbol = " ";
      crystal.symbol = " ";
      dart.symbol = " ";
      deno.symbol = " ";
      docker_context.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      golang.symbol = " ";
      gradle.symbol = " ";
      haskell.symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      kotlin.symbol = " ";
      lua.symbol = " ";
      nodejs.symbol = " ";
      python.symbol = " ";
      ruby.symbol = " ";
      rust.symbol = "󱘗 ";
      scala.symbol = " ";
      swift.symbol = " ";
      zig.symbol = " ";

      # OS symbols list for the $os module
      os.symbols = {
        Alpaquita = " ";
        Alpine = " ";
        AlmaLinux = " ";
        Amazon = " ";
        Android = " ";
        Arch = " ";
        CentOS = " ";
        Debian = " ";
        Fedora = " ";
        FreeBSD = " ";
        Gentoo = " ";
        Ios = "󰀷 ";
        Kali = " ";
        Linux = " ";
        Macos = " ";
        Manjaro = " ";
        Mint = " ";
        NixOS = " ";
        OpenBSD = "󰈺 ";
        openSUSE = " ";
        Pop = " ";
        Raspbian = " ";
        Redhat = " ";
        Ubuntu = " ";
        Windows = "󰍲 ";
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.ghostty = {
    package = null;
    enable = true;
    enableZshIntegration = true;
    settings = {
      theme = "Nord";
      font-family = "FiraCode Nerd Font";
      font-size = 12.0;
      background-opacity = 0.75;
      background-blur = 20;
      window-height = 35;
      window-width = 135;
      macos-icon = "xray";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # Packages Neovim needs to function well (LSPs, compilers, etc.)
    extraPackages = with pkgs; [
      # Standard build tools for Treesitter/Mason
      gcc
      gnumake
      unzip
      wget

      # Core utilities for plugins (Telescope, etc.)
      ripgrep
      fd
      fzf
      lazygit

      # LSPs & Formatters
      lua-language-server
      nil # Nix LSP
      pyright # Python
      nodePackages.typescript-language-server
      stylua # Lua formatter
      shfmt # Shell formatter
    ];
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      telescope-fzf-native-nvim
    ];
  };

  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh"; # Uses the zsh managed by Nix
    terminal = "screen-256color";
    prefix = "C-a";
    keyMode = "vi";
    mouse = true;
    baseIndex = 1;
    escapeTime = 0;

    # Translations of your custom keybindings and settings
    extraConfig = ''
      # Split panes using | and -
      unbind %
      bind | split-window -h
      unbind '"'
      bind - split-window -v

      # Pane resizing
      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r h resize-pane -L 5
      bind -r m resize-pane -Z

      # Vi copy mode improvements
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection
      unbind -T copy-mode-vi MouseDragEnd1Pane

      # Custom kill session binding
      unbind q
      bind q kill-session

      set -g default-command "${pkgs.zsh}/bin/zsh --login"
      set -ag terminal-overrides ",xterm-256color:RGB"
    '';

    # Managing your plugins natively through Nix
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator # for navigating panes and vim/nvim with Ctrl-hjkl
      {
        plugin = nord;
        extraConfig = ''
          # Fix: Ensure the status bar and panes don't force a solid background
          # that clashes with Ghostty's opacity
          set -g window-style 'bg=default'
          set -g window-active-style 'bg=default'

          # Adjusting Nord status bar to be more transparent
          set -g status-style bg=default
        '';
      }
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-capture-pane-contents 'on'";
      }
      {
        plugin = continuum;
        extraConfig = "set -g @continuum-restore 'on'";
      }
    ];
  };

  home.file = {
    ".config/" = {
      source = ./dotfiles/.config;
      recursive = true;
    };
  };

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "/Users/akugaseelan/dev/dotfiles/.config/nvim";
}
