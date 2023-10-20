vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup({
  function(use)
    use 'wbthomason/packer.nvim' -- Packer plugin manager
    use 'neovim/nvim-lspconfig' -- Configurations for NVim LSP
    use 'nvim-treesitter/nvim-treesitter'
    use 'windwp/nvim-autopairs' -- Auto close bracket, quotes, etc...
    use 'windwp/nvim-ts-autotag' -- Use treesitter to autoclose and autorename html tag
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.4',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'tpope/vim-vinegar'
    use 'glench/vim-jinja2-syntax'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/vim-vsnip-integ'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'rafamadriz/friendly-snippets'
    use {
      's1n7ax/nvim-terminal',
      config = function()
        vim.o.hidden = true
        require('nvim-terminal').setup()
      end,
    }
    use 'virchau13/tree-sitter-astro'
    use { 'catppuccin/nvim', as = 'catppuccin' }
    use 'lukas-reineke/indent-blankline.nvim'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
  end,
  config = {
    display = {
      open_fn = require('packer.util').float
    }
  }
})
