---@diagnostic disable: lowercase-global
vim = vim

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("keymaps")
require("config.lazy")

vim.cmd [[
 set mouse=
    set smartcase
    set hlsearch
    set ignorecase
    set tabstop=4
    set shiftwidth=4
    set smartindent
    set expandtab
    set autoindent
    set nowrap
    set rnu
    set nonu
    set ruler
    "colorscheme desert

    "highlight Normal guibg=272822
    "highlight Normal ctermbg=272822
    "highlight NonText ctermbg=272822
    "highlight NonText guibg=272822

    "netrw config (:Explore)
    let g:netrw_liststyle=3
    let g:netrw_banner=0

    "configure completions
    set omnifunc=lsp#complete
    set completeopt=menu,menuone,preview,noinsert


    "load plugins

    " Autocommand to execute :Lex when Vim starts
    " autocmd VimEnter * :20Lex
]]

if vim.g.neovide then
    vim.g.neovide_cursor_trail_size = 0.1
    vim.g.neovide_cursor_short_animation_length = 0.04
    vim.g.neovide_cursor_animation_length = 0.150
    vim.g.neovide_scale_factor = 1.0
    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-+>", function()
        change_scale_factor(1.25)
    end)
    vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1 / 1.25)
    end)
end

vim.opt.foldmethod = "indent"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = true
vim.opt.foldlevel = 1

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", "html", "css" },
  callback = function()
    vim.bo.tabstop = 2        -- Number of spaces that a <Tab> counts for
    vim.bo.shiftwidth = 2     -- Number of spaces used for each step of (auto)indent
    vim.bo.softtabstop = 2    -- How many spaces a Tab feels like when editing
    vim.bo.expandtab = true   -- Use spaces instead of tabs
  end,
})
