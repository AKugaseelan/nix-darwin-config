{ config, pkgs, lib, ... }:
{
    programs.bat = {
        enable = true;
        themes = {
        "Catppuccin Latte" = {
            src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "main";
            hash = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
            };
            file = "themes/Catppuccin Latte.tmTheme";
        };
        "Catppuccin Mocha" = {
            src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "main";
            hash = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
            };
            file = "themes/Catppuccin Mocha.tmTheme";
        };
        };
        config = {
        theme-light = "Catppuccin Latte";
        theme-dark = "Catppuccin Mocha";
        };
    };

    programs.eza = {
        enable = true;
        enableZshIntegration = true;
        icons = "auto";
        git = true;
        extraOptions = [
        "--group-directories-first"
        "--header"
        "--time-style=relative"
        "--mounts"
        ];
    };

    programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
    };

    programs.fzf = {
        enable = true;
        enableZshIntegration = true;
    };

    home.file.".config/fastfetch/config.jsonc".source = ../dotfiles/.config/fastfetch/config.jsonc;
        home.file.".config/btop/btop.conf".text = ''
        color_theme = "tty"
        theme_background = False
        truecolor = True
        vim_keys = True
    '';
}