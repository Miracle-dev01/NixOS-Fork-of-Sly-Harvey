local status, ts = pcall(require, "nvim-treesitter")
if not status then
  return
end

-- 1. Setup the plugin (The new rewrite requires no tables or only 'install_dir')
ts.setup({
  -- Optional: only add if you want a custom directory for parsers/queries
  -- install_dir = vim.fn.stdpath("data") .. "/site"
})

-- 2. Explicitly install the parsers you need (runs asynchronously)
ts.install({ "python" })

-- 3. Enable core Treesitter highlighting globally via an autocommand
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" }, -- Add other filetypes here as needed
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    if lang then
      pcall(vim.treesitter.start, args.buf, lang)
    end
  end,
})