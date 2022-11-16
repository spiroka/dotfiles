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
    use 'm4xshen/autoclose.nvim' -- Auto close bracket, quotes, etc...
    use 'Shatur/neovim-ayu' -- Ayu theme
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'tpope/vim-vinegar'
    use "glench/vim-jinja2-syntax"
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
  end,
  config = {
    display = {
      open_fn = require('packer.util').float
    }
  }
})
