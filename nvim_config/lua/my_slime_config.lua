vim.g.slime_target = "zellij"
vim.g.slime_python_ipython = 0
vim.g.slime_haskell_ghci_add_let = 0
vim.g.slime_default_config = {
    session_id = "current",
    relative_pane = "right",
    relative_move_back = "left"
}
vim.g.slime_dont_ask_default = 1
vim.g.slime_bracketed_paste = 1

vim.keymap.set("x", "ff", "<Plug>SlimeRegionSend", {remap = false})
vim.keymap.set("n", "ff", "<Plug>SlimeParagraphSend", {remap = false})
