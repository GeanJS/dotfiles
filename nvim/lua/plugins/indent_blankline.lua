return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    indent = {
      char = "│",         -- caractere da linha de indentação
      tab_char = "│",
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
    },
    exclude = {
      filetypes = {
        "help", "dashboard", "lazy", "nvimtree", "Trouble", "mason",
      },
      buftypes = { "terminal", "nofile" },
    },
  }
}
