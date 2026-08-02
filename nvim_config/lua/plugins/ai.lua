return {
    {
        'milanglacier/minuet-ai.nvim',
        config = function()
            require('minuet').setup {
                virtualtext = {
                    auto_trigger_ft = { 'python', 'cpp', 'rust', 'lua', 'typescript' },
                    keymap = {
                        -- accept whole completion
                        accept = '<leader>cca',
                        -- accept one line
                        accept_line = '<leader>ccl',
                        -- accept n lines (prompts for number)
                        -- e.g. "<leader>ccn 2 CR" will accept 2 lines
                        accept_n_lines = '<leader>ccn',
                        -- Cycle to prev completion item, or manually invoke completion
                        prev = '<leader>cck',
                        -- Cycle to next completion item, or manually invoke completion
                        next = '<leader>ccj',
                        dismiss = '<leader>ccd',
                    },
                },
                provider = 'openai_compatible',
                request_timeout = 2.5,
                throttle = 1500, -- Increase to reduce costs and avoid rate limits
                debounce = 600, -- Increase to reduce costs and avoid rate limits
                provider_options = {
                    openai_compatible = {
                        api_key = 'OPENROUTER_API_KEY',
                        end_point = 'https://openrouter.ai/api/v1/chat/completions',
                        model = 'deepseek/deepseek-v4-flash',
                        name = 'Openrouter',
                        optional = {
                            max_tokens = 128,
                            top_p = 0.8,
                            provider = {
                                -- Prioritize throughput for faster completion
                                sort = 'throughput',
                            },
                            -- disable thinking to avoid first token latency
                            reasoning_effort = 'none'
                        },
                    },
                },
            }
        end,
    },

    {
        "nickjvandyke/opencode.nvim",
        version = "*", -- Latest stable release
        dependencies = {
            {
                -- `snacks.nvim` integration is recommended, but optional
                ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
                "folke/snacks.nvim",
                optional = true,
                opts = {
                    input = {}, -- Enhances `ask()`
                    picker = { -- Enhances `select()`
                        actions = {
                            opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
                        },
                        win = {
                            input = {
                                keys = {
                                    ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                                },
                            },
                        },
                    },
                },
            },
        },
        config = function()
            vim.o.autoread = true -- Required for `vim.g.opencode_opts.events.reload`
            ---@type opencode.Opts
            vim.g.opencode_opts = {
                server = {
                    start = function()
                        require('snacks.terminal').open(opencode_cmd, snacks_terminal_opts)
                    end,
                },
            }
            local opencode_cmd = 'opencode --port'
            ---@type snacks.terminal.Opts
            local snacks_terminal_opts = {
                win = {
                    position = 'right',
                    enter = false,
                },
            }

            vim.keymap.set(
                { "n", "x" },
                "<leader>os",
                function()
                    local suffix = vim.fn.mode() == "n" and "_" or ""
                    return require("opencode").operator("@this ") .. suffix
                end,
                { desc = "Send to OpenCode", expr = true }
            )

            vim.keymap.set(
                "n",
                "<leader>ob",
                function() require("opencode").prompt("@buffer ") end,
                { desc = "Send buffer to OpenCode" }
            )

            vim.keymap.set(
                { 'n', 't' }, '<leader>ot',
                function()
                    require('snacks.terminal').toggle(opencode_cmd, snacks_terminal_opts)
                end,
                { desc = 'Toggle OpenCode' }
            )

            -- Optionally show upon submitting prompt
            vim.api.nvim_create_autocmd('User', {
                pattern = { 'OpencodeEvent:tui.command.execute' },
                callback = function(args)
                    ---@type opencode.server.Event
                    local event = args.data.event
                    if event.properties.command == 'prompt.submit' then
                        local win = require('snacks.terminal').get(opencode_cmd, { create = false })
                        if win then
                            win:show()
                        end
                    end
                end,
            })
        end,
    }
}
