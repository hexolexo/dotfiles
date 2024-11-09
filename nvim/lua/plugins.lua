return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*", 
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            cmp.setup({
                mapping = {
                    ["<Enter>"] = function(fallback)
                        -- Don't block <CR> if signature help is active
                        -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help/issues/13
                        if not cmp.visible() or not cmp.get_selected_entry() or cmp.get_selected_entry().source.name == 'nvim_lsp_signature_help' then
                            fallback()
                        else
                            cmp.confirm({
                                behavior = cmp.ConfirmBehavior.Replace,
                                select = false,
                            })
                        end
                    end,

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }
            })
        end
    },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { 'nvim-telescope/telescope.nvim', tag = '0.1.8' },
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-treesitter/nvim-treesitter' },
    { 'nvim-treesitter/playground' },
    { 'ThePrimeagen/harpoon' },
    { 'mbbill/undotree' },
    { 'tpope/vim-fugitive' },
    { 'VonHeikemen/lsp-zero.nvim', branch = 'v4.x' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    {
        "arsham/arshlib.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
        }
    },
    {
      "arsham/listish.nvim",
      dependencies = {
        "arsham/arshlib.nvim",
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      config = true,
      -- or to provide configuration
      -- config = { theme_list = false, ..}
    },
    { "nanotee/sqls.nvim" },
    { "neovim/nvim-lspconfig" },
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        opts = {
            workspaces = {
                {
                    name = "School",
                    path = "~/Documents/School",
                },
                {
                    name = "DND",
                    path = "~/Documents/DND",
                },
            },
            notes_subdir = "notes",
            completion = {
                -- Set to false to disable completion.
                nvim_cmp = true,
                -- Trigger completion at 2 chars.
                min_chars = 2,
            },
            note_id_func = function(title)
                return title 
            end,

        },
    },
    {
        "arsham/arshamiser.nvim",
        dependencies = {
            "arsham/arshlib.nvim",
            "famiu/feline.nvim",
            "rebelot/heirline.nvim",
            "kyazdani42/nvim-web-devicons",
            "lewis6991/gitsigns.nvim",
        },
        config = function()
            -- ignore any parts you don't want to use
            vim.cmd.colorscheme("catppuccin")
            require("arshamiser.feliniser")
            -- or:
            -- require("arshamiser.heirliniser")

            _G.custom_foldtext = require("arshamiser.folding").foldtext
            vim.opt.foldtext = "v:lua.custom_foldtext()"
            -- if you want to draw a tabline:
            -- vim.api.nvim_set_option("tabline", [[%{%v:lua.require("arshamiser.tabline").draw()%}]])
        end,
    }
}
