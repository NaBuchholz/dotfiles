-- Review draft: load only after the environment defaults and personal overrides.
local root = (os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")) .. "/hypr/nyx/"
local platform = dofile(root .. "platform.lua")
dofile(root .. "bindings.lua")(platform)
dofile(root .. "input.lua")
