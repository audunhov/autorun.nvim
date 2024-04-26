local M = {}

local append_data = function(bufnr)
	return function(_, data)
		if data then
			vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
		end
	end
end

function M.auto(opts)
	opts = opts or {}
	local bufnr_input = vim.fn.input("Enter bufnr (optional): ")

	local bufnr

	if bufnr_input ~= "" then
		bufnr = tonumber(bufnr_input, 10)
	end

	local pattern = vim.fn.input("Enter pattern: ")
	local command = vim.fn.input("Enter command: ")

	local append_fn
	local jobstart_opts

	if bufnr then
		append_fn = append_data(bufnr)
		jobstart_opts = {
			stdout_buffered = true,
			on_stdout = append_fn,
			on_stderr = append_fn,
		}
	end

	vim.api.nvim_create_autocmd("BufWritePost", {
		group = vim.api.nvim_create_augroup("autorun", { clear = true }),
		pattern = pattern,
		callback = function()
			if bufnr then
				vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {}) -- clear buffer
			end

			if jobstart_opts then
				vim.fn.jobstart(command, jobstart_opts)
			else
				vim.fn.jobstart(command)
			end
		end,
	})

	print("Auto command created")
end

local saved_bufnr_input = ""
local saved_command = ""

function M.saved(opts)
	opts = opts or {}

	if saved_bufnr_input == "" then
		saved_bufnr_input = vim.fn.input("Enter bufnr: ")
	end

	local bufnr

	if saved_bufnr_input == "" then
		bufnr = vim.api.nvim_get_current_buf()
	else
		bufnr = tonumber(saved_bufnr_input, 10)
	end

	local changed = false
	if saved_command == "" then
		saved_command = vim.fn.input("Enter command: ")
		changed = true
	end

	if saved_command == "" then
		print("No command provided")
		return
	else
		if changed then
			print("Saved command")
		end
	end

	local append_fn = append_data(bufnr)

	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {}) -- clear buffer
	vim.fn.jobstart(saved_command, {
		stdout_buffered = true,
		on_stdout = append_fn,
		on_stderr = append_fn,
	})
end

function M.clear_saved()
	saved_bufnr_input = ""
	saved_command = ""
	print("Cleared saved command")
end

return M
