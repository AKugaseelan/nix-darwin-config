{ config, pkgs, lib, ... }:

programs.ghostty = {
    enable = true;
    package = null;
    enableZshIntegration = true;

    settings = {
      # --- Visuals & Theme ---
      theme = "light:Catppuccin Latte,dark:Catppuccin Mocha";
      background-opacity = 0.76;
      background-blur = 20;

      # --- Typography ---
      font-family = "FiraCode Nerd Font";
      font-size = 12.0;

      # --- Window Style ---
      window-padding-x = 2;
      window-padding-y = 2;
      window-decoration = false; # Similar to titlebar-only/none
      confirm-close-surface = false;
      window-height = 35;
      window-width = 135;

      # --- Cursor & Interaction ---
      copy-on-select = true;
      cursor-style = "block";
      shell-integration-features = "no-cursor"; # Let nvim handle cursor shape

      # --- Tab Bar ---
      # Ghostty handles tabs differently, but we can match the placement
      macos-icon = "xray";
    };
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

home.file.".warp/themes/catppuccin_latte.yml".source = "${pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "warp";
    rev = "main";
    hash = "sha256-ypzSeSWT2XfdjfdeE/lLdiRgRmxewAqiWhGp6jjF7hE=";
}}/themes/catppuccin_latte.yml";

home.file.".warp/themes/catppuccin_mocha.yml".source = "${pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "warp";
    rev = "main";
    hash = "sha256-ypzSeSWT2XfdjfdeE/lLdiRgRmxewAqiWhGp6jjF7hE=";
}}/themes/catppuccin_mocha.yml";
