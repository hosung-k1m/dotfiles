return {
  {
    -- The plugin repository
    "mbbill/undotree",
    -- Configuration function
    config = function()
      -- Set the window layout (Optional: Layout 2 is a popular choice)
      vim.cmd [[ let g:undotree_WindowLayout = 2 ]]

      -- Enable persistent undo (Highly recommended to keep undo history across sessions)
      if vim.fn.has("persistent_undo") then
        local undo_path = vim.fn.expand("~/.local/share/nvim/undodir")
        -- Create the directory if it doesn't exist
        if not vim.fn.isdirectory(undo_path) then
          vim.fn.mkdir(undo_path, "p", 0700)
        end
        vim.opt.undodir = undo_path
        vim.opt.undofile = true
      end
    end,
    -- Recommended: Set up a keymap to easily toggle Undotree
    keys = {
      {
        "<leader>u", -- You can choose any keymap you prefer
        "<cmd>UndotreeToggle<CR>",
        desc = "Toggle Undotree",
      },
    },
  },
}