return {

  -- LSP

  {
    "neovim/nvim-lspconfig",
  },


  -- Mason (LSP/DAP installer)

  {
    "williamboman/mason.nvim",
    config = true,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",
          "ts_ls",
          "clangd",
          "lua_ls",
        },
      })
    end,
  },


  -- Completion

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
  },


  -- File Explorer

{
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons"
  },
  },

  -- Telescope

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },


  -- Bufferline

  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

 
  -- Treesitter
 
{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("config.treesitter")
  end,
},
  -- DAP (DEBUGGER - REQUIRED FOR F5)

  {
    "mfussenegger/nvim-dap",
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = true,
  },

{
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      integrations = {
        treesitter = true, -- Explicitly turns on Treesitter highlight mappings
      }
    })
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
},
  {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "black" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
},

-- Nvim Status

{
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }
},

-- runner

{
  "stevearc/overseer.nvim",
  opts = {},
  config = function()
    require("overseer").setup({
      strategy = "toggleterm",
    })
  end,
},

{
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 000,
    config = function()
        require("tiny-inline-diagnostic").setup()
        vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
    end,
},
}
