local M = {}

M.setup_lsp = function(attach, capabilities)
    local lspconfig = require "lspconfig"

    lspconfig.html.setup {
        on_attach = attach,
        capabilities = capabilities,
    }

    lspconfig.pyright.setup {
        on_attach = attach,
        capabilities = capabilities,
    }

    lspconfig.elixirls.setup {
        cmd = { "/home/toxicfs/.config/lsp/elixir.ls/language_server.sh" },
        on_attach = attach,
        capabilities = capabilities,
    }

    lspconfig.hls.setup {
        on_attach = attach,
        capabilities = capabilities,
    }

    lspconfig.rust_analyzer.setup {
        on_attack = attack,
        capabilities = capabilities,
    }
end

return M
