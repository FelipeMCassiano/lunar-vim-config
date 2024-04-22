-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
--
-- Discord: https://discord.com/invite/Xb9B4Ny
reload("user.options")
reload("user.go")
reload("user.rust")
reload("user.remap")
lvim.builtin.treesitter.auto_install = true
lvim.builtin.treesitter.ensure_installed = {
    "go", "gomod",
}
local formatters = require "lvim.lsp.null-ls.formatters"
-- if current_hour == 6 then
-- lvim.colorscheme = "catppuccin-latte"

-- elseif current_hour == 18  then lvim.colorscheme = "darcula"
-- end

local hour = tonumber(os.date('%H'))



lvim.builtin.project.detection_methods = { " " }

if hour >= 6 and hour < 18 then
    -- If it's between 6 AM and 6 PM, use a light colorscheme
    --
    lvim.colorscheme = "rose-pine-dawn"
    vim.cmd("set background=light")
    vim.opt.cursorline = false
else
    -- Otherwise, use a dark colorscheme


    lvim.colorscheme = "zhxo"
    vim.cmd("set background=dark")
    vim.opt.cursorline = false
end

-- lvim.colorscheme = "zhxo"
-- vim.opt.cursorline = false
-- vim.cmd("set background=dark")




lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.lua", "*.py", "*.go", "*.js", "*.rs", "*.java", "*.rb", "*.ts", "*.exs", "*.cs" }

lvim.builtin.terminal.open_mapping = "<C-t>"

lvim.builtin.alpha.active = true
lvim.builtin.dap.active = true
formatters.setup {
    { name = "black" },
    {
        name = "prettier",
        ---@usage arguments to pass to the formatter
        -- these cannot contain whitespace
        -- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
        args = { "--print-width", "100", "--line-width", "80", "--tab-width", "4" },
        ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
        filetypes = { "typescript", "typescriptreact", "javascript" },
    },
    { command = "goimports", filetypes = { "go" } },
    { command = "gofumpt",   filetypes = { "go" } },
    { command = "rubocop",   filetypes = { "ruby" } },

}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    { name = "flake8" },
    {
        name = "shellcheck",
        args = { "--severity", "warning" },
    },

}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
    {
        name = "proselint",
    },
}
lvim.plugins = {

    { "lunarvim/colorschemes" },
    { "olexsmir/gopher.nvim" },
    { "leoluz/nvim-dap-go" },
    {
        "p00f/nvim-ts-rainbow",
        config = function()
            require('nvim-treesitter.configs').setup {
                rainbow = {
                    enable = true,
                    extended_mode = true,
                    max_file_lines = nil,
                }
            }
        end
    },
    {
        "folke/todo-comments.nvim"
    },
    { 'Mohammed-Taher/AdvancedNewFile.nvim' },
    {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        ft = { 'rust' },
        { 'sxhk0/zhxo.nvim' },
        { "rose-pine/neovim" },
    }
}



vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })



local dap_ok, dapgo = pcall(require, "dap-go")
if not dap_ok then
    return
end

dapgo.setup()
local status_ok, gopher = pcall(require, "gopher")
if not status_ok then
    return
end

gopher.setup {
    commands = {
        go = "go",
        gomodifytags = "gomodifytags",
        gotests = "gotests",
        impl = "impl",
        iferr = "iferr",
    },
}





local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
    "n",
    "<leader>a",
    function()
        vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
        -- or vim.lsp.buf.codeAction() if you don't want grouping.
    end,
    { silent = true, buffer = bufnr }
)
