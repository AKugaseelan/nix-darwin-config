{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "aboog";
  home.homeDirectory = "/Users/aboog";

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

  # Enable the .zrshrc file
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

  programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      withRuby = false;
      withPython3 = false;

      plugins = with pkgs.vimPlugins; [
        # Visuals & UI
        catppuccin-nvim
        alpha-nvim
        bufferline-nvim
        nvim-colorizer-lua
        lualine-nvim
        nvim-web-devicons
        nvim-tree-lua
        which-key-nvim

        # Editing & Git
        comment-nvim
        nvim-autopairs
        nvim-surround
        gitsigns-nvim

        # Navigation
        telescope-nvim
        plenary-nvim

        # Syntax & LSP Ecosystem
        nvim-treesitter.withAllGrammars
        nvim-lspconfig
        nvim-cmp
        cmp-nvim-lsp
        luasnip
      ];

      initLua = ''
        ---------------------------------------------------------------------------
        -- CORE OPTIONS
        ---------------------------------------------------------------------------
        vim.g.mapleader = " "
        vim.opt.number = true
        vim.opt.relativenumber = true
        vim.opt.clipboard = "unnamedplus"
        vim.opt.shiftwidth = 4
        vim.opt.expandtab = true
        vim.opt.termguicolors = true
        vim.keymap.set('i', 'jk', '<ESC>', { noremap = true, silent = true })

        ---------------------------------------------------------------------------
        -- COLORSCHEME (must run before bufferline reads its highlight groups)
        ---------------------------------------------------------------------------
        require("catppuccin").setup({
          flavour = "auto",
          background = { light = "latte", dark = "mocha" },
          integrations = {
            alpha = true,
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            telescope = true,
            treesitter = true,
            which_key = true,
          },
        })
        vim.cmd.colorscheme "catppuccin"

        -- Re-apply when the terminal reports an appearance change.
        -- Uncomment only if live toggling doesn't already work.
        -- vim.api.nvim_create_autocmd("OptionSet", {
        --   pattern = "background",
        --   callback = function() vim.cmd.colorscheme "catppuccin" end,
        -- })

        ---------------------------------------------------------------------------
        -- PLUGIN CONFIGS
        ---------------------------------------------------------------------------

        -- Alpha Dashboard
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")
        dashboard.section.header.val = {
            [[                               __                ]],
            [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
            [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
            [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
            [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
            [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
        }
        alpha.setup(dashboard.opts)

        -- Lualine ('auto' follows the active colorscheme)
        require('lualine').setup {
          options = {
            theme = 'auto',
            section_separators = { left = ''', right = ''' },
            component_separators = { left = ''', right = ''' }
          }
        }

        -- Bufferline
        require("bufferline").setup {
          options = {
            mode = "buffers",
            separator_style = "slant",
            always_show_bufferline = true,
            offsets = {{ filetype = "NvimTree", text = "File Explorer", text_align = "left", separator = true }},
          },
          highlights = require("catppuccin.special.bufferline").get_theme(),
        }

        -- Which-Key
        local wk = require("which-key")
        wk.add({
          { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
          { "<leader>f", group = "File" },
          { "<leader>p", group = "Project" },
        })

        -- Nvim-Tree & Telescope
        require("nvim-tree").setup({})
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})

        -- Other Plugin Initializations
        require('colorizer').setup()
        require('Comment').setup()
        require('gitsigns').setup()
        require('nvim-autopairs').setup{}
        require('nvim-surround').setup{}

        ---------------------------------------------------------------------------
        -- AUTOCOMPLETE
        ---------------------------------------------------------------------------
        local cmp = require('cmp')
        cmp.setup({
          snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
          mapping = cmp.mapping.preset.insert({
                  ['<C-j>'] = cmp.mapping.select_next_item(),
                  ['<C-k>'] = cmp.mapping.select_prev_item(),
                  ['<C-Space>'] = cmp.mapping.complete(),
                  ['<C-e>'] = cmp.mapping.abort(),
                  ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                  ['<CR>'] = cmp.mapping({
                    i = function(fallback) fallback() end,
                  }),
                }),
          sources = { { name = 'nvim_lsp' } }
        })

        ---------------------------------------------------------------------------
        -- POWERSHELL LSP -- DISABLED
        -- powershell-editor-services was never actually installed (bundle_path
        -- pointed at a mason dir that doesn't exist), so the client exited 1 on
        -- every startup. Re-enable once the bundle is packaged declaratively,
        -- and port to vim.lsp.config/vim.lsp.enable at the same time.
        ---------------------------------------------------------------------------
        -- require('lspconfig').powershell_es.setup{
        --   bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
        --   shell = "pwsh",
        -- }
      '';
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

  home.file.".config/fastfetch/config.jsonc".source = ./dotfiles/.config/fastfetch/config.jsonc;
  home.file.".config/btop/btop.conf".text = ''
    color_theme = "tty"
    theme_background = False
    truecolor = True
    vim_keys = True
  '';

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

}
