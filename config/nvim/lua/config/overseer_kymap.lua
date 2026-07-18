local overseer = require("overseer")
local ns = vim.api.nvim_create_namespace("overseer_errors")

overseer.setup({ strategy = { "toggleterm", direction = "horizontal", size = 0.25 } })

-- Helper to detect venv
local function get_python_executable()
  local venv_dirs = { ".venv", "venv", ".env" }
  local cwd = vim.fn.getcwd()
  for _, dir in ipairs(venv_dirs) do
    local bin = (vim.loop.os_uname().sysname == "Windows_NT") 
      and (cwd .. "\\" .. dir .. "\\Scripts\\python.exe")
      or (cwd .. "/" .. dir .. "/bin/python")
    if vim.fn.executable(bin) == 1 then return bin end
  end
  return "python"
end

-- Define your run configs using the helper
_G.OverseerRunConfig = {
  python = function(filepath)
    return {
      name = "Run Python File",
      cmd = { get_python_executable(), filepath },
    }
  end,
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "OverseerTerminal",
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }
    vim.keymap.set({ "n", "t" }, "q", "<cmd>close<CR>", opts)
    vim.keymap.set({ "n", "t" }, "<Esc>", "<cmd>close<CR>", opts)
  end,
})

local task_cache = {}

local function open_output(task)
  local buf = task:get_bufnr()
  if buf and vim.api.nvim_buf_is_valid(buf) then
    local win = vim.fn.bufwinid(buf)
    if win ~= -1 then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
  task:open_output("horizontal")
  vim.schedule(function()
    vim.cmd("wincmd J")
    vim.cmd("resize 15")
  end)
end

local function run_or_restart()
  local bufnr = vim.api.nvim_get_current_buf()
  local ft = vim.bo.filetype
  local builder = (_G.OverseerRunConfig or {})[ft]

  if not builder then return vim.notify("No runner for: " .. ft, vim.log.levels.WARN) end
  vim.diagnostic.reset(ns, bufnr)

  if task_cache[bufnr] then
    task_cache[bufnr]:restart()
    return open_output(task_cache[bufnr])
  end

  local efm = (vim.bo.errorformat == "" and "%f:%l:%c:%m,%f:%l:%m") or vim.bo.errorformat
  local spec = builder(vim.fn.expand("%:p"))
  spec.components = { "default", { "on_output_quickfix", open = false, errorformat = efm } }

  local ok, task = pcall(overseer.new_task, spec)
  if not ok then return vim.notify("Failed to create task", vim.log.levels.ERROR) end

  task:subscribe("on_complete", function(t, status)
    vim.schedule(function()
      local t_buf = t:get_bufnr()
      local win = vim.fn.bufwinid(t_buf)
      if win ~= -1 then
        vim.api.nvim_set_current_win(win)
        vim.cmd("stopinsert")
      end
    end)
    
    if status == "FAILURE" then
      vim.defer_fn(function()
        local diags = {}
        for _, item in ipairs(vim.fn.getqflist()) do
          if item.bufnr > 0 and item.lnum > 0 then
            diags[item.bufnr] = diags[item.bufnr] or {}
            table.insert(diags[item.bufnr], { lnum = item.lnum - 1, col = item.col - 1, severity = vim.diagnostic.severity.ERROR, message = item.text })
          end
        end
        for bnr, d in pairs(diags) do vim.diagnostic.set(ns, bnr, d) end
      end, 120)
    end
  end)

  task_cache[bufnr] = task
  task:start()
  open_output(task)
end

vim.keymap.set("n", "<leader>r", run_or_restart, { desc = "Run / Restart buffer" })