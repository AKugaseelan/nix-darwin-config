{ config, pkgs, lib, ... }:

programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
        drs = "sudo darwin-rebuild switch --flake ~/nix-darwin-config#MacBook-Pro";
        nfu = "nix flake update";
        nua = "nix flake update --flake ~/nix-darwin-config && sudo darwin-rebuild switch --flake ~/nix-darwin-config#MacBook-Pro && git -C ~/nix-darwin-config add flake.lock && git -C ~/nix-darwin-config commit -m 'chore: Updated system fully using flake update and darwin rebuild && git -C ~/nix-darwin-config push";
        cd = "z";
        cat = "bat";
        lg = "lazygit";
        tamain = "tmux attach -t main";
        tnmain = "tmux new -s main";
        ic = "cd ~/Library/Mobile\\ Documents/com~apple~CloudDocs";
        pwsh-shell = "docker compose -f ~/dev/orbstack/pwsh/compose.yml exec pwsh pwsh";
        pwsh-start = "docker compose -f ~/dev/orbstack/pwsh/compose.yml up -d";
        pwsh-stop = "docker compose -f ~/dev/orbstack/pwsh/compose.yml stop";
    };
    sessionVariables = {
        SSH_AUTH_SOCK = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
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

      format = ''
        $nix_shell$fill$python$nodejs$rust$golang$docker_context$cmd_duration$git_metrics
        $directory$git_branch$git_status$username$character '';

      fill = {
        symbol = " ";
        style = "none";
      };

      character = {
        success_symbol = "[◎](bold italic bright-yellow)";
        error_symbol = "[○](italic purple)";
        vimcmd_symbol = "[■](italic dimmed green)";
      };

      directory = {
        home_symbol = "⌂";
        style = "italic blue";
        truncation_length = 2;
        truncation_symbol = "…/";
        read_only = " ◈";
        read_only_style = "italic dimmed red";
      };

      git_branch = {
        symbol = "[△](bold italic bright-blue)";
        style = "italic bright-blue";
      };

      git_status = {
        style = "italic dimmed yellow";
        format = "[$all_status$ahead_behind]($style) ";
        conflicted = "◇";
        ahead = "▲\${count}";
        behind = "▽\${count}";
        diverged = "◆";
        untracked = "·\${count}";
        stashed = "◱";
        modified = "△\${count}";
        staged = "▲\${count}";
        renamed = "▷\${count}";
        deleted = "▼\${count}";
      };

      git_metrics = {
        disabled = false;
        added_style = "italic dimmed green";
        deleted_style = "italic dimmed red";
        format = "[+$added]($added_style)[/-$deleted]($deleted_style) ";
      };

      cmd_duration = {
        min_time = 2000;
        style = "italic dimmed yellow";
        format = "[◷ $duration]($style) ";
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

      python.symbol = " ";
      nodejs.symbol = " ";
      rust.symbol = "󱘗 ";
      golang.symbol = " ";
      docker_context.symbol = " ";

      # Remaining symbols kept for modules not currently in $format
      aws.symbol = " ";
      buf.symbol = " ";
      bun.symbol = " ";
      c.symbol = " ";
      cpp.symbol = " ";
      cmake.symbol = " ";
      conda.symbol = " ";
      crystal.symbol = " ";
      dart.symbol = " ";
      deno.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      gradle.symbol = " ";
      haskell.symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      kotlin.symbol = " ";
      lua.symbol = " ";
      ruby.symbol = " ";
      scala.symbol = " ";
      swift.symbol = " ";
      zig.symbol = " ";

      os.symbols = {
        # (unchanged — add $os to format if you want these)
        Alpaquita = " ";
        Alpine = " ";
        AlmaLinux = " ";
        Amazon = " ";
        Android = " ";
        Arch = " ";
        CentOS = " ";
        Debian = " ";
        Fedora = " ";
        FreeBSD = " ";
        Gentoo = " ";
        Ios = "󰀷 ";
        Kali = " ";
        Linux = " ";
        Macos = " ";
        Manjaro = " ";
        Mint = " ";
        NixOS = " ";
        OpenBSD = "󰈺 ";
        openSUSE = " ";
        Pop = " ";
        Raspbian = " ";
        Redhat = " ";
        Ubuntu = " ";
        Windows = "󰍲 ";
      };
    };
};

