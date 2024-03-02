vim.keymap.set("n", "<C-s>", ":w<CR>", {})
vim.keymap.set("n", "<C-o>", ":only<CR>", {})
vim.keymap.set("n", "<tab>", "<C-w>w", {})

lvim.keys.normal_mode["<C-v>"] = ":vsplit<CR>"
lvim.keys.normal_mode["<C-e>"] = ":Oil --float<CR>"
