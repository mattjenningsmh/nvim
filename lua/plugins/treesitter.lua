return{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- Run this after install/update
    event = { "BufReadPost", "BufNewFile" }, -- Lazy-load on buffer open
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "html", "javascript", "tsx", "typescript", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
            sync_install = false,
            auto_install = true,

            highlight = {
                enable = true,
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                    return lang == "rust"
                end,
                additional_vim_regex_highlighting = false,
            },
        })
    end,
}

