vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  view = {
    width = 42
  },
  git = {
    ignore = false, -- Show git-ignored files and folders
  }
})
