return {
  -- Add the kanagawa colorscheme plugin
  { "rebelot/kanagawa.nvim" },

  -- Override LazyVim's colorscheme option
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
}
