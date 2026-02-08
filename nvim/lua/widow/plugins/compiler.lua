return {
  {
    "stevearc/overseer.nvim",
    opts = {},
    config = function(_, opts)
      local overseer = require("overseer")
      overseer.setup(opts)

      local km = vim.keymap.set

      -- =========================
      -- Build only
      -- =========================
      km("n", "<leader>cb", function()
        local file = vim.fn.expand("%")
        local out = vim.fn.expand("%:r")

        local task = overseer.new_task({
          cmd = { "g++" },
          args = { "-std=c++20", "-Wall", file, "-o", out },
          components = { "default", "on_output_quickfix" },
        })

        task:start()
      end, { desc = "Compile C++ with Overseer" })

      -- =========================
      -- Run only
      -- =========================
      km("n", "<leader>rr", function()
        local out = vim.fn.expand("%:r")
        vim.cmd("split | terminal ./" .. out)
      end, { desc = "Run compiled C++ program" })

      -- =========================
      -- Build + Run (single keybind)
      -- =========================
      km("n", "<leader>br", function()
        local file = vim.fn.expand("%")
        local out = vim.fn.expand("%:r")

        -- Define the task with the on_complete callback inline
        local task = overseer.new_task({
          cmd = { "g++" },
          args = { "-std=c++20", "-Wall", file, "-o", out },
          components = { "default", "on_output_quickfix" },
          on_complete = function(t)
            if t.status == "SUCCESS" then
              vim.schedule(function()
                vim.cmd("split | terminal ./" .. out)
              end)
            end
          end,
        })

        task:start()
      end, { desc = "Build & Run C++" })

      -- =========================
      -- Optional keybinds
      -- =========================
      km("n", "<leader>rl", "<cmd>OverseerRestartLast<CR>", { desc = "Restart last overseer task" })
      km("n", "<leader>ot", "<cmd>OverseerToggle<CR>", { desc = "Toggle overseer task list" })
      km("n", "<leader>os", "<cmd>OverseerStopAll<CR>", { desc = "Stop all overseer tasks" })
      km("t", "<Esc>", [[<C-\><C-n>]])
    end,
  },
}
