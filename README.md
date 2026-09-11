# Shared Hyprland configuration — review draft

Status: staged for review only. Nothing has been installed, linked or reloaded.

## Scope

Share personal keybindings and Caps Lock as Escape. Preserve each environment's
appearance, window rules, monitors, keyboard layout, touchpad and power policy.
All authored descriptions and comments are in English.

Install `hypr-common` with exactly one of `hypr-desktop` or `hypr-notebook`.
Both platform packages intentionally provide the same destination file.
The desktop retains HyDE; the notebook retains Omarchy.

## Keymap

| Action | Shortcut |
| --- | --- |
| Focus left/down/up/right | Super + H/J/K/L or arrows |
| Move window | Super + Shift + H/J/K/L or arrows |
| Resize window | Super + Ctrl + Shift + H/J/K/L or arrows |
| Close window | Super + Q |
| Toggle fullscreen | Super + F |
| Toggle floating | Super + Shift + F |
| Toggle split | Super + Ctrl + J |
| Toggle group | Super + G |
| Previous/next group member | Super + Alt + H/L or Left/Right |
| Toggle scratchpad | Super + S |
| Send to scratchpad without following | Super + Alt + S |
| Terminal / tmux | Super + T / Super + Alt + T |
| File manager / Zen / launcher | Super + E / B / A |
| VS Code / Discord / Obsidian | Super + C / D / O |
| Clipboard history | Super + V |
| Keybinding help | Super + / |
| Lock session | Super + Ctrl + L |
| Additional Escape | Caps Lock |

Numbered workspace shortcuts remain supplied by each environment. Use
Super + Shift + a workspace number to move a scratchpad window back out.
Other non-conflicting environment shortcuts remain available and can differ.

Floating windows move by 30 pixels per step. Tiled windows use directional move.
Resize changes width with H/L and height with K/J, in 30-pixel steps. This is
size adjustment, not a promise to move a particular edge of a tiled window.

## Changes to existing defaults

- HyDE Shift+arrows resize; Omarchy Shift+arrows swap. Both become move.
- HyDE Ctrl+Shift+arrows move. They become resize.
- Alt+Left/Right changes wallpapers in HyDE and moves into groups in Omarchy.
  These combinations become previous/next group member.
- HyDE Alt+T opens the dropdown terminal. It becomes tmux.
- Shift+F pins in HyDE and opens files in Omarchy. It becomes floating.
- Omarchy Super+T, C, O, J, K, L, V and Slash are reassigned.
- Remove Super+W on both: it currently floats in HyDE but closes in Omarchy.
  Use the common explicit shortcuts instead.
- Remove Super+X on both: HyDE mouse resize and Omarchy universal cut.
  Native application/terminal copy, paste and cut shortcuts remain untouched.
- Remove HyDE Shift+V and Omarchy Ctrl+V clipboard shortcuts: Super+V is the
  shared clipboard shortcut. HyDE's separate clipboard-manager shortcut is lost.
- Keep Omarchy Alt+Enter as its existing tmux alias. The new common Alt+T
  explicitly starts Fish only when creating a session; existing sessions retain
  their shells. The launcher attaches to an existing session or creates Work.
- Replace keyboard options with caps:escape. This removes the Omarchy Compose
  and both-Shifts Caps Lock behavior. Layout and model are not changed.

Functions displaced from a combination are not all assigned new shortcuts in
this draft (pin, dropdown terminal, wallpaper cycling, monitor scaling, layout
switching). Existing environment menus and other unaffected bindings remain.
Adding shortcuts for those functions or for moving into/out of a group is a
separate decision. Creating groups and switching members are covered here.

## Activation design — not yet performed

1. Verify desktop tmux installation and notebook Discord availability. Confirm
   the desktop application commands and each machine's graphical Hyprland version.
2. Back up the current user Hyprland configuration on each machine.
3. Copy the packages into the existing dotfiles repository and inspect the diff.
4. Simulate Stow with --no-folding, then link the common package and one platform.
5. Desktop: replace only require("keybinds") with the loader below. Preserve the
   HyDE bootstrap, keyboard layout/model block and require("windowrules"). Do not
   load the old keybinds.lua as well. Keep it in the backup for rollback.
6. Notebook: append the loader after the existing defaults, personal overrides
   and toggle imports. Do not replace the Omarchy bootstrap.
7. Reload and inspect configerrors, then test the bindings and both help menus.
8. Commit only after live validation. Restore the original loader/configuration
   from the backup and reload if the candidate fails.

Loader to insert at the location described above:

```lua
local config_home = os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")
dofile(config_home .. "/hypr/nyx/init.lua")
```

## Validation boundaries

Lua syntax can be checked offline. Compositor API compatibility, removal of
locked/repeating defaults, help-menu visibility, actual application launching,
group behavior, scratchpad behavior and Caps Lock require live validation on
each machine. Static validation does not establish those results.

The two environments use different helper layers. The common files use the
Hyprland API; environment helpers appear only in platform.lua.

Sources: the supplied desktop configuration and installed Omarchy files;
[Hyprland 0.56 bindings reference](https://wiki.hypr.land/0.56.0/Configuring/Basics/Binds/).
