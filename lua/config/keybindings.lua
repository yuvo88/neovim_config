-- Start a new line in command mode
vim.keymap.set("n", "<leader>o", "o<C-c>")
-- Start a new line in command mode above current line
vim.keymap.set("n", "<leader>O", "O<C-c>")
-- Paste without overriding buffer
vim.keymap.set("v", "<leader>p", '"_dP')
-- Exit terminal mode
vim.keymap.set("t", "<C-q>", [[<C-\><C-n>]], { noremap = true, silent = true })
-- Diff current windows
vim.keymap.set("n", "<leader>df", function()
	vim.cmd("windo diffthis")
end)

-- Remove highlight
vim.keymap.set({ "n", "i", "v" }, "<C-h>", function()
	vim.cmd("noh")
end)
vim.keymap.set({ "n", "i", "v" }, "<C-j>", function()
	vim.cmd("cope")
end)

local terminal = {}

local function open_numbered_terminal()
	vim.cmd("term")
	table.insert(terminal, vim.api.nvim_get_current_buf())
	vim.cmd("startinsert")
end
local function close_numbered_terminal()
	local current_buf = vim.api.nvim_get_current_buf()
	for i, bufid in ipairs(terminal) do
		if bufid == current_buf then
			table.remove(terminal, i)
			break
		end
	end
	vim.cmd("bd!")
end

vim.api.nvim_create_user_command("Nterm", function()
	open_numbered_terminal()
end, { desc = "Open a numbered terminal" })

vim.keymap.set({ "n" }, "<M-t>", open_numbered_terminal, { desc = "Open numbered terminal" })
vim.keymap.set({ "t" }, "<M-t>", open_numbered_terminal, { desc = "Open numbered terminal" })
vim.keymap.set({ "n" }, "<M-w>", close_numbered_terminal, { desc = "Open numbered terminal" })
vim.keymap.set({ "t" }, "<M-w>", close_numbered_terminal, { desc = "Open numbered terminal" })
for i = 1, 9 do
	vim.keymap.set({ "t" }, "<M-" .. i .. ">", function()
		vim.cmd("b " .. terminal[i])
	end)
	vim.keymap.set({ "n" }, "<M-" .. i .. ">", function()
		vim.cmd("b " .. terminal[i])
	end)
end
-- Git blame command
vim.keymap.set("n", "<leader>gb", function()
	vim.cmd("normal! zz")
	local line_number = vim.fn.line(".")
	local filename = vim.fn.expand("%:p")
	local result = vim.fn.systemlist("git blame -- " .. filename .. "| cut -d'(' -f 2 | cut -d ')' -f 1")
	vim.cmd("vnew")
	vim.cmd("vertical resize -45")
	vim.api.nvim_buf_set_lines(0, 0, -1, false, result)
	vim.bo.buftype = "nofile"
	vim.bo.bufhidden = "wipe"
	vim.bo.swapfile = false
	vim.bo.filetype = "gitblame"
	vim.api.nvim_win_set_cursor(0, { line_number, 0 })
	vim.cmd("normal! zz")
end, { desc = "[G]it [B]lame" })
vim.keymap.set("n", "<leader>cr", function()
	vim.cmd(":%s/\r//g")
end, { desc = "[C]lear Carriage [R]eturn" })
