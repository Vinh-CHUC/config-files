-------------
-- General --
-------------

vim.opt.ffs = {'unix', 'dos', 'mac'}
-- vim.opt.wildignore:append {'*/build/*'}
vim.opt.clipboard = {'unnamed', 'unnamedplus'}

--------
-- UI --
--------
vim.o.scrolloff=16 -- Min amount of lines above/below the cursor
vim.o.cmdheight=2
vim.o.number=true
vim.o.showmatch=true
vim.o.matchtime=2
vim.o.foldcolumn='2'
vim.o.termguicolors=true

------------
-- Search --
------------
vim.o.ignorecase=true
vim.o.smartcase=true -- Case sensitive if pattern has upper case

----------------------
-- Mappings related --
----------------------
vim.o.timeoutlen=200

-------------------
-- Macro related --
-------------------
vim.o.lazyredraw=false

------------------------
-- Backups/swap files --
------------------------
vim.o.backup=false
vim.o.wb=false
vim.o.swapfile=false

---------------------
-- Tab/indentation --
---------------------
vim.o.expandtab=true  -- TABs to spaces
vim.o.smartindent=true
function set_indentation_options(indentation)
    vim.o.shiftwidth=indentation  -- << >>
    vim.o.tabstop=indentation  -- The width of an actual <Tab>
end
set_indentation_options(4)

----------------
-- Text width -- 
----------------
vim.o.textwidth=99
vim.opt.colorcolumn = {'+1'}
vim.o.wrap=true
vim.o.linebreak=true

--------------------
-- Autocompletion --
--------------------
vim.opt.completeopt = {'menu', 'menuone', 'noselect', 'longest'}

-----------------
-- Key mapping --
-----------------
vim.keymap.set({'n', 't'}, '<C-h>', '<CMD>NavigatorLeft<CR>')
vim.keymap.set({'n', 't'}, '<C-l>', '<CMD>NavigatorRight<CR>')
vim.keymap.set({'n', 't'}, '<C-k>', '<CMD>NavigatorUp<CR>')
vim.keymap.set({'n', 't'}, '<C-j>', '<CMD>NavigatorDown<CR>')

-- Leader keys
vim.g.mapleader = ";"
vim.g.maplocalleader = "."

vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { noremap = true })
vim.keymap.set("n", "<leader>to", ":tabonly<CR>", { noremap = true })
vim.keymap.set("n", "<Right>", ":tabn<CR>", { noremap = true })
vim.keymap.set("n", "<Left>", ":tabp<CR>", { noremap = true })
vim.keymap.set("n", "<leader>tmp", ":-tabmove<CR>", { noremap = true })
vim.keymap.set("n", "<leader>tmn", ":+tabmove<CR>", { noremap = true })

-- init.lua
vim.keymap.set("n", "<leader>ev", ":vsplit $MYVIMRC <cr>", {remap = false})
vim.keymap.set("n", "<leader>sv", ":source $MYVIMRC <cr>", {remap = false})
