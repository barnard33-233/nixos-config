-- plugins about lsp cmp and snippet

local lsp_bindings = {
    {'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>'},
    {'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>'},
    {'n', 'gh', '<cmd>lua vim.lsp.buf.hover()<cr>'},
    {'n', 'gr', '<cmd>lua vim.lsp.buf.reference()<cr>'},
    {'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>'},
    {'n', 'go', '<cmd>lua vim.lsp.buf.open_float()<cr>'},
    {'n', 'gp', '<cmd>lua vim.lsp.buf.goto_prev()<cr>'},
    {'n', 'gn', '<cmd>lua vim.lsp.buf.goto_next()<cr>'},
}

local keymapping = require('keymapping')

-- setup of language servers
local lspconfig = {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim"
    },
    lazy = false,
    config = function()
        local mason = require('mason')
        local masonlspconfig = require('mason-lspconfig')
        mason.setup()
        masonlspconfig.setup({
            ensure_installed = {
                "lua_ls", "clangd", "pyright",
                -- "rust_analyzer", "tsserver",
                "svlangserver",
            },
        })
        local lspconfig = require('lspconfig')
        lspconfig.clangd.setup({
            cmd = {"clangd", "--background-index", "--all-scopes-completion", "--completion-style=detailed"}
        })
        lspconfig.lua_ls.setup({})
        lspconfig.pyright.setup({})
        lspconfig.rust_analyzer.setup({})
        lspconfig.tsserver.setup({})
        lspconfig.svlangserver.setup({})
        keymapping.bindkeys(lsp_bindings)
    vim.diagnostic.config({
      virtual_text = {
        prefix = "-",  -- 可以用其他符号如 "■", "▎" 等
        spacing = 4,
        severity_limit = "Warning",  -- 只显示 Warning 和 Error
      },
      float = {
        border = "rounded",  -- 浮动窗口的边框样式："single", "double", "rounded", "solid", "shadow"
        source = "always",  -- 总是显示诊断的来源
        header = "",        -- 不显示浮动窗口的标题
        prefix = "",        -- 不显示前缀
      },
      signs = true,  -- 是否显示左侧的符号
      underline = true,  -- 是否为诊断加下划线
      update_in_insert = false,  -- 插入模式下是否更新诊断
      severity_sort = true,  -- 根据严重性排序
    })
    end
}

-- completion
local cmp = {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'onsails/lspkind-nvim',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip',
    },
    config = function()
        local cmp = require('cmp')
        local lspkind = require('lspkind')
        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body)
                end,
            },
            sources = cmp.config.sources({
                {name = 'nvim_lsp'},
                {name = 'buffer'},
                {name = 'path'},
                {name = 'vsnipt'},
            }),
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    with_text = true,
                    maxwidth = 50,
                    ellipsis_char = '...',
                    show_labelDetails = true,
                    before = function (entry, vim_item)
                        vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
                        return vim_item
                    end
                })
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ['<C-j>'] = cmp.mapping.select_next_item(),
                ['<tab>'] = cmp.mapping.confirm({
                    select = true,
                    behavior = cmp.ConfirmBehavior.Replace
                }),
            }),
        })
    end
}


return {lspconfig, cmp}
