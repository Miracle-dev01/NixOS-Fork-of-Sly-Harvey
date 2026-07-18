
-- Leader keys

vim.g.mapleader = " "
vim.g.maplocalleader = " "



-- Lazy bootstrap
-- Lazy bootstrap path
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
-- add lazy to runtime path
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
--vim.cmd("syntax off")

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  pattern = "*",
  callback = function()
    vim.cmd("silent! write")
    vim.notify("autoSaved", vim.log.levels.INFO)
  end,
})

local autosave_timer = vim.loop.new_timer()

autosave_timer:start(
  120000, -- 2 minutes
  120000, -- repeat every 2 minutes
  vim.schedule_wrap(function()
    vim.cmd("silent! write")
    vim.notify("2 min autosave", vim.log.levels.INFO)
  end)
)






-- load lazy
require("lazy").setup(require("plugins"))

-- core config
require("config.options")


require("config.lsp")
require("config.cmp")

require("config.tree")
require("config.telescope")

require("config.bufferline")

require("config.keymaps")

--  runner system
-- require("config.run")

require("config.overseer_config")


require("config.tokyonight")

require("config.color_scheme")

require("config.status")

require("config.inline_diagno")







-- vim.defer_fn(function()
--   require("config.treesitter")
-- end, 0)




