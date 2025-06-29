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
    };
    initContent = ''fastfetch -l small
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };



home.file = {
  ".config/" = {
    source = ./dotfiles/.config;
    recursive = true;
  };
};
}
