{ config, pkgs, lib, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    withPython3 = false;

    # Only on nvim's own PATH (wrapped), not installed globally.
    # Replaces Mason: nothing is downloaded at runtime.
    extraPackages = with pkgs; [
      # Telescope
      ripgrep
      fd

      # LSP servers
      terraform-ls
      bicep-lsp
      powershell # pwsh, needed to launch PowerShell Editor Services
      powershell-editor-services
      nil # Nix
      yaml-language-server
      lemminx # XML
      dockerfile-language-server
      docker-compose-language-service
      lua-language-server

      # Formatters (used by conform.nvim)
      stylua
      nixfmt
      prettier
      # tofu_fmt expects `tofu` on PATH -> comes from your packages.nix
    ];

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
      conform-nvim

      # Navigation
      telescope-nvim
      telescope-fzf-native-nvim
      plenary-nvim

      # Syntax & LSP
      nvim-treesitter.withAllGrammars
      nvim-lspconfig

      # Completion
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      friendly-snippets
      lspkind-nvim
    ];

    # Nix hands the PSES store path to Lua; the rest lives in ./nvim/*.lua.
    initLua =
      ''
        vim.g.pses_bundle_path = "${pkgs.powershell-editor-services}/lib/powershell-editor-services"
      ''
      + lib.concatMapStringsSep "\n" builtins.readFile [
        ./nvim/options.lua
        ./nvim/keymaps.lua
        ./nvim/plugins.lua
        ./nvim/lsp.lua
      ];
  };
}
