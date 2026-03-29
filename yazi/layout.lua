local log = require("log")

return function(ctx)
	local width = ctx.window.width
	log.debug("Window width: " .. width)

	if width < 1000 then
		return { ratio = 0.0 }
	else
		return { ratio = 0.5 }
	end
end
