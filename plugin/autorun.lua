local builtin = require("autorun.builtin")

local function getCompletion(t)
	return function()
		local keys = {}
		for key, _ in pairs(t) do
			table.insert(keys, key)
		end
		return keys
	end
end

vim.api.nvim_create_user_command("AutoRun", function(opts)
	local subcommand = opts.fargs[1]
	if builtin[subcommand] then
		builtin[subcommand]()
	else
		print("Invalid subcommand")
	end
end, {
	nargs = 1,
	complete = getCompletion(builtin),
})
