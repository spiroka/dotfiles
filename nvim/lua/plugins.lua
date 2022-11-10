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
  end,
  config = {
    display = {
      open_fn = require('packer.util').float
    }
  }
})
