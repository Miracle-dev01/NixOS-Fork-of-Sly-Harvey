require("nvim-tree").setup({
  view = {
    width = 30,
    side = "left",
  },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        file = true,
        folder = true,
        git = true,
      },
    },
  },
  filters = {
    dotfiles = false,
  },
})
