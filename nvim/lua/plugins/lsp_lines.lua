return {
{
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  config = function()
    require("lsp_lines").setup()

    -- Desativa os diagnósticos inline padrão
    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = true,
    })
  end,
}
}
