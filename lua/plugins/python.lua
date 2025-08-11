return {
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      -- Helper function to find the project root
      local function find_django_project_root()
        local cwd = vim.fn.getcwd()
        while cwd ~= "/" do
          if vim.fn.filereadable(cwd .. "/manage.py") then
            return cwd
          end
          cwd = vim.fn.fnamemodify(cwd, ":h")
        end
        return nil
      end

      -- The fix: use a function to find the python executable
      local function get_python_executable()
        local venv_path = find_django_project_root()
        if venv_path then
          vim.notify("Using Python from: " .. venv_path .. "/.venv/bin/python", vim.log.levels.INFO)
          return venv_path .. "/.venv/bin/python"
        end
        return "python" -- Fallback to global python
      end

      require("dap-python").setup(get_python_executable())
      require("dapui").setup()

      local dap = require("dap")
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Python File",
          program = "${file}",
          justMyCode = true,
        },
        {
          type = "python",
          request = "launch",
          name = "Django Runserver",
          program = function()
            local root = find_django_project_root()
            return root and root .. "/manage.py" or ""
          end,
          args = { "runserver" },
          django = true,
          justMyCode = false,
          cwd = function()
            return find_django_project_root()
          end,
        },
      }
    end,
    keys = {
      { "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "Debug: Toggle Breakpoint" },
      { "<Leader>ds", "<cmd>lua require'dap'.continue()<CR>", desc = "Debug: Start/Continue" },
      { "<Leader>dn", "<cmd>lua require'dap'.step_over()<CR>", desc = "Debug: Step Over" },
      { "<Leader>di", "<cmd>lua require'dap'.step_into()<CR>", desc = "Debug: Step Into" },
      { "<Leader>do", "<cmd>lua require'dap'.step_out()<CR>", desc = "Debug: Step Out" },
      { "<Leader>dv", "<cmd>lua require'dapui'.toggle()<CR>", desc = "Debug: Toggle UI" },
    },
  },
}
