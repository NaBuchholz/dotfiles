-- Notebook integration. Preserve the Omarchy terminal selector and helpers.
return {
    remove = { "SUPER + X", "SUPER + W", "SUPER + CTRL + V" },
    scratchpad = "special:scratchpad",
    scratchpad_toggle = hl.dsp.workspace.toggle_special("scratchpad"),
    commands = {
        terminal = "omarchy-launch-terminal fish",
        tmux = [[omarchy-launch-terminal sh -c 'tmux attach || tmux new -s Work fish']],
        files = "omarchy-launch-nautilus",
        browser = "uwsm-app -- zen-browser",
        editor = "uwsm-app -- code",
        discord = "omarchy-launch-webapp https://discord.com/channels/@me",
        obsidian = "uwsm-app -- obsidian",
        launcher = "omarchy-menu toggle apps",
        clipboard = "omarchy-shell shell toggle omarchy.clipboard",
        help = "omarchy-menu-keybindings",
        lock = "omarchy-system-lock",
    },
}
