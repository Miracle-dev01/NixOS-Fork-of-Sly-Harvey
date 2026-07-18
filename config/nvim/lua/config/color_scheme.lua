-- Force syntax highlighting groups to match Sublime Text's Monokai palette
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- 1. Sublime Neon Pink (Keywords: def, return, import, if, for, class)
    vim.api.nvim_set_hl(0, "@keyword", { fg = "#F92672", bold = true })
    vim.api.nvim_set_hl(0, "@keyword.conditional", { fg = "#F92672", bold = true })
    vim.api.nvim_set_hl(0, "@keyword.repeat", { fg = "#F92672", bold = true })
    vim.api.nvim_set_hl(0, "@exception", { fg = "#F92672", bold = true })
    vim.api.nvim_set_hl(0, "@include", { fg = "#F92672", bold = true })

    -- 2. Sublime Electric Green (Functions, methods, and declarations)
    vim.api.nvim_set_hl(0, "@function", { fg = "#A6E22E" })
    vim.api.nvim_set_hl(0, "@function.builtin", { fg = "#A6E22E" })
    vim.api.nvim_set_hl(0, "@method", { fg = "#A6E22E" })

    -- 3. Sublime Bright Yellow (Strings)
    vim.api.nvim_set_hl(0, "@string", { fg = "#E6DB74" })

    -- 4. Sublime Neon Orange (Function arguments, parameters, and self)
    vim.api.nvim_set_hl(0, "@variable.parameter", { fg = "#FD971F", italic = true })
    vim.api.nvim_set_hl(0, "@parameter", { fg = "#FD971F", italic = true })
    vim.api.nvim_set_hl(0, "@variable.builtin", { fg = "#FD971F", italic = true }) -- targets 'self'

    -- 5. Sublime Electric Cyan (Types, Classes, and Constants)
    vim.api.nvim_set_hl(0, "@type", { fg = "#66D9EF" })
    vim.api.nvim_set_hl(0, "@constructor", { fg = "#66D9EF" })
    vim.api.nvim_set_hl(0, "@constant", { fg = "#AE81FF" }) -- Numbers/Booleans (Purple)
    
    -- 6. Operators & Punctuation (Crisp off-white/gray)
    vim.api.nvim_set_hl(0, "@operator", { fg = "#F8F8F2" })
    vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = "#F8F8F2" })
  end,
})

-- Reload colorscheme setup to apply the new custom tokens immediately
if vim.g.colors_name then
  vim.cmd("colorscheme " .. vim.g.colors_name)
else
  vim.cmd("colorscheme default")
end