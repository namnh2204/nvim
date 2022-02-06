local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use {
    "wbthomason/packer.nvim",
    -- event = "VimEnter",
  } -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use {
    "windwp/nvim-autopairs",
    config = function()
      require "user.autopairs"
    end,
  } -- Autopairs, integrates with both cmp and treesitter
  use {
    "numToStr/Comment.nvim",
    config = function()
      require "user.comment"
    end,
  }
  -- Colorschemes
  use {
    "NvChad/nvim-base16.lua",
    after = "packer.nvim",
    config = function()
      require("colors").init()
    end,
  }

  use {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require "user.icons"
    end,
    after = "nvim-base16.lua",
  }
  use {
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons", -- optional, for file icon
    },
    after = "nvim-web-devicons",
    config = function()
      require "user.nvim-tree"
    end,
  }
  use {
    "akinsho/bufferline.nvim",
    after = "nvim-web-devicons",
    config = function()
      require "user.bufferline"
    end,
  }
  use "moll/vim-bbye"
  use {
    "nvim-lualine/lualine.nvim",
    after = "nvim-web-devicons",
    config = function()
      require "user.lualine"
    end,
  }
  use {
    "akinsho/toggleterm.nvim",
    config = function()
      require "user.toggleterm"
    end,
  }
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require "user.project"
    end,
  }
  use {
    "lewis6991/impatient.nvim",
    config = function()
      require "user.impatient"
    end,
  }
  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require "user.indentline"
    end,
  }
  use {
    "goolord/alpha-nvim",
    config = function()
      require "user.alpha"
    end,
  }
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use {
    "folke/which-key.nvim",
    config = function()
      require "user.whichkey"
    end,
  }
  use {
    "unblevable/quick-scope",
    config = function()
      require "user.quickscope"
    end,
  }
  use {
    "phaazon/hop.nvim",
    config = function()
      require "user.hop"
    end,
  }
  use {
    "andymass/vim-matchup",
    config = function()
      require "user.matchup"
    end,
  }
  use {
    "nacro90/numb.nvim",
    config = function()
      require "user.numb"
    end,
  }
  use {
    "monaqa/dial.nvim",
    config = function()
      require "user.dial"
    end,
  }
  use {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require "user.colorizer"
    end,
  }
  use {
    "windwp/nvim-spectre",
    config = function()
      require "user.spectre"
    end,
  }
  use {
    "folke/zen-mode.nvim",
    config = function()
      require "user.zen-mode"
    end,
  }
  use {
    "karb94/neoscroll.nvim",
    config = function()
      require "user.neoscroll"
    end,
  }
  use {
    "folke/todo-comments.nvim",
    config = function()
      require "user.todo-comments"
    end,
  }
  use "kevinhwang91/nvim-bqf"
  use "ThePrimeagen/harpoon"
  use {
    "MattesGroeger/vim-bookmarks",
    config = function()
      require "user.bookmark"
    end,
  }
  use {
    "blackCauldron7/surround.nvim",
    config = function()
      require "user.surround"
    end,
  }
  use {
    "Shatur/neovim-session-manager",
    config = function()
      require "user.session-manager"
    end,
  }
  use {
    "rcarriga/nvim-notify",
    config = function()
      require "user.notify"
    end,
  }
  use {
    "tversteeg/registers.nvim",
    config = function()
      require "user.registers"
    end,
  }
  use "metakirby5/codi.vim"
  use {
    "nyngwang/NeoZoom.lua",
  }
  -- use "metakirby5/codi.vim"
  use {
    "SmiteshP/nvim-gps",
    config = function ()
      require "user.gps"
    end
  }
  use { 'michaelb/sniprun', run = 'bash ./install.sh'}
  use {

    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  }

  -- cmp plugins
  use {
    "hrsh7th/nvim-cmp",
    commit = "d93104244c3834fbd8f3dd01da9729920e0b5fe7",
    config = function()
      require "user.cmp"
    end,
  } -- The completion plugin
  use {
    "hrsh7th/cmp-buffer",
  } -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use {
    "hrsh7th/cmp-cmdline",
  } -- cmdline completions
  use {
    "saadparwaiz1/cmp_luasnip",
  } -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-emoji"
  use {
    "hrsh7th/cmp-nvim-lua",
  }
  use {
    "tzachar/cmp-tabnine",
    config = function()
      local tabnine = require "cmp_tabnine.config"
      tabnine:setup {
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
      }
    end,

    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
  }
  -- use 'David-Kunz/cmp-npm' -- doesn't seem to work

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use {
    "rafamadriz/friendly-snippets",
    event = "InsertEnter"
  } -- a bunch of snippets to use

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require "user.lsp"
    end,
  }-- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use {
    "filipdutescu/renamer.nvim",
    config = function()
      require "user.renamer"
    end,
  }
  use {
    "simrat39/symbols-outline.nvim",
    config = function()
      require "user.symbol-outline"
    end,
  }
  use {
    "ray-x/lsp_signature.nvim",
  }
  use "b0o/SchemaStore.nvim"
  use {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  }
  use {
    "github/copilot.vim",
    config = function()
      require "user.copilot"
    end,
  }
  use {
    "RRethy/vim-illuminate",
    config = function ()
      require "user.illuminate"
    end
  }

  -- Java
  use "mfussenegger/nvim-jdtls"

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    config = function()
      require "user.telescope"
    end,
  }
  use "tom-anders/telescope-vim-bookmarks.nvim"
  use "nvim-telescope/telescope-media-files.nvim"
  use "nvim-telescope/telescope-ui-select.nvim"
  use {
    "nvim-telescope/telescope-file-browser.nvim",
    config = function()
      require "user.telescope-file-browser"
    end,
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require "user.treesitter"
    end,
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "p00f/nvim-ts-rainbow"
  use "nvim-treesitter/playground"
  use "windwp/nvim-ts-autotag"
  use {
    "romgrk/nvim-treesitter-context",
    config = function()
      require "user.ts-context"
    end,
  }
  use "mizlan/iswap.nvim"

  -- Git
  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require "user.gitsigns"
    end,
  }
  use {
    "f-person/git-blame.nvim",
    config = function()
      require "user.git-blame"
    end,
  }
  use {
    "ruifm/gitlinker.nvim",
    config = function()
      require "user.gitlinker"
    end,
  }
  use {
    "mattn/vim-gist",
    config = function()
      require "user.gist"
    end,
  }
  use "mattn/webapi-vim"
  use "https://github.com/rhysd/conflict-marker.vim"

  -- DAP
  use {
    "mfussenegger/nvim-dap",
    config = function()
      require("user.dap").setup()
    end,
  }
  use "theHamsta/nvim-dap-virtual-text"
  use {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("dapui").setup()
    end,
  }
  use {
    "Pocco81/DAPInstall.nvim",
    config = function()
      require("user.dap-install")
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
