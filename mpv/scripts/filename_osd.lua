mp.register_event("file-loaded", function()
    local filename = mp.get_property("filename")
    -- Display filename in center of screen
    mp.osd_message(filename, 10)  -- 10 = duration in seconds
end)

-- Always display filename
mp.add_periodic_timer(0.5, function()
    local filename = mp.get_property("filename")
    mp.osd_message(filename, 0.6)  -- Refresh every 0.5s
end)
