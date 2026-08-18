{ config, pkgs, lib, ... }:

home.packages = with pkgs; [
    _1password-cli
    ansible
    ansible-lint
    azure-cli
    btop
    devcontainer
    kubeseal
    lazydocker
    lazygit
    mas
    nil
    nixd
    opentofu
    powershell
    rar
];