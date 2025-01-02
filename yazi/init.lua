require("folder-rules"):setup()
require("zoxide"):setup {
	update_db = true,
}

-- TODO: The restore plugin needs some fixes in the confirmation dialog, and is likely going to be revamped soon, see github for update, load accordingly
require("restore"):setup({
    -- Set the position for confirm and overwrite dialogs.
    -- don't forget to set height: `h = xx`
    -- https://yazi-rs.github.io/docs/plugins/utils/#ya.input
    position = { "center", w = 70, h = 40 },

    -- Show confirm dialog before restore.
    -- NOTE: even if set this to false, overwrite dialog still pop up
    show_confirm = true,

    -- colors for confirm and overwrite dialogs
    theme = {
      title = "blue",
      header = "green",
      -- header color for overwrite dialog
      header_warning = "yellow",
      list_item = { odd = "blue", even = "blue" },
    },
})

-- Display the file size and modification time in the file line, see https://yazi-rs.github.io/docs/configuration/yazi/#manager.linemode
function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = ""
    elseif os.date("%d.%m.%Y", time) == os.date("%d.%m.%Y") then
        time = os.date("           %H:%M", time)
	elseif os.date("%Y", time) == os.date("%Y") then
		time = os.date("     %d.%m %H:%M", time)
	else
		time = os.date("%Y %d.%m %H:%M", time)
	end

	local size = self._file:size()
	return ui.Line(string.format("%s %s", size and ya.readable_size(size) or "-", time))
end

-- Display symlink correctly in statusbar, see https://yazi-rs.github.io/docs/tips/#symlink-in-status
function Status:name()
	local h = self._tab.current.hovered
	if not h then
		return ui.Line {}
	end

	local linked = ""
	if h.link_to ~= nil then
		linked = " 🠚 " .. tostring(h.link_to)
	end
	return ui.Line(" " .. h.name .. linked)
end
