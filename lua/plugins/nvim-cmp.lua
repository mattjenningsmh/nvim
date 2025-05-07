return {
    -- nvim-cmp (main completion plugin)
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",     -- LSP completion source
            "hrsh7th/cmp-buffer",       -- Buffer completion source
            "hrsh7th/cmp-path",         -- File path completion source
            "hrsh7th/cmp-cmdline",      -- Command-line completion source
            "L3MON4D3/LuaSnip",         -- Snippet engine
            "saadparwaiz1/cmp_luasnip", -- Snippet completion source
        },
        config = function()
            -- Load nvim-cmp
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    -- Required - Snippet engine setup
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),           -- Scroll docs up
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),            -- Scroll docs down
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
                    ["<C-Space>"] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.close()    -- Close completion menu
                        else
                            cmp.complete() -- Trigger completion
                        end
                    end, { "i", "s" }),    -- insert and select modes

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif cmp.visible() then
                            cmp.select_next_item() -- Navigate suggestions
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item() -- Navigate suggestions
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" }, -- LSP source
                    { name = "luasnip" },  -- Snippets
                }, {
                    { name = "buffer" },   -- Current buffer words
                    { name = "path" },     -- File paths
                }),
            })

            -- Command-line completions (e.g., for `:`)
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "path" },
                    { name = "cmdline" },
                },
            })

            -- Search completions (e.g., for `/`)
            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })
        end,
    },
}
