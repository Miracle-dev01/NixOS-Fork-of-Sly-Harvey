return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "storm", -- options: storm, night, day, moon
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = false },
        functions = {},
        variables = {},
      },
      sidebars = { "qf", "help", "neo-tree" },
      on_highlights = function(highlights, colors)
        highlights.Function = { fg = colors.blue, bold = true }
      end,
    })

    vim.cmd.colorscheme("tokyonight")
  end,
}