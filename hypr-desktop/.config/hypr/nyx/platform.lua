-- Desktop integration. HyDE must already be loaded.
assert(hyde, "Load the HyDE defaults before the Nyx configuration")
return {
    -- Remove legacy aliases that conflict with the agreed grammar.
    remove = { "SUPER + CTRL + H", "SUPER + W", "SUPER + X", "SUPER + SHIFT + V" },
    scratchpad = "special",
    scratchpad_toggle = hl.dsp.workspace.toggle_special(),
    commands = {
        terminal = "kitty fish",
        tmux = [[kitty sh -c 'tmux attach || tmux new -s Work fish']],
        files = "dolphin",
        browser = "zen-browser",
        editor = "code",
        discord = "discord",
        obsidian = '"' .. os.getenv("HOME") .. '/.local/bin/obsidian"',
        launcher = hyde.sh.menu.apps(),
        clipboard = hyde.sh.menu.clipboard(),
        help = hyde.sh.menu.binds(),
        lock = hyde.sh.session.lock(),
    },
}
