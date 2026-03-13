return {
  -- 1. Instalamos el motor nativo de Pywal para Lua
  {
    "AlphaTechnolog/pywal.nvim",
    name = "pywal",
    lazy = false,
    priority = 1000,
  },

  -- 2. Configuramos LazyVim para que lo use como tema principal
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "pywal",
    },
  },
}
