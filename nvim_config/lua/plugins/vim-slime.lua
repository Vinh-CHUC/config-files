return {
    'jpalardy/vim-slime',
    config = function()
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

        -- Send FILENAME:Lstart-Lend for the current visual selection
        local function slime_send_selection_ref()
            local sf = vim.fn.getpos 'v'
            local ef = vim.fn.getpos '.'

            local current = vim.fn.expand('%:p')
            local root = vim.fs.root(0, '.git') or vim.fn.getcwd()
            local fn = current
            if current:find('^' .. vim.pesc(root) .. '/') then
                fn = current:sub(#root + 2)
            end

            local ref = string.format('%s:%d-%d', fn, sf[2], ef[2])
            vim.fn['slime#send'](ref)
        end

        vim.keymap.set('x', 'FF', slime_send_selection_ref, { remap = false })
        vim.keymap.set("x", "ff", "<Plug>SlimeRegionSend", { remap = false })
        vim.keymap.set('n', 'ff', '<Plug>SlimeParagraphSend', { remap = false })
    end
}
