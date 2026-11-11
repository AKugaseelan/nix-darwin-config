{ config, pkgs, lib, ... }:
let
protonSshSign = pkgs.writeShellScript "proton-ssh-sign" ''
    export SSH_AUTH_SOCK="$HOME/.ssh/proton-pass-ssh-agent.sock"
    exec ${pkgs.openssh}/bin/ssh-keygen "$@"
'';
in
{
    programs.git = {
        enable = true;
        ignores = [ ".DS_Store" ];
        settings = {
        user.name = "Athi Boog";
        user.email = "athiraiyan.kugaseelan@outlook.com";
        init.defaultBranch = "main";
        gpg.format = "ssh";
        gpg.ssh.program = "${protonSshSign}";
        "gpg \"ssh\"".allowedSignersFile = "~/.ssh/allowed_signers";
        };
        signing = {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH/2YZZdeXI6wpAJgQI5keazophEGGcLQLQcFlUKBSzR";
        signByDefault = true;
        };
    };

        programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        includes = [ "~/.orbstack/ssh/config" ];
        settings = {
        "ssh.dev.azure.com" = {
            Host = "ssh.dev.azure.com";
            User = "git";
            IdentityFile = "~/.ssh/id_rsa_devops.pub";
        };
        "*" = {
            IdentityAgent = "~/.ssh/proton-pass-ssh-agent.sock";
        };
        };
    };

    home.file.".ssh/allowed_signers".text = ''
        athiraiyan.kugaseelan@outlook.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH/2YZZdeXI6wpAJgQI5keazophEGGcLQLQcFlUKBSzR
    '';
}