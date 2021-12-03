-- IMPORTANT NOTE : This is the user config, can be edited. Will be preserved if updated with internal updater
-- This file is for NvChad options & tools, custom settings are split between here and 'lua/custom/init.lua'

local M = {}
M.options, M.ui, M.mappings, M.plugins = {}, {}, {}, {}

-- NOTE: To use this, make a copy with `cp example_chadrc.lua chadrc.lua`

--------------------------------------------------------------------

-- To use this file, copy the structure of `core/default_config.lua`,
-- examples of setting relative number & changing theme:

M.options = {
    relativenumber = true,
    shiftwidth = 4,
    tabstop = 4,
}

M.ui = {
    italic_comments = true,
}

M.mappings = {
    copy_whole_file = "<A-a>", -- copy all contents of the current buffer
}

-- NvChad included plugin options & overrides
M.plugins = {
    options = {
        lspconfig = {
            setup_lspconf = "custom.lspconfig",
        },
        nvimtree = {
            enable_git = 1,
        },
    },
    status = {
        telescope_media = true, -- media previews within telescope finders
        dashboard = true, -- NeoVim 'home screen' on open
        colorizer = true, -- color RGB, HEX, CSS, NAME color codes
    },
    -- To change the Packer `config` of a plugin that comes with NvChad,
    -- add a table entry below matching the plugin github name
    --              '-' -> '_', remove any '.lua', '.nvim' extensions
    -- this string will be called in a `require`
    --              use "(custom.configs).my_func()" to call a function
    --              use "custom.blankline" to call a file
    default_plugin_config_replace = {},
}

return M
