require('my_basic_config')
require("config.lazy")
require('my_dap_config')
require('my_tabby_config')
require('my_telescope_config')

require('lualine').setup {
  extensions = {},
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {}
  },
  inactive_winbar = {},
  options = {
    always_divide_middle = true,
    component_separators = {
      left = "",
      right = ""
    },
    disabled_filetypes = {
      statusline = {},
      winbar = {}
    },
    globalstatus = false,
    icons_enabled = true,
    ignore_focus = {},
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000
    },
    section_separators = {
      left = "",
      right = ""
    },
    theme = "auto"
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename", "lsp_progress" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" }
  },
  tabline = {},
  winbar = {}
}

-------------------------
-- Autocompletion BEGIN -
-------------------------
local cmp = require("cmp")
cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<S-Tab>'] = cmp.mapping.scroll_docs(-4),
      ['<Tab>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
    },
    {
      { name = 'buffer' },
    })
  })

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({'/', '?'}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

vim.cmd("imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'");
vim.cmd("smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'");
vim.cmd("imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'");
vim.cmd("smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'");

-----------------------
-- Autocompletion END -
-----------------------

-- Tree-sitter configuration
-- Highlighting is provided by Neovim core. A FileType autocommand starts it for
-- every buffer that has a parser installed (falls back to legacy syntax otherwise).
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

require('nvim-treesitter-textobjects').setup({
  select = {
    -- Automatically jump forward to next textobject, similar to targets.vim
    lookahead = true,

    selection_modes = {
      ['@parameter.outer'] = 'v', -- charwise
      ['@function.outer'] = 'V', -- linewise
      ['@class.outer'] = '<c-v>', -- blockwise
    },
    include_surrounding_whitespace = true,
  },
  move = {
    set_jumps = true, -- whether to set jumps in the jumplist
  },
})

-- textobjects keymaps
local select = require 'nvim-treesitter-textobjects.select'
vim.keymap.set({ 'x', 'o' }, 'af', function()
  select.select_textobject('@function.outer', 'textobjects')
end, { desc = 'Select outer function' })
vim.keymap.set({ 'x', 'o' }, 'if', function()
  select.select_textobject('@function.inner', 'textobjects')
end, { desc = 'Select inner function' })
vim.keymap.set({ 'x', 'o' }, 'aa', function()
  select.select_textobject('@parameter.outer', 'textobjects')
end, { desc = 'Select outer parameter' })
vim.keymap.set({ 'x', 'o' }, 'ia', function()
  select.select_textobject('@parameter.inner', 'textobjects')
end, { desc = 'Select inner parameter' })
vim.keymap.set({ 'x', 'o' }, 'ac', function()
  select.select_textobject('@class.outer', 'textobjects')
end, { desc = 'Select outer class' })
vim.keymap.set({ 'x', 'o' }, 'ic', function()
  select.select_textobject('@class.inner', 'textobjects')
end, { desc = 'Select inner part of a class region' })

local move = require 'nvim-treesitter-textobjects.move'
vim.keymap.set({ 'n', 'x', 'o' }, ']m', function()
  move.goto_next_start('@function.outer', 'textobjects')
end, { desc = 'Next function start' })
vim.keymap.set({ 'n', 'x', 'o' }, ']]', function()
  move.goto_next_start('@class.outer', 'textobjects')
end, { desc = 'Next class start' })
vim.keymap.set({ 'n', 'x', 'o' }, ']a', function()
  move.goto_next_start('@parameter.outer', 'textobjects')
end, { desc = 'Next parameter start' })
vim.keymap.set({ 'n', 'x', 'o' }, ']o', function()
  move.goto_next_start({ '@loop.inner', '@loop.outer' }, 'textobjects')
end, { desc = 'Next loop' })
vim.keymap.set({ 'n', 'x', 'o' }, ']s', function()
  move.goto_next_start('@scope', 'locals')
end, { desc = 'Next scope' })
vim.keymap.set({ 'n', 'x', 'o' }, ']z', function()
  move.goto_next_start('@fold', 'folds')
end, { desc = 'Next fold' })

vim.keymap.set({ 'n', 'x', 'o' }, ']M', function()
  move.goto_next_end('@function.outer', 'textobjects')
end, { desc = 'Next function end' })
vim.keymap.set({ 'n', 'x', 'o' }, '][', function()
  move.goto_next_end('@class.outer', 'textobjects')
end, { desc = 'Next class end' })

vim.keymap.set({ 'n', 'x', 'o' }, '[m', function()
  move.goto_previous_start('@function.outer', 'textobjects')
end, { desc = 'Previous function start' })
vim.keymap.set({ 'n', 'x', 'o' }, '[[', function()
  move.goto_previous_start('@class.outer', 'textobjects')
end, { desc = 'Previous class start' })
vim.keymap.set({ 'n', 'x', 'o' }, '[a', function()
  move.goto_previous_start('@parameter.outer', 'textobjects')
end, { desc = 'Previous parameter start' })

vim.keymap.set({ 'n', 'x', 'o' }, '[M', function()
  move.goto_previous_end('@function.outer', 'textobjects')
end, { desc = 'Previous function end' })
vim.keymap.set({ 'n', 'x', 'o' }, '[]', function()
  move.goto_previous_end('@class.outer', 'textobjects')
end, { desc = 'Previous class end' })

-- Closest start-or-end movement
vim.keymap.set({ 'n', 'x', 'o' }, ']d', function()
  move.goto_next('@conditional.outer', 'textobjects')
end, { desc = 'Next conditional' })
vim.keymap.set({ 'n', 'x', 'o' }, '[d', function()
  move.goto_previous('@conditional.outer', 'textobjects')
end, { desc = 'Previous conditional' })

local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-------------------
-- NVIM LSP BEGIN -
-------------------
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufnr = args.buf
        local opts_with_buffer = { buffer = bufnr, noremap = true, silent = true }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
            vim.tbl_extend("error", opts_with_buffer, { desc = "[LSP] Go to declaration" }))
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
            vim.tbl_extend("error", opts_with_buffer, { desc = "[LSP] Go to definition" }))
        vim.keymap.set('n', 'K', vim.lsp.buf.hover,
            vim.tbl_extend("error", opts_with_buffer, { desc = "[LSP] Hover" }))
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
            vim.tbl_extend("error", opts_with_buffer, { desc = "[LSP] Go to implementation" }))
        vim.keymap.set('n', '<leader>td', vim.lsp.buf.type_definition,
            vim.tbl_extend("error", opts_with_buffer, { desc = "[LSP] Go to type definition" }))
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,
            vim.tbl_extend("error", opts_with_buffer, { desc = "[LSP] Rename" }))
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action,
            vim.tbl_extend("error", opts_with_buffer, { desc = "[LSP] Code actions" }))
        vim.keymap.set('n', 'gr', vim.lsp.buf.references,
            vim.tbl_extend("error", opts_with_buffer, { desc = "[LSP] References" }))
    end,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = { "erlangls", "hhvm", "lua_ls", "rust_analyzer", "hls", "pyright", "gopls", "terraformls", "ruff", "starpls" }

for _, lsp in ipairs(servers) do
    vim.lsp.enable(lsp)
    vim.lsp.config(lsp, { capabilities = capabilities })
end

vim.lsp.enable("clangd")
vim.lsp.config("clangd", {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy=false",
      "--completion-style=detailed",
      "--pch-storage=memory",
      "-j=4",
      "--limit-results=50"
    },
    capabilities = capabilities
})

-- NULL-LS
local null_ls = require("null-ls")
null_ls.setup({sources = { null_ls.builtins.formatting.black}})
------------------
-- NVIM LSP END --
------------------
