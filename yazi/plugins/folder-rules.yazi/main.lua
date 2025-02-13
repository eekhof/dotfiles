-- This custom plugin defines folder specific rules
-- For the disabling of the preloader and previewer in **/mnt/** directory see [[plugin.prepend_preloaders]] and [[plugin.prepend_previewers]] entries in yazi.toml
-- TODO: Add overwrite for delete inside sshfs-mounted folders. Deletion does not work there, and it is likely that this is because the trashing function that is normally bound to the delete key does not work with servers - perhaps remap it to manual mv command to serverside .trash folder
local function setup()
    ps.sub("cd", function()
	-- Sort Downloads folder chronologically instead of alphabetically:
	local cwd = cx.active.current.cwd
	if cwd:ends_with("Downloads") then
		ya.manager_emit("sort", { "mtime", reverse = true, dir_first = false })
	else
		ya.manager_emit("sort", { "natural", reverse = false, dir_first = true })
	end
    end)
end

return { setup = setup }
