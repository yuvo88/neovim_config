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

vim.keymap.set({ "n", "t" }, "<M-t>", open_numbered_terminal, { desc = "Open numbered terminal" })
vim.keymap.set({ "n", "t" }, "<M-w>", close_numbered_terminal, { desc = "Open numbered terminal" })
for i = 1, 9 do
	vim.keymap.set({ "n", "t" }, "<M-" .. i .. ">", function()
		vim.cmd("b " .. terminal[i])
	end)
end
