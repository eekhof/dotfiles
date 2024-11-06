require("folder-rules"):setup()
require("zoxide"):setup {
	update_db = true,
}

-- Display the file size and modification time in the file line, see https://yazi-rs.github.io/docs/configuration/yazi/#manager.linemode
function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.modified or 0)
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
