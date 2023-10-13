local M = {}

M.config = function()
  vim.notify = require("notify")

  vim.notify.setup({
    timeout = 10000,
    top_down = false,
  })

  vim.api.nvim_create_user_command('NotifyDismiss', function() require 'notify'.dismiss({}) end, {})

  -- function Notify_output(command_string, opts)
  --   local command = {}
  --   local i = 1
  --   for s in string.gmatch(command_string, "([^ ]+)") do
  --     command[i] = s
  --     i = i + 1
  --   end
  --   local output = ""
  --   local notification
  --   local notify = function(msg, level)
  --     local notify_opts = vim.tbl_extend(
  --       "keep",
  --       opts or {},
  --       { title = table.concat(command, " "), replace = notification }
  --     )
  --     notification = vim.notify(msg, level, notify_opts)
  --   end
  --   local on_data = function(_, data)
  --     output = output .. table.concat(data, "\n")
  --     notify(output, "info")
  --   end
  --   vim.fn.jobstart(command, {
  --     on_stdout = on_data,
  --     on_stderr = on_data,
  --     on_exit = function(_, code)
  --       if #output == 0 then
  --         notify("No output of command, exit code: " .. code, "warn")
  --       end
  --     end,
  --   })
  -- end
end
return M
