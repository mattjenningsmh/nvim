return {
    "rafaqz/ranger.vim",
    lazy = false,
    config = function()
        local map = vim.keymap.set
        local opt = { noremap = true, silent = true }
        local notify = vim.notify

        -- Set up Ranger with custom keybindings
        map('n', '<leader>rr', ':RangerEdit<CR>', opt)
        map('n', '<leader>rv', ':RangerVSplit<CR>', opt)
        map('n', '<leader>rs', ':RangerSplit<cr>', opt)
        map('n', '<leader>rt', ':RangerTab<cr>', opt)
        map('n', '<leader>ri', ':RangerInsert<cr>', opt)
        map('n', '<leader>ra', ':RangerAppend<cr>', opt)
        map('n', '<leader>rc', ':set operatorfunc=RangerChangeOperator<cr>g@', opt)
        map('n', '<leader>rd', ':RangerCD<cr>', opt)
        map('n', '<leader>rld', ':RangerLCD<cr>', opt)
    end,
}
