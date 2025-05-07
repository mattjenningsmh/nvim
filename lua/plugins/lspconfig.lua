return {
    -- LSP configuration plugin
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },  -- Load LSP only when needed
        dependencies = {
            "williamboman/mason.nvim",           -- LSP server manager
            "williamboman/mason-lspconfig.nvim", -- Mason + LSPConfig bridge
        },
        config = function()
            require("mason").setup()           -- Setup Mason
            require("mason-lspconfig").setup() -- Bridge between Mason and LSPConfig

            -- Add LSP server configurations
            local lspconfig = require("lspconfig")

            -- Define a global on_attach function for keybindings
            local on_attach = function(client, bufnr)
                -- Keybinding options
                local opts = { buffer = bufnr, silent = true }

                -- General LSP keybindings
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)                   -- Go to definition
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)                  -- Go to declaration
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)                   -- Show references
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)               -- Go to implementation
                vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)              -- Go to type definition
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)                         -- Show hover documentation
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)               -- Rename symbol
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- Code actions
                vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)         -- Show diagnostics
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)                 -- Go to previous diagnostic
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)                 -- Go to next diagnostic
                vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist,
                    { desc = "open disagnostics list", buffer = bufnr })                  -- Diagnostics to loclist
                vim.keymap.set("n", "<leader>F", function()
                    vim.lsp.buf.format({ async = true })                                  -- Format buffer
                end, { desc = "format code", buffer = bufnr })
            end

            -- Add LSP server setups
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Example: Lua (sumneko_lua)
            lspconfig.lua_ls.setup({
                on_attach = on_attach, -- Attach keybindings
                capabilities = capabilities,
                root_dir = vim.fn.getcwd(),
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                    },
                },
            })

            -- Example: Python (pyright)
            lspconfig.pyright.setup({
                on_attach = on_attach, -- Attach keybindings
                capabilities = capabilities,
            })


            local util = require("lspconfig.util")
            local home = os.getenv("HOME")
            local jar = home ..
                "/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher_1.7.0.v20250331-1702.jar"
            local config_dir = home .. "/.local/share/nvim/mason/share/jdtls/config"
            local root_dir = util.root_pattern("src")(vim.fn.expand("%:p")) or vim.fn.getcwd()
            local workspace_dir =
                vim.fn.stdpath("data") .. "/mason/share/jdtls/workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
            -- Java (jdtls)
            require("lspconfig").jdtls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                root_dir = function(fname)
                    return util.root_pattern("src")(fname)
                        or vim.fn.getcwd()
                end,
                cmd = {
                    "java",
                    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                    "-Dosgi.bundles.defaultStartLevel=4",
                    "-Declipse.product=org.eclipse.jdt.ls.core.product",
                    "-Dlog.protocol=true",
                    "-Dlog.level=ALL",
                    "-Xms1g",
                    "--add-modules=ALL-SYSTEM",
                    "--add-opens", "java.base/java.util=ALL-UNNAMED",
                    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
                    "-jar", jar,
                    "-configuration", config_dir,
                    "-data", workspace_dir
                },
            })

            -- C and C++ (clangd)
            require("lspconfig").clangd.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                cmd = {
                    "clangd",
                    "--fallback-style=Google",
                }
            })



            -- TypeScript and JavaScript (tsserver)
            require("lspconfig").ts_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            -- HTML (html)
            require("lspconfig").html.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            -- CSS (cssls)
            require("lspconfig").cssls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            --go (gopls)
            require("lspconfig").gopls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end,
    },
}
