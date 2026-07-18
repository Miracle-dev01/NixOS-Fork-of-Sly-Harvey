_G.OverseerRunConfig = {
  python = function(file)
    return {
      name = "Run Current Buffer",
      cmd = { "python3", "-u", file },
    }
  end,

  cpp = function(file)
    local out = vim.fn.expand("%:p:r")
    return {
      name = "Run Current Buffer",
      cmd = {
        "bash",
        "-lc",
        "g++ " .. file .. " -o " .. out .. " && " .. out,
      },
    }
  end,

  c = function(file)
    local out = vim.fn.expand("%:p:r")
    return {
      name = "Run Current Buffer",
      cmd = {
        "bash",
        "-lc",
        "gcc " .. file .. " -o " .. out .. " && " .. out,
      },
    }
  end,

  cs = function(file)
    return {
      name = "Run Current Buffer",
      cmd = { "dotnet", "run" },
      cwd = vim.fn.expand("%:p:h"),
    }
  end,
}
