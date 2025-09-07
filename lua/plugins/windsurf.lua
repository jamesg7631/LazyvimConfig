return {
  "Exafunction/windsurf.vim",
  event = "BufEnter",
  init = function()
    -- This variable disables the automatic triggering of suggestions
    -- They will only appear when you manually ask for them
    vim.g.codeium_manual = true

    -- This variable disables the default keybindings, which is a good practice
    -- when you're setting your own
    vim.g.codeium_disable_bindings = 1
  end,
  config = function()
    -- Manually define a keymap to trigger the suggestion
    -- You can change '<C-Space>' to any key combination you prefer
    vim.keymap.set("i", "<C-Space>", function()
      return vim.fn["codeium#Complete"]()
    end, { expr = true, silent = true, noremap = true })

    -- You may also want a keymap to accept the suggestion
    vim.keymap.set("i", "<M-l>", function()
      return vim.fn["codeium#Accept"]()
    end, { expr = true, silent = true, noremap = true })
  end,
}
