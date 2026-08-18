{ config, pkgs, lib, ... }:

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