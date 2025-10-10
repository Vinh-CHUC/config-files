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
require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["ac"] = "@class.outer",
        -- You can optionally set descriptions to the mappings (used in the desc parameter of
        -- nvim_buf_set_keymap) which plugins like which-key display
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true of false
      include_surrounding_whitespace = true,
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = { query = "@class.outer", desc = "Next class start" },
        ["]a"] = "@parameter.outer",
        --
        -- You can use regex matching and/or pass a list in a "query" key to group multiple queires.
        ["]o"] = "@loop.*",
        -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
        --
        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
        -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[a"] = "@parameter.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
      -- Below will go to either the start or the end, whichever is closer.
      -- Use if you want more granular movements
      -- Make it even more gradual by adding multiple queries and regex.
      goto_next = {
        ["]d"] = "@conditional.outer",
      },
      goto_previous = {
        ["[d"] = "@conditional.outer",
      }
    },
  },
}

local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

require('orgmode').setup({
  org_agenda_files = {'~/org-files/agenda/*'},
  org_default_notes_file = '~/org-files/notes.org',
})

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
local servers = { "erlangls", "hhvm", "lua_ls", "rust_analyzer", "hls", "pyright", "gopls", "terraformls", "ruff" }

for _, lsp in ipairs(servers) do
    vim.lsp.enable(lsp)
    vim.lsp.config(lsp, { capabilities = capabilities })
end

vim.lsp.enable("clangd")
vim.lsp.config("clangd", {cmd = { "clangd", "--clang-tidy"}, capabilities=capabilities })

-- NULL-LS
local null_ls = require("null-ls")
null_ls.setup({sources = { null_ls.builtins.formatting.black}})
------------------
-- NVIM LSP END --
------------------

--------
-- AI --
--------
vim.keymap.set(
    'n', '<leader>cca', '<CMD>CodeCompanionActions<CR>',
    {
        remap = false,
        desc = "CodeCompanionActions"
    }
)
vim.keymap.set(
    'n', '<leader>ccc', '<CMD>CodeCompanionChat<CR>',
    {
        remap = false,
        desc = "CodeCompanionChat"
    }
)
vim.keymap.set(
    {'n', 'v'}, '<leader>cce', ':CodeCompanion',
    {
        remap = false,
        desc = "CodeCompanionChat"
    }
)
