return {
    {
        'junegunn/fzf',
        build = './install --all',
    },
    {
        'junegunn/fzf.vim',
        dependencies = { 'junegunn/fzf' },
        config = function()
            -- optional mappings
            vim.keymap.set('n', '<leader>f', ':Files<CR>', { desc = 'Find Files' })
            vim.keymap.set('n', '<leader>b', ':Buffers<CR>', { desc = 'List Buffers' })
            vim.keymap.set('n', '<leader>g', ':Rg<Space>', { desc = 'Ripgrep Search' })
        end,
    }
}
