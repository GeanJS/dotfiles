vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

-- não quero swap nem backup, mas o undodir e undofile me permitem usar "u" mesmo depois de fechar e abrir o neovim
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- vai mostrando os resultados da busca enquanto digite, mas se paro ele não fica destacado
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- qualidade de vida, cores melhores, barra de sinais
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50

-- tecla espaço como tecla principal
vim.g.mapleader = " "

-- split sempre na vertical
vim.api.nvim_create_autocmd("WinNew", {
  pattern = "*",
  callback = function()
    vim.cmd("wincmd L")
  end,
})

-- tira o simbolo do tio das linhas em branco
vim.opt.fillchars = {eob = " "}
