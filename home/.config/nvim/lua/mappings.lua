vim.keymap.set("", " ", "<Nop>")
vim.g.mapleader = " "

function nmap(lhs, rhs)
	vim.keymap.set("n", lhs, rhs)
end

function imap(lhs, rhs)
	vim.keymap.set("i", lhs, rhs)
end

function vmap(lhs, rhs)
	vim.keymap.set("v", lhs, rhs)
end

-- Normal mode
nmap("<Esc>", "<Esc><cmd>silent! noh<CR>")

nmap("n", "nzzzv")
nmap("N", "Nzzzv")
nmap("J", "mzJ`z")

nmap("<C-u>", "<C-u>zz")
nmap("<C-d>", "<C-d>zz")

nmap("j", "gj")
nmap("k", "gk")
nmap("0", "g0")
nmap("$", "g$")

nmap("Q", "<Nop>")
nmap("q:", "<Nop>")
nmap("<F1>", "<Nop>")

nmap("<A-j>", "<cmd>m .+1<CR>==")
nmap("<A-k>", "<cmd>m .-2<CR>==")

nmap("<C-h>", "<C-w><C-h>")
nmap("<C-j>", "<C-w><C-j>")
nmap("<C-k>", "<C-w><C-k>")
nmap("<C-l>", "<C-w><C-l>")
nmap("<leader>x", "<cmd>bd<CR>")
nmap("<Tab>", "<cmd>bn<CR>")
nmap("<S-Tab>", "<cmd>bp<CR>")

-- Plugins
nmap("<leader>ff", "<cmd>Telescope find_files<CR>")
nmap("<leader>fw", "<cmd>Telescope live_grep<CR>")
nmap("<leader>fo", "<cmd>Telescope oldfiles<CR>")
nmap("<leader>b", "<cmd>Telescope buffers<CR>")
nmap("<leader>gc", "<cmd>Telescope git_commits<CR>")
nmap("<leader>gs", "<cmd>Telescope git_status<CR>")

nmap("<leader>S", "<cmd>Lspsaga lsp_finder<CR>")
nmap("<leader>s", "<cmd>Lspsaga outline<CR>")
nmap("<leader>a", "<cmd>Lspsaga code_action<CR>")
nmap("gd", "<cmd>Lspsaga goto_definition<CR>")
nmap("gt", "<cmd>Lspsaga goto_type_definition<CR>")
nmap("<leader>d", "<cmd>Lspsaga show_buf_diagnostics<CR>")
nmap("gr", "<cmd>Lspsaga rename ++project<CR>")
nmap("[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
nmap("]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
nmap("K", "<cmd>Lspsaga hover_doc ++quiet<CR>")

nmap("<C-space>", "<cmd>TroubleToggle<CR>")

nmap("<leader>L", "<cmd>Lazy<CR>")

-- Insert mode

-- Visual mode
vmap("<", "<gv")
vmap(">", ">gv")
