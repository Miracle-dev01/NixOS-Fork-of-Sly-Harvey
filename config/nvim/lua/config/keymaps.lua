local keymap = vim.keymap.set

-- File explorer(global)
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })

-- Telescope (global fuzzy search)
keymap("n", "<leader>ff", ":Telescope find_files<CR>", { silent = true })
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", { silent = true })
keymap("n", "<leader>fb", ":Telescope buffers<CR>", { silent = true })
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", { silent = true })

--Next/previous buffer
keymap("n", "<s-l>", ":BufferLineCycleNext<CR>", { silent = true })

keymap("n", "<s-h>", ":BufferLineCyclePrev<CR>", { silent = true })

-- Close buffer

keymap("n", "<leader>x", ":bdelete<CR>", { silent = true })


vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- require("config.runner_keymap")

require("config.overseer_kymap")

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})
