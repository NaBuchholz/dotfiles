-- Shared personal bindings. Environment commands are supplied by platform.lua.
return function(platform)
    local aliases = {
        LEFT = "Left", RIGHT = "Right", UP = "Up", DOWN = "Down",
        SLASH = "slash",
    }

    local function unbind(keys)
        hl.unbind(keys)
        local prefix, key = keys:match("^(.* %+ )([^ ]+)$")
        if aliases[key] then hl.unbind(prefix .. aliases[key]) end
    end

    local function bind(keys, action, description, repeating)
        unbind(keys)
        local options = { description = description }
        if repeating then options.repeating = true end
        hl.bind(keys, action, options)
    end

    for _, keys in ipairs(platform.remove) do unbind(keys) end

    local directions = {
        { "H", "LEFT", "left", -30, 0 },
        { "J", "DOWN", "down", 0, 30 },
        { "K", "UP", "up", 0, -30 },
        { "L", "RIGHT", "right", 30, 0 },
    }

    for _, item in ipairs(directions) do
        local direction, x, y = item[3], item[4], item[5]
        for _, key in ipairs({ item[1], item[2] }) do
            bind("SUPER + " .. key, hl.dsp.focus({ direction = direction }),
                "[Nyx|Navigation] Focus " .. direction)
            bind("SUPER + SHIFT + " .. key, function()
                local window = hl.get_active_window()
                if not window then return end
                local args = window.floating
                    and { x = x, y = y, relative = true }
                    or { direction = direction }
                hl.dispatch(hl.dsp.window.move(args))
            end, "[Nyx|Windows] Move " .. direction, true)
            bind("SUPER + CTRL + SHIFT + " .. key,
                hl.dsp.window.resize({ x = x, y = y, relative = true }),
                "[Nyx|Windows] " .. (x < 0 and "Decrease width" or x > 0 and "Increase width"
                    or y < 0 and "Decrease height" or "Increase height"), true)
        end
    end

    bind("SUPER + Q", hl.dsp.window.close(), "[Nyx|Windows] Close window")
    bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }), "[Nyx|Windows] Toggle fullscreen")
    bind("SUPER + SHIFT + F", hl.dsp.window.float({ action = "toggle" }), "[Nyx|Windows] Toggle floating")
    bind("SUPER + CTRL + J", hl.dsp.layout("togglesplit"), "[Nyx|Windows] Toggle split")
    bind("SUPER + G", hl.dsp.group.toggle(), "[Nyx|Groups] Toggle group")
    for _, key in ipairs({ "H", "LEFT" }) do
        bind("SUPER + ALT + " .. key, hl.dsp.group.prev(), "[Nyx|Groups] Previous window")
    end
    for _, key in ipairs({ "L", "RIGHT" }) do
        bind("SUPER + ALT + " .. key, hl.dsp.group.next(), "[Nyx|Groups] Next window")
    end

    bind("SUPER + S", platform.scratchpad_toggle, "[Nyx|Scratchpad] Toggle scratchpad")
    bind("SUPER + ALT + S", hl.dsp.window.move({ workspace = platform.scratchpad, follow = false }),
        "[Nyx|Scratchpad] Send window to scratchpad")

    local apps = {
        { "T", "terminal", "Open terminal" },
        { "ALT + T", "tmux", "Open or attach tmux session" },
        { "E", "files", "Open file manager" },
        { "B", "browser", "Open Zen" },
        { "A", "launcher", "Open application launcher" },
        { "C", "editor", "Open VS Code" },
        { "D", "discord", "Open Discord" },
        { "O", "obsidian", "Open Obsidian" },
        { "V", "clipboard", "Open clipboard history" },
        { "SLASH", "help", "Show keybindings" },
        { "CTRL + L", "lock", "Lock session" },
    }
    for _, app in ipairs(apps) do
        bind("SUPER + " .. app[1], hl.dsp.exec_cmd(platform.commands[app[2]]), "[Nyx|Actions] " .. app[3])
    end
end
