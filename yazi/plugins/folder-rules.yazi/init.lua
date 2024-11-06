-- This custom plugin defines folder specific rules
-- For the disabling of the preloader and previewer in **/mnt/** directory see [[plugin.prepend_preloaders]] and [[plugin.prepend_previewers]] entries in yazi.toml
local function setup()
    ps.sub("cd", function()
	-- Sort Downloads folder chronologically instead of alphabetically:
        if cwd:ends_with("Downloads") then
            ya.manager_emit("sort", { "modified", reverse = true, dir_first = false })
        end
    end)
end

return { setup = setup }
