return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              staticcheck = true,
              analyses = {
                ST1000 = false, -- disable "package comment" warning
                ST1020 = false, -- disable "function comment" warning
                ST1021 = false, -- disable "type comment" warning
              },
            },
          },
        },
      },
    },
  },
}
