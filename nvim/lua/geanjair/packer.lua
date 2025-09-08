vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {"catppuccin/nvim",
  	as = 'catppuccin',
  	config = function()
		vim.cmd('colorscheme catppuccin-mocha')
	end
  }

  use {'nvim-telescope/telescope.nvim',
  	tag = '0.1.8',
  	requires = { {'nvim-lua/plenary.nvim'} }
  }

  use ('nvim-treesitter/nvim-treesitter',{run = ':TSUpdate'})

  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup {}
    end
  }
  use 'norcalli/nvim-colorizer.lua'

  -- Mason: gerenciamento de LSPs/linters/formatters
  use { 'williamboman/mason.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }
  use { 'neovim/nvim-lspconfig' }
  -- Completion framework + fontes
  use { 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 'saadparwaiz1/cmp_luasnip' }
  -- Snippets
  use { 'L3MON4D3/LuaSnip' }
  use { 'rafamadriz/friendly-snippets' }
  -- (Opcional) ícones / formatting para o completion
  use { 'onsails/lspkind-nvim' }

end)
