-- This is where your custom modules and plugins go.
-- See the wiki for a guide on how to extend NvChad

local hooks = require "core.hooks"

-- NOTE: To use this, make a copy with `cp example_init.lua init.lua`

--------------------------------------------------------------------

-- To modify packaged plugin configs, use the overrides functionality
-- if the override does not exist in the plugin config, make or request a PR,
-- or you can override the whole plugin config with 'chadrc' -> M.plugins.default_plugin_config_replace{}
-- this will run your config instead of the NvChad config for the given plugin

-- hooks.override("lsp", "publish_diagnostics", function(current)
--   current.virtual_text = false;
--   return current;
-- end)

-- To add new mappings, use the "setup_mappings" hook,
-- you can set one or many mappings
-- example below:

vim.opt.shell = "/usr/bin/fish"
vim.opt.scrolloff = 4

hooks.add("setup_mappings", function(map)
    map("n", "n", "nzzzv", opt)
    map("n", "N", "Nzzzv", opt)
    map("n", "J", "mzJ`z", opt)

    map("n", "<A-s>", ":update<CR>", opt)
    map("n", "<A-d>", ":wqa<CR>", opt)

    map("n", "<F1>", "<nop>", opt)
    map("i", "<F1>", "<nop>", opt)
    map("v", "<F1>", "<nop>", opt)
    map("n", "Y", "y$", opt)
    map("v", "<", "<gv", opt)
    map("v", ">", ">gv", opt)
    map("n", "<C-space>", ":TroubleToggle<CR>", opt)
    map("n", "<leader>c", "*``cgn", opt)
    map("n", "<leader>C", "*``cgN", opt)

    map("n", "<A-j>", ":m .+1<CR>==", opt)
    map("n", "<A-k>", ":m .-2<CR>==", opt)
    map("i", "<A-j>", "<Esc>:m .+1<CR>==a", opt)
    map("i", "<A-k>", "<Esc>:m .-2<CR>==a", opt)
    map("v", "<A-j>", ":m '>+1<CR>gv=gv", opt)
    map("v", "<A-k>", ":m '<-2<CR>gv=gv", opt)

    map("i", ",", ",<C-g>u", opt)
    map("i", ".", ".<C-g>u", opt)
    map("i", "!", "!<C-g>u", opt)
    map("i", "?", "?<C-g>u", opt)
    map("i", ":", ":<C-g>u", opt)
    map("i", "=", "=<C-g>u", opt)

    map("n", "<C-h>", "<C-w><C-h>", opt)
    map("n", "<C-j>", "<C-w><C-j>", opt)
    map("n", "<C-k>", "<C-w><C-k>", opt)
    map("n", "<C-l>", "<C-w><C-l>", opt)

    map("n", "<leader>ps", ":PackerSync<CR>", opt)

    map("n", "Q", "<nop>", opt)
    map("n", "q:", "<nop>", opt)

    map("n", "<C-n>", ":NvimTreeToggle<CR>", opt)
    map("v", "<C-n>", ":NvimTreeToggle<CR>", opt)

    map("n", "<A-h>", "<C-w>2-", opt)
    map("n", "<A-l>", "<C-w>2+", opt)

    map("n", "cs", 'F"cf"', opt)

    map("n", "<leader>fm", ":Neoformat<CR>", opt)
end)

-- To add new plugins, use the "install_plugin" hook,
-- NOTE: we heavily suggest using Packer's lazy loading (with the 'event' field)
-- see: https://github.com/wbthomason/packer.nvim
-- examples below:

hooks.add("install_plugins", function(use)
    use "folke/trouble.nvim"
    use "dstein64/nvim-scrollview"
    use "sbdchd/neoformat"
end)

-- alternatively, put this in a sub-folder like "lua/custom/plugins/mkdir"
-- then source it with

-- require "custom.plugins.mkdir"
require "custom.autocmds"
