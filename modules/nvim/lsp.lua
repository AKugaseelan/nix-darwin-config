---------------------------------------------------------------------------
-- LSP  (Neovim 0.11+ API: vim.lsp.config / vim.lsp.enable)
-- nvim-lspconfig supplies the default cmd/filetypes/root_markers per server.
-- The server binaries come from `extraPackages` in editor.nix, not Mason.
---------------------------------------------------------------------------

-- Neovim has no filetype for these by default
vim.filetype.add({
  extension = { bicep = "bicep", bicepparam = "bicep-params" },
})

vim.diagnostic.config({ virtual_text = true, severity_sort = true })

-- cmp capabilities for every server
vim.lsp.config("*", {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

-- Per-server overrides -------------------------------------------------------
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = { library = { vim.env.VIMRUNTIME }, checkThirdParty = false },
    },
  },
})

-- PowerShell Editor Services: path is injected from Nix (see editor.nix)
vim.lsp.config("powershell_es", {
  bundle_path = vim.g.pses_bundle_path,
})

-- Bicep has no default cmd. The binary name differs by packaging, so use
-- whichever exists on PATH (verify with: ls $(nix build nixpkgs#bicep-lsp --print-out-paths --no-link)/bin)
local bicep_cmd
for _, name in ipairs({ "bicep-lsp", "Bicep.LangServer", "bicep-langserver" }) do
  if vim.fn.executable(name) == 1 then
    bicep_cmd = name
    break
  end
end
if bicep_cmd then
  vim.lsp.config("bicep", { cmd = { bicep_cmd } })
end

-- Enable --------------------------------------------------------------------
local servers = {
  "terraformls",
  "powershell_es",
  "nil_ls",
  "yamlls",
  "lemminx",
  "dockerls",
  "docker_compose_language_service",
  "lua_ls",
}
if bicep_cmd then
  table.insert(servers, "bicep")
end
vim.lsp.enable(servers)

-- Keymaps (buffer-local, only when a server attaches) ------------------------
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
  callback = function(ev)
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
    end

    map("n", "gR", "<cmd>Telescope lsp_references<CR>", "Show LSP references")
    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions")
    map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations")
    map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "See available code actions")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Smart rename")
    map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics")
    map("n", "<leader>d", vim.diagnostic.open_float, "Show line diagnostics")
    map("n", "K", vim.lsp.buf.hover, "Show documentation under cursor")
    map("n", "<leader>rs", "<cmd>LspRestart<CR>", "Restart LSP")
  end,
})
