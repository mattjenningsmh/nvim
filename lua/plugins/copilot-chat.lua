return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" },                       -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        lazy = false,
        build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
            model = "claude-3.5-sonnet",
            mappings = {
                submit_prompt = {
                    normal = '<leader>s',
                    insert = '<CR>',
                }
            },
            show_help = true,
        },
        keys = {
            {
                "<leader>ai",
                function()
                    local input = vim.fn.input("Ask Copilot: ")
                    if input ~= "" then
                        vim.cmd("CopilotChat " .. input)
                    end
                end,
                desc = "CopilotChat - Ask input",
            },
            {
                "<leader>ac",
                function()
                    vim.cmd("CopilotChatToggle")
                end,
                desc = "CopilotChat - Open chat window",
            },
            {
                "<leader>ac",
                mode = "v",
                desc = "CopilotChat - Open chat with selection",
                function()
                    vim.cmd("CopilotChat")
                end,
            },
        },
    },
}
