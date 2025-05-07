-- keymaps.lua
local map = vim.keymap.set
local notify = vim.notify
local opt = { noremap = true, silent = true }

-- general mappings

-- map("n", "<leader>e", ":20Lex<CR>", { desc = "Open file explorer" })
map("n", "<leader>e", ":RangerVSplit<CR>", { desc = "Open file explorer" })
map("n", "<Tab>", ":tabnext<CR>", { desc = "Next tab" })
map("n", "<S-Tab>", ":tabNext<CR>", { desc = "Previous tab", noremap = true })
map('n', '<C-`>', ':bel 15split | term<CR>', { noremap = true, silent = true })
map('t', '<Esc>', '<C-\\><C-n><C-w>k', { noremap = true })
map('n', 'O', 'o<Esc>k', { noremap = true })
map('n', '<leader>w', ':lclose<CR>', { noremap = true })
map('n', '<A-j>', ':m+1<CR>', opt)
map('n', '<A-k>', ':m-2<CR>', opt)
map('v', '<A-j>', ":m '>+1'<CR>gv", opt)
map('v', '<A-k>', ":m '<-2'<CR>gv", opt)
map('n', 'zM', ':lua vim.opt.foldlevel = 1<CR>', opt)
map('i', '<C-c>', '<Esc>', opt)
map('n', 's', '_ddko', opt)
map('n', '<leader>n', function() vim.wo.relativenumber = not vim.wo.relativenumber end, opt)

-- window sizing options
map("n", "<leader>ll", "<C-w>40<", { desc = "Shrink window left by 40" })
map("n", "<leader>dd", "<C-w>20-", { desc = "shrink window vertical by 20" })


-- match vim and system clipboard
map('v', 'y', '"+y', { noremap = true })
map('n', 'p', '"+p', { noremap = true })
map('n', 'dd', '"+dd', { noremap = true, desc = "Delete line and copy to system clipboard" })
map('v', 'x', '"+x', { noremap = true })

-- set vim directory to current buffer's directory
map('n', '<leader>cd', function()
    local current_dir = vim.fn.expand('%:p:h')
    vim.cmd('lcd ' .. current_dir)
    notify("Changed working directory to: " .. current_dir)
end, { noremap = true, desc = "Change working directory to current buffer's directory" })

-- Visual mode mappings
map('v', '(', 'xi()<Esc>hp', opt)
map('v', '{', 'xi{}<Esc>hp', opt)

-- special toggle for curly braces mapping
local function special_brace_mapping()
    map('i', '{', '{<CR>}<Esc>ko', { noremap = true })
    map('i', '}', '<Esc>la', { noremap = true })
    map('i', '(', '()<Esc>i', { noremap = true })
    map('i', ')', '<Esc>la', { noremap = true })
end

local function normal_brace_mapping()
    vim.api.nvim_del_keymap('i', '{')
    vim.api.nvim_del_keymap('i', '}')
    vim.api.nvim_del_keymap('i', ')')
    vim.api.nvim_del_keymap('i', '(')
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

-- terminal mapping functions
--map('n', '<S-Esc>', ':bel 10split | term<CR>', { noremap = true, silent = true })

local terminal_win = nil
local terminal_state = false
local function toggle_terminal()
    if terminal_state then
        terminal_state = false
        vim.api.nvim_win_close(terminal_win, true)
        notify("terminal close")
    else
        vim.cmd("bel 10 split | term")
        vim.cmd("startinsert!")
        notify("terminal open")
        terminal_state = true
        terminal_win = vim.api.nvim_get_current_win()
    end
end

map('n', '<S-Esc>', function() toggle_terminal() end, { noremap = true, silent = true })
map('i', '<S-Esc>', function() toggle_terminal() end, { noremap = true, silent = true })
map('t', '<S-Esc>', function() toggle_terminal() end, { noremap = true, silent = true })
