-- Automatyczna instalacja lazy.nvim jeśli nie ma
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Inicjalizacja lazy.nvim
require("lazy").setup({
  -- Motyw kolorów
{
    "folke/tokyonight.nvim",
    priority = 1000, -- ładuj jako pierwszy
    config = function()
        require("tokyonight").setup({
            style = "night",
            transparent = true, -- przezroczyste tło jak kitty
        })
        vim.cmd("colorscheme tokyonight-night")
    end,
},
-- Pasek statusu
{
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                theme = "tokyonight",
                globalstatus = true,
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = { "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        })
    end,
}, 
-- Wyszukiwarka
{
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("telescope").setup({
            defaults = {
                layout_strategy = "horizontal",
                sorting_strategy = "ascending",
                layout_config = {
                    prompt_position = "top",
                },
            },
        })

        local map = vim.keymap.set
        map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Szukaj plików" })
        map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Szukaj tekstu" })
        map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Szukaj buforów" })
        map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Szukaj pomocy" })
    end,
},
-- Drzewo plików
{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            window = {
                width = 30,
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
            },
        })

        vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Drzewo plików" })
    end,
},
-- Podświetlanie składni
{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    main = "nvim-treesitter.config",
    opts = {
        ensure_installed = {
            "lua", "vim", "vimdoc",
            "python",
            "c_sharp", "cpp", "c",
            "html", "css",
            "javascript", "typescript",
            "markdown", "markdown_inline",
            "json", "yaml",
            "bash", "fish",
            "latex",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
    },
},
-- Markdown preview
{
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npx --yes yarn install",
    ft = { "markdown" },
    config = function()
        vim.g.mkdp_auto_close = 1
        vim.g.mkdp_browser = "firefox"
        vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>", { desc = "Markdown preview" })
        vim.keymap.set("n", "<leader>ms", ":MarkdownPreviewStop<CR>", { desc = "Zatrzymaj preview" })
    end,
},
-- Mason — manager serwerów LSP
{
    "williamboman/mason.nvim",
    config = function()
        require("mason").setup({
            ui = { border = "rounded" }
        })
    end,
},

-- Mason + lspconfig integracja
{
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "pyright",       -- Python
                "clangd",        -- C/C++
                "ts_ls",         -- JavaScript/TypeScript
                "html",          -- HTML
                "cssls",         -- CSS
                "lua_ls",        -- Lua (nvim config)
                "omnisharp",
                "texlab"
            },
            automatic_installation = true,
        })
    end,
},
-- LSP konfiguracja
{
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
        -- Nowe API nvim 0.11
        vim.lsp.config("*", {
            capabilities = vim.lsp.protocol.make_client_capabilities(),
        })

        vim.lsp.enable({ "pyright", "clangd", "ts_ls", "html", "cssls", "lua_ls", "omnisharp", "texlab" })

        -- Skróty LSP
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local map = vim.keymap.set
                local opts = { buffer = args.buf }
                map("n", "gd", vim.lsp.buf.definition, opts)
                map("n", "gr", vim.lsp.buf.references, opts)
                map("n", "K", vim.lsp.buf.hover, opts)
                map("n", "<leader>rn", vim.lsp.buf.rename, opts)
                map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                map("n", "<leader>d", vim.diagnostic.open_float, opts)
            end,
        })
    end,
},
-- Autouzupełnianie
{
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",    -- źródło: LSP
        "hrsh7th/cmp-buffer",       -- źródło: tekst z bufora
        "hrsh7th/cmp-path",         -- źródło: ścieżki plików
        "L3MON4D3/LuaSnip",         -- snippety
        "saadparwaiz1/cmp_luasnip", -- źródło: snippety
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<C-e>"] = cmp.mapping.abort(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
                { name = "path" },
            }),
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
        })
    end,
},
-- Zmiany git w edytorze
{
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
            },
        })
        local map = vim.keymap.set
        map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Podgląd zmiany" })
        map("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "Git blame" })
        map("n", "]h", ":Gitsigns next_hunk<CR>", { desc = "Następna zmiana" })
        map("n", "[h", ":Gitsigns prev_hunk<CR>", { desc = "Poprzednia zmiana" })
    end,
},

-- Podpowiedzi skrótów
{
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        require("which-key").setup({
            delay = 500,
        })
    end,
},

-- Automatyczne zamykanie nawiasów
{
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup({})
        -- Integracja z cmp
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
},
-- LaTeX
{
    "lervag/vimtex",
    ft = { "tex" },
    config = function()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_compiler_method = "latexmk"
    end,
},
}, {
    ui = {
        border = "rounded",
    },
    rocks = {
        enabled = false,  -- wyłącz luarocks
    },
})
