return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    -- By removing the "branch" line, it will default to the main branch,
    -- which is what you want.
    dependencies = {
      { "github/copilot.vim", enabled = false },
    },
    config = function()
      require("CopilotChat").setup({
        window = {
          layout = "float",
        },
      })
    end,
  },
}
