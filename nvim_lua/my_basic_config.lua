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
local indentation = 4
vim.o.expandtab=true  -- TABs to spaces
vim.o.shiftwidth=indentation  -- << >>
vim.o.tabstop=indentation  -- The width of an actual <Tab>
vim.o.smartindent=true

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
vim.keymap.set("i", "jk", "<Esc>", {remap = false})

-- Simpler movement
vim.keymap.set("", "<right>", "gt")
vim.keymap.set("", "<left>", "gT")
vim.keymap.set("n", "<C-j>", "<C-W>j", {remap = false})
vim.keymap.set("n", "<C-k>", "<C-W>k", {remap = false})
vim.keymap.set("n", "<C-h>", "<C-W>h", {remap = false})
vim.keymap.set("n", "<C-l>", "<C-W>l", {remap = false})

-- Leader keys
vim.g.mapleader = "["
vim.g.maplocalleader = "["

-- init.lua
vim.keymap.set("n", "<leader>ev", ":vsplit $MYVIMRC <cr>", {remap = false})
vim.keymap.set("n", "<leader>sv", ":source $MYVIMRC <cr>", {remap = false})
