return {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      hint = {
        enable = true
      },
      format = {
        enable = true
      },
      workspace = {
        library = vim.list_extend(vim.api.nvim_get_runtime_file("lua", true), {
          "${3rd}/luv/library",
          -- "${3rd}/busted/library",
          -- "${3rd}/luassert/library",
        }),
        checkThirdParty = "Disable",
      },
      diagnostics = {
        globals = { 'vim' }
      },
    },
  },
}
