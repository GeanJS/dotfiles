-- === Mason & Mason-lspconfig ===
local has_mason, mason = pcall(require, 'mason')
if has_mason then
  mason.setup({
    ui = {
      border = 'rounded',
      icons = { package_installed = '✓', package_pending = '➜', package_uninstalled = '✗' },
    },
  })
end

local has_mason_lspconfig, mason_lspconfig = pcall(require, 'mason-lspconfig')
if has_mason_lspconfig then
  mason_lspconfig.setup({
    -- altere a lista abaixo para os servidores que você quer garantir instalados
    ensure_installed = { 'pyright', 'ts_ls', 'lua_ls', 'gopls', 'bashls' },
    automatic_installation = true,
  })
end

-- === LSP common setup (capabilities + on_attach) ===
local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')

local capabilities = vim.lsp.protocol.make_client_capabilities()
if cmp_nvim_lsp_ok then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

local on_attach = function(client, bufnr)
  -- binds úteis para LSP no buffer atual
  local buf_set_keymap = function(mode, lhs, rhs, desc)
    if desc then desc = 'LSP: ' .. desc end
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
  end

  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', 'goto definition')
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', 'goto declaration')
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', 'hover')
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', 'rename')
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', 'code action')
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', 'references')
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', 'format')
end

-- === Configurações por servidor (usa lspconfig) ===
if lspconfig_ok then
  local servers = { 'pyright', 'ts_ls', 'lua_ls', 'gopls', 'bashls' }
  for _, lsp in ipairs(servers) do
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    if lsp == 'lua_ls' then
      -- ajustes recomendados para a linguagem Lua (neovim config)
      opts.settings = {
        Lua = {
          runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
          diagnostics = { globals = { 'vim' } },
          workspace = { library = vim.api.nvim_get_runtime_file('', true), checkThirdParty = false },
          telemetry = { enable = false },
        },
      }
    end

    lspconfig[lsp].setup(opts)
  end
end

-- === LuaSnip + friendly-snippets ===
local luasnip_ok, luasnip = pcall(require, 'luasnip')
if luasnip_ok then
  -- carrega os snippets do friendly-snippets (formato vscode) automaticamente
  require('luasnip.loaders.from_vscode').lazy_load()
  luasnip.config.set_config({ history = true, updateevents = 'TextChanged,TextChangedI' })
end

-- === nvim-cmp (auto-complete) ===
local cmp_ok, cmp = pcall(require, 'cmp')
if cmp_ok then
  local lspkind_ok, lspkind = pcall(require, 'lspkind')

  cmp.setup({
    snippet = {
      expand = function(args)
        if luasnip_ok then
          luasnip.lsp_expand(args.body)
        end
      end,
    },

    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),

      -- Tab para navegar/expandir snippets
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip_ok and luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),

      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip_ok and luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),

    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
    }),

    formatting = lspkind_ok and {
      format = lspkind.cmp_format({ mode = 'symbol_text', maxwidth = 50 }),
    } or nil,
  })

  -- completion para cmdline
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = 'buffer' } },
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
  })
end

