return {
  {
    "sainnhe/gruvbox-material",
    lazy = false, -- carrega imediatamente
    priority = 1000, -- garante que o tema é carregado antes de outros plugins
    config = function()
      -- Opções de estilo
      vim.g.gruvbox_material_background = "medium" -- opções: 'soft', 'medium', 'hard'
      vim.g.gruvbox_material_foreground = "material" -- opções: 'material', 'mix', 'original'
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_better_performance = true

      -- Tema escuro
      vim.o.background = "dark"
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
}

