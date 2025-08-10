require("codecompanion").setup({
    strategies = {
        chat = {
            adapter = "gemini",
            slash_commands = {
                ["file"] = {
                    -- Location to the slash command in CodeCompanion
                    callback = "strategies.chat.slash_commands.file",
                    description = "Insert a file",
                    opts = {
                        provider = "snacks",
                        contains_code = true,
                    },
                },
                ["buffer"] = {
                    -- Location to the slash command in CodeCompanion
                    callback = "strategies.chat.slash_commands.buffer",
                    description = "Insert open buffers",
                    opts = {
                        provider = "snacks",
                        contains_code = true,
                    },
                },
            },
        },

        inline = {
            adapter = "gemini",
        },
    },
})
