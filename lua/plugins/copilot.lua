return {
    "github/copilot.vim",
    lazy = false,
    config = function()

        local notify = vim.notify

        vim.g.copilot_enabled = false

        -- Set key mappings for Copilot
        vim.api.nvim_set_keymap('i', '<C-j>', 'copilot#Accept("<CR>")', { expr = true, silent = true, noremap = true })
        vim.api.nvim_set_keymap('i', '<C-k>', 'copilot#Dismiss()', { expr = true, silent = true, noremap = true })
        local function toggle_copilot()
            if vim.g.copilot_enabled then
                vim.g.copilot_enabled = false
            else
                vim.g.copilot_enabled = true
            end
            notify("toggled copilot")
        end

        -- mapping to toggle copilot 
        vim.keymap.set('n', '<leader>cp', function() toggle_copilot() end, { noremap = true })

        -- Optional: Configure Copilot suggestions
        vim.g.copilot_suggestion_enable_auto_trigger = true
        vim.g.copilot_suggestion_auto_trigger_delay = 500
    end,
}
