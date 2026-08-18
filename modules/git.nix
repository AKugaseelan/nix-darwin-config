{ config, pkgs, lib, ... }:
{
    programs.git = {
        enable = true;
        ignores = [ ".DS_Store" ];
        settings = {
        user.name = "Athi Boog";
        user.email = "athiraiyan.kugaseelan@outlook.com";
        init.defaultBranch = "main";
        gpg.format = "ssh";
        "gpg \"ssh\"".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
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
            IdentityAgent = ''"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'';
        };
        };
    };

    home.file.".ssh/allowed_signers".text = ''
        athiraiyan.kugaseelan@outlook.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH/2YZZdeXI6wpAJgQI5keazophEGGcLQLQcFlUKBSzR
    '';
}