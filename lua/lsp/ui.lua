local status, lspkind = pcall(require, "lspkind")
if not status then
    vim.notify("not found lskind")
    return
end

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = true,
})

local signs = { Error = "☠︎", Warn = "➤", Hint = "♿︎", Info = "⌚︎" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

lspkind.init({
    -- DEPRECATED (use mode instead): enables text annotations
    --
    -- default: true
    -- with_text = true,

    -- defines how annotations are shown
    -- default: symbol
    -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
    mode = "symbol_text",
    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = "codicons",
    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
        Text = " ",
        Method = "☯︎",
        Function = "⛲︎",
        Constructor = "",
        Field = "->",
        Variable = "",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Property = "ﰠ",
        Unit = "⎐",
        Value = "⚗︎",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "♑︎",
        File = "⛵︎",
        Reference = "⛲︎",
        Folder = "☄︎",
        EnumMember = "",
        Constant = "♃",
        Struct = "פּ",
        Event = "",
        Operator = "⚮",
        TypeParameter = "",
    },
})

local M = {}

-- cmp formatting
M.cmpFormatting = {
    format = lspkind.cmp_format({
        mode = "symbol_text",
        --mode = 'symbol', -- show only symbol annotations

        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        -- The function below will be called before any actual modifications from lspkind
        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
        before = function(entry, vim_item)
            -- Source 显示提示来源
            vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
            return vim_item
        end,
    }),
}

return M
