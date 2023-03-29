local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local line_numbers = augroup("vimrc", { clear = true })
autocmd("InsertEnter", { group = line_numbers, command = "set norelativenumber" })
autocmd("InsertLeave", { group = line_numbers, command = "set relativenumber" })

autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = (vim.fn["hlexists"]("HighlightedyankRegion") > 0 and "HighlightedyankRegion" or "IncSearch"),
			timeout = 100,
		})
	end,
})

local terminal = augroup("vimrc", { clear = true })
autocmd("TermEnter", { group = terminal, command = "setlocal nonumber norelativenumber" })
autocmd("TermLeave", { group = terminal, command = "setlocal number relativenumber" })

autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format()
	end,
})
