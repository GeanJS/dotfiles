return {
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("colorizer").setup({
        filetypes = { "*" }, -- aplica para todos os tipos de arquivo
        user_default_options = {
          RGB = true, -- #RGB
          RRGGBB = true, -- #RRGGBB
          names = true, -- nomes de cores CSS
          RRGGBBAA = true, -- #RRGGBBAA
          rgb_fn = true, -- rgb() e rgba()
          hsl_fn = true, -- hsl() e hsla()
          css = true, -- css features
          css_fn = true, -- suporte para funções css
        },
      })
    end,
  },
}

