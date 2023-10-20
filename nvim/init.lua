require('plugins')
local lspconfig = require('lspconfig')
local telescope = require('telescope')
local cmp = require('cmp')
local luasnip = require('luasnip')

-- Setting NVim options
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.mouse = 'a'
vim.opt.cursorline = true
vim.opt.hlsearch = false
vim.opt.list = true
vim.opt.autoindent = true
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.termguicolors = true
vim.filetype.indent = true

-- Don't allow arrow keys in the following modes
for _, mode in pairs({ 'n', 'v', 'x' }) do
  for _, key in pairs({ '<Up>', '<Down>', '<Left>', '<Right>' }) do
    vim.keymap.set(mode, key, '<nop>')
  end
end

-- Mappings
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('t', '<Esc>',  '<C-\\><C-n>', opts)

-- Set filetype for .astro files
vim.filetype.add({
  extension = {
    astro = 'astro'
  }
})

-- Use an on_attach function to only map the following keys after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Mason
require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = { 'lua_ls', 'tsserver', 'stylelint_lsp', 'emmet_ls', 'eslint', 'astro', 'cssls' }
}

-- LSP setup
local lsp_defaults = lspconfig.util.default_config
lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

lspconfig.lua_ls.setup({
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})
lspconfig.tsserver.setup({
  on_attach = on_attach,
})
lspconfig.stylelint_lsp.setup({
  on_attach = on_attach,
  filetypes = { 'css', 'less', 'scss' }
})
lspconfig.emmet_ls.setup({
  on_attach = on_attach,
})
lspconfig.eslint.setup({
  on_attach = on_attach,
})
lspconfig.astro.setup({
  on_attach = on_attach,
})
lspconfig.cssls.setup({
  on_attach = on_attach,
  settings = {
    css = {
      validate = false, -- Don't validate CSS. PostCSS is not considered valid by the language server. Snippets still work.
    }
  }
})

-- TreeSitter setup
require('nvim-treesitter.configs').setup({
  ensure_installed = { 'javascript', 'tsx', 'typescript', 'astro', 'css' },
  autotag = {
    enable = true
  },
  highlight = {
    enable = true,
    disable = { 'lua' }
  }
})

vim.cmd('colorscheme catppuccin')

-- Lualine setup
require('lualine').setup({
  options = {
    theme = 'catppuccin',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'location'}
  }
})

-- Telescope setup
telescope.setup({
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--fixed-strings"
    }
  },
  pickers = {
    buffers = {
      mappings = {
        i = {
          ['<c-d>'] = 'delete_buffer'
        }
      }
    }
  }
})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-b>', builtin.buffers, {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})

-- autopairs setup
require('nvim-autopairs').setup({
  ignored_next_char = "[%w%.]"
})

-- nvim-cmp setup
require('luasnip.loaders.from_vscode').lazy_load()

function leave_snippet()
  if
    ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
      and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require('luasnip').session.jump_active
  then
    require('luasnip').unlink_current()
  end
end

-- stop snippets when you leave to normal mode
vim.api.nvim_command([[
  autocmd ModeChanged * lua leave_snippet()
]])

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp', keyword_length = 3},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
  mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm(),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          local entry = cmp.get_selected_entry()
          if not entry then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            cmp.confirm()
          end
        elseif luasnip.jumpable() then
          luasnip.jump(1)
        else
          fallback()
        end
      end, {"i","s","c",}),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          local entry = cmp.get_selected_entry()
          if not entry then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          else
            cmp.confirm()
          end
        elseif luasnip.jumpable() then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {"i","s","c",})
  }),
})
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(), -- important!
  sources = {
    { name = 'nvim_lua' },
    { name = 'cmdline' },
    { name = 'path' }
  },
})
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(), -- important!
  sources = {
    { name = 'buffer' },
  },
})

require('ibl').setup()
