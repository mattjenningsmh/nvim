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
    set ruler
    set foldmethod=syntax
    


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

vim.opt.foldmethod = "indent"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = true
vim.opt.foldlevel = 1
