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
    -- No `version`: tracks "main", which supports OpenCode v2 (stable releases are v1-only)
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {
            enabled = true, -- Enhances Ask
          },
          picker = {
            enabled = true, -- Enhances Select
            actions = {
              opencode_send = function(picker) ---@param picker snacks.Picker
                local items = vim.tbl_map(function(item) ---@param item snacks.picker.Item
                  return item.file
                  and require("opencode").format({ path = item.file, from = item.pos, to = item.end_pos })
                  or item.text
                end, picker:selected({ fallback = true }))
                require("opencode").prompt(table.concat(items, ", ") .. " ")
              end,
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
      local opencode_cmd = 'opencode'
      ---@type snacks.terminal.Opts
      local snacks_terminal_opts = {
        win = {
          position = 'right',
          enter = false,
        },
      }
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        server = {
          start = function()
            require('snacks.terminal').open(opencode_cmd, snacks_terminal_opts)
          end,
        },
      }

      vim.keymap.set(
        { "n", "x" },
        "<leader>os",
        function()
          local suffix = vim.fn.mode() == "n" and "_" or ""
          return require("opencode").operator("@this") .. suffix
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

      -- Show the terminal when OpenCode starts executing
      vim.api.nvim_create_autocmd('User', {
        pattern = { 'OpencodeEvent:session.execution.started' },
        callback = function()
          local win = require('snacks.terminal').get(opencode_cmd, { create = false })
          if win then
            win:show()
          end
        end,
      })
    end,
  },
}
