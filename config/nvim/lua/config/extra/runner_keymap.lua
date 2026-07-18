local ns = vim.api.nvim_create_namespace("python_run")

vim.keymap.set("n", "<leader>r", function()
  local file = vim.fn.expand("%:p")
  local buf = vim.api.nvim_get_current_buf()

  vim.cmd("w")

  -- 0. VENV CHECK: Identify the proper target binary path
  local venv_paths = { ".venv/bin/python", "venv/bin/python", "env/bin/python" }
  local python_exe = "python" -- Default fallback

  for _, path in ipairs(venv_paths) do
    if vim.fn.executable(path) == 1 then
      python_exe = path
      break
    end
  end

  -- 1. FIRST: check errors using the localized environment context
  vim.system({ python_exe, file }, { text = true }, function(res)
    vim.schedule(function()
      vim.diagnostic.reset(ns, buf)

      local stderr = res.stderr or ""


      --  ERROR → only diagnostics, NO kitty

      if stderr ~= "" then
        local line_no = nil
        local error_msg = ""

        for line in stderr:gmatch("[^\r\n]+") do
          local lnum = line:match('File ".*", line (%d+)')

          if lnum then
            line_no = tonumber(lnum) - 1
          end

          if line:match("%w+Error:") then
            error_msg = line
          end
        end

        if line_no then
          local code = vim.api.nvim_buf_get_lines(buf, line_no, line_no + 1, false)[1] or ""

          vim.diagnostic.set(ns, buf, {
            {
              bufnr = buf,
              lnum = line_no,
              col = 0,
              end_col = #code,
              message = error_msg .. "\n→ " .. code,
              severity = vim.diagnostic.severity.ERROR,
            }
          }, {
            underline = true,
            virtual_text = true,
            signs = true,
          })
        end

        return
      end

      -------------------------------------------------
      -- ✅ NO ERROR → Run clean inside Kitty window using venv
      -------------------------------------------------
      vim.fn.jobstart({
        "kitty",
        "fish",
        "-c",
        python_exe .. " " .. vim.fn.shellescape(file) ..
          "; echo; read -n 1 -s -P 'Press any key to close...'"
      })
    end)
  end)
end)