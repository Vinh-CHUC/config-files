vim.g.slime_target = "zellij"
vim.g.slime_python_ipython = 1
vim.g.slime_haskell_ghci_add_let = 0

vim.keymap.set("x", "ff", "<Plug>SlimeRegionSend", {remap = false})
vim.keymap.set("n", "ff", "<Plug>SlimeParagraphSend", {remap = false})
