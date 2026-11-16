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
vim.cmd.colorscheme("catppuccin")

---------------------------------------------------------------------------
-- UI
---------------------------------------------------------------------------
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

require("lualine").setup({
  options = {
    theme = "auto",
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },
})

require("bufferline").setup({
  options = {
    mode = "buffers",
    separator_style = "slant",
    always_show_bufferline = true,
    offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "left", separator = true } },
  },
  highlights = require("catppuccin.special.bufferline").get_theme(),
})

local wk = require("which-key")
wk.add({
  { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
  { "<leader>f", group = "File" },
  { "<leader>p", group = "Project" },
})

-- netrw is intentionally left enabled so `nvim scp://host//path` keeps working
require("nvim-tree").setup({
  view = { width = 35, relativenumber = true },
  renderer = { indent_markers = { enable = true } },
  actions = { open_file = { window_picker = { enable = false } } },
  filters = { custom = { ".DS_Store" } },
  git = { ignore = false },
})

---------------------------------------------------------------------------
-- TELESCOPE
---------------------------------------------------------------------------
local telescope = require("telescope")
local actions = require("telescope.actions")
telescope.setup({
  defaults = {
    path_display = { "truncate" },
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    },
  },
})
pcall(telescope.load_extension, "fzf")

local builtin = require("telescope.builtin")
-- original tutorial bindings
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Fuzzy find recent files" })
vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Find string in cwd" })
vim.keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Find string under cursor" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Show buffers" })
-- bindings from your current Nix config (delete whichever set you don't use)
vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>pg", builtin.live_grep, { desc = "Live grep" })

---------------------------------------------------------------------------
-- EDITING & GIT
---------------------------------------------------------------------------
require("colorizer").setup()
require("Comment").setup()
require("gitsigns").setup()
require("nvim-autopairs").setup({})
require("nvim-surround").setup({})

---------------------------------------------------------------------------
-- TREESITTER
-- Parsers come from Nix (withAllGrammars). Starting them per filetype works
-- on both the old and the rewritten nvim-treesitter, so no :setup() needed.
---------------------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})

---------------------------------------------------------------------------
-- COMPLETION
---------------------------------------------------------------------------
local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  completion = { completeopt = "menu,menuone,preview,noselect" },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Enter stays a plain newline
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
  formatting = {
    format = lspkind.cmp_format({ maxwidth = 50, ellipsis_char = "..." }),
  },
})

---------------------------------------------------------------------------
-- FORMATTING (format on save; falls back to the LSP, e.g. for Bicep)
---------------------------------------------------------------------------
local conform = require("conform")
conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    nix = { "nixfmt" },
    terraform = { "tofu_fmt" },
    tf = { "tofu_fmt" },
    ["terraform-vars"] = { "tofu_fmt" },
    yaml = { "prettier" },
    json = { "prettier" },
    markdown = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
  },
  format_on_save = { timeout_ms = 1000, lsp_format = "fallback" },
})
vim.keymap.set({ "n", "v" }, "<leader>mp", function()
  conform.format({ lsp_format = "fallback", timeout_ms = 1000 })
end, { desc = "Format file or range" })
