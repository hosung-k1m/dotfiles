return {
  "stevearc/oil.nvim",
  -- Recommended dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },

  -- The `keys` table is where you define keymaps for the plugin.
  keys = {
    -- Keymap to open Oil in the current directory (or its parent directory).
    -- You can choose any keymap you prefer. Common choices are '-' or '<leader>o'.
    { "-", "<cmd>Oil<cr>", mode = "n", desc = "Open parent directory in Oil" },

    -- Optional: A keymap to open Oil in a floating window.
    {
      "<leader>o",
      function()
        require("oil").open_float()
      end,
      desc = "Open Oil floating window",
    },
  },

  -- The `opts` table is for passing configuration options to `require("oil").setup()`
  opts = {
    -- Set to true if you want Oil to replace the built-in file explorer (`netrw`)
    -- when you open a directory (e.g., `nvim .` or `:e src/`).
    default_file_explorer = true,

    -- Other options you might like:
    view_options = {
      show_hidden = true, -- Show hidden files by default
    },
    -- Add any other configuration options from the Oil documentation here.
  },
}
