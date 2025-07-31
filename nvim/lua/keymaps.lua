-- lua/keymaps.lua

-- Define o líder como <space>
vim.g.mapleader = ' '

-- Terminal: <Esc> para sair do modo terminal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Navegação entre janelas com Alt + hjkl
vim.keymap.set({ 'n', 'i', 't' }, '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set({ 'n', 'i', 't' }, '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set({ 'n', 'i', 't' }, '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set({ 'n', 'i', 't' }, '<A-l>', '<C-\\><C-n><C-w>l')

-- Desativa as setas (modo normal, inserção e visual)
local no_setas = { 'n', 'i', 'v' }
for _, modo in ipairs(no_setas) do
  vim.keymap.set(modo, '<Up>', '<Nop>')
  vim.keymap.set(modo, '<Down>', '<Nop>')
  vim.keymap.set(modo, '<Left>', '<Nop>')
  vim.keymap.set(modo, '<Right>', '<Nop>')
end

-- 📁 Nvim-tree
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = "Alternar NvimTree" })

-- 💬 Comment.nvim
vim.keymap.set('n', '<leader>/', function() require('Comment.api').toggle.linewise.current() end, { desc = "Comentar linha" })
vim.keymap.set('v', '<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Comentar seleção" })

-- 🧭 BufferLine (abas)
vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", { desc = "Próximo buffer" })
vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", { desc = "Buffer anterior" })
vim.keymap.set("n", "<leader>bc", ":BufferLinePickClose<CR>", { desc = "Fechar buffer com letra" })
vim.keymap.set("n", "<leader>bp", ":BufferLinePick<CR>", { desc = "Selecionar buffer com letra" })

for i = 1, 9 do
  vim.keymap.set("n", "<leader>" .. i, "<Cmd>BufferLineGoToBuffer " .. i .. "<CR>", { desc = "Ir para buffer " .. i })
end

-- 📄 Fechar buffer atual
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Fechar buffer atual" })

