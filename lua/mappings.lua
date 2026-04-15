require "nvchad.mappings"

local map = vim.keymap.set

-- Compile and Run C++ file
map("n", "<leader>rr", "<cmd> !g++ -O3 -Wall -Wextra -Werror % -o %:r && ./%:r <CR>", { desc = "Compile and Run C++" })
-- Debugging (DAP)
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <cr>", { desc = "DAP Toggle Breakpoint" })
map("n", "<leader>dr", function()
  local file = vim.fn.expand "%" -- e.g., main.cpp
  local output = vim.fn.expand "%:r" -- e.g., main
  -- 1. Compile with -g (debug symbols) and no optimizations
  print("Compiling " .. file .. " with debug symbols...")
  local cmd = string.format("g++ -g %s -o %s", file, output)
  local success = os.execute(cmd)

  if success == 0 then
    -- 2. If compilation succeeds, launch DAP
    require("dap").continue()
  else
    print "Compilation failed!"
  end
end, { desc = "DAP Compile and Debug" })
map("n", "<leader>di", "<cmd> DapStepInto <cr>", { desc = "DAP Step Into" })
map("n", "<leader>do", "<cmd> DapStepOver <cr>", { desc = "DAP Step Over" })
map("n", "<leader>dO", "<cmd> DapStepOut <cr>", { desc = "DAP Step Out" })
map("n", "<leader>dt", "<cmd> DapTerminate <cr>", { desc = "DAP Terminate" })

-- Toggle Debug UI
map("n", "<leader>du", function()
  require("dapui").toggle()
end, { desc = "DAP Toggle UI" })

-- Floating Scopes (Quickly check variables under cursor)
map("n", "<leader>df", function()
  local widgets = require "dap.ui.widgets"
  widgets.centered_float(widgets.scopes)
end, { desc = "DAP View Scopes" })
