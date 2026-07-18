local M = {}

local term_win = nil
local term_buf = nil

-- Helper to automatically discover local virtual environments
local function get_python_exe()
  local venv_paths = { ".venv/bin/python", "venv/bin/python", "env/bin/python" }
  for _, path in ipairs(venv_paths) do
    if vim.fn.executable(path) == 1 then
      return path
    end
  end
  return "python" -- Fallback to system python if no venv exists
end

function M.run_python()
  local file = vim.fn.expand("%:p")

  -- save only normal file buffers
  if vim.bo.buftype == "" then
    vim.cmd("write")
  end

  -- create terminal if needed
  if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
    vim.cmd("botright vsplit | vertical resize 80")
    vim.cmd("term")

    term_buf = vim.api.nvim_get_current_buf()
    term_win = vim.api.nvim_get_current_win()
  end

  -- reopen split if closed
  if not vim.api.nvim_win_is_valid(term_win) then
    vim.cmd("botright vsplit | vertical resize 80")
    vim.api.nvim_set_current_buf(term_buf)

    term_win = vim.api.nvim_get_current_win()
  end

  -- send command
  local job = vim.b[term_buf].terminal_job_id
  local python_exe = get_python_exe() -- Look up the active engine path

  vim.fn.chansend(job, "clear\n")
  vim.fn.chansend(job, python_exe .. " " .. file .. "\n")
end

return M