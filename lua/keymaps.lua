-- keymaps.lua
local map = vim.keymap.set
local notify = vim.notify
local opt = { noremap = true, silent = true }

-- general mappings
map("n", "<leader>e", ":20Lex<CR>", { desc = "Open file explorer" })
map("n", "<Tab>", ":tabnext<CR>", { desc = "Next tab" })
map("n", "<S-Tab>", ":tabNext<CR>", { desc = "Previous tab", noremap = true })
map('n', '<C-`>', ':bel 15split | term<CR>', { noremap = true, silent = true })
map('t', '<Esc>', '<C-\\><C-n><C-w>k', { noremap = true })
map('n', '<S-Esc>', ':bel 10split | term<CR>', { noremap = true, silent = true })
map('n', 'O', 'o<Esc>k', { noremap = true })
map('i', '(', '()<Esc>i', { noremap = true })
map('i', ')', '<Esc>la', { noremap = true })
map('n', '<leader>w', ':lclose<CR>', { noremap = true })
map('n', '<A-j>', ':m+1<CR>', opt)
map('n', '<A-k>', ':m-2<CR>', opt)
map('n', 'zM', ':lua vim.opt.foldlevel = 1<CR>', opt)
map('i', '<C-c>', '<Esc>', opt)

-- match vim and system clipboard
map('v', 'y', '"+y', { noremap = true })
map('n', 'p', '"+p', { noremap = true })
map('n', 'dd', '"+dd', { noremap = true, desc = "Delete line and copy to system clipboard" })
map('v', 'x', '"+x', { noremap = true })


-- Visual mode mappings
map('v', '(', 'xi()<Esc>hp', opt)
map('v', '{', 'xi{}<Esc>hp', opt)
-- special toggle for curly braces mapping
local function special_brace_mapping()
    map('i', '{', '{<CR>}<Esc>ko', { noremap = true })
    map('i', '}', '<Esc>la', { noremap = true })
end

local function normal_brace_mapping()
    map('i', '{', '{}<Esc>i', { noremap = true })
    map('i', '}', '<Esc>la', { noremap = true })
end



special_brace_mapping()

local brace_toggle_state = false
local function toggle_brace()
    if brace_toggle_state then
        special_brace_mapping()
        brace_toggle_state = false
        notify("brace mapping triggered")
    else
        normal_brace_mapping()
        brace_toggle_state = true
        notify('brace mapping undone')
    end
end
map('n', '<C-b>', function() toggle_brace() end, { noremap = true })

-- toggle mouse
local mouse_state = false
local function toggle_mouse()
    if mouse_state then
        vim.opt.mouse = ""
        notify("mouse disabled")
        mouse_state = false
    else
        vim.opt.mouse = "n"
        notify("mouse enabled")
        mouse_state = true
    end
end
map('n', '<C-j>', function() toggle_mouse() end, { noremap = true })
