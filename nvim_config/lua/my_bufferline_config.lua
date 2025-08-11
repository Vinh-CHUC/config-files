require("bufferline").setup{
  options = {
    offsets = {{
      filetype = "neo-tree",
      highlight = "BufferLineFill",
      separator = true
    }}
  }
}
vim.keymap.set("n", "<Left>", "<cmd>BufferLineCyclePrev<CR>", { desc = "BufferLine: Cycle Previous" })
vim.keymap.set("n", "<Right>", "<cmd>BufferLineCycleNext<CR>", { desc = "BufferLine: Cycle Next" })
vim.keymap.set("n", "<leader>y", ":BufferLinePick<CR>", { desc = "BufferLine: Pick Tab" })
