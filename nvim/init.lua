require('plugins')
local lspconfig = require('lspconfig')

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
vim.opt.smartindent = true

-- LSP setup
lspconfig.sumneko_lua.setup {
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
}

-- Ayu theme setup
require('ayu').setup({
  mirage = true
})
vim.cmd 'colorscheme ayu'

-- Lualine setup
require('lualine').setup({
  options = {
    theme = 'ayu_mirage',
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
