# Nyx Dotfiles

Shared dotfiles for my Arch Linux desktop and notebook.

The goal is to keep the personal configuration consistent across both machines while preserving environment-specific behavior:

* **Desktop:** Arch Linux + Hyprland + HyDE
* **Notebook:** Arch Linux + Hyprland + Omarchy

The repository is structured as GNU Stow packages, but **nothing is currently linked through Stow**.

## Repository Structure

```text
.
├── fish/
│   └── .config/
│       └── fish/
│           ├── config.fish
│           ├── fish_plugins
│           └── functions/
│               └── ccatmany.fish
│
├── herdr/
│   └── .config/
│       └── herdr/
│           └── config.toml
│
├── hypr-common/
│   └── .config/
│       └── hypr/
│           └── nyx/
│               ├── bindings.lua
│               ├── init.lua
│               └── input.lua
│
├── hypr-desktop/
│   └── .config/
│       └── hypr/
│           └── nyx/
│               └── platform.lua
│
├── hypr-notebook/
│   └── .config/
│       └── hypr/
│           └── nyx/
│               └── platform.lua
│
├── kitty/
│   └── .config/
│       └── kitty/
│           └── kitty.conf
│
├── scripts/
│   └── .local/
│       └── bin/
│           └── mix_tracks
│
├── .gitignore
├── LICENSE
└── README.md
```

## Package Model

Each top-level configuration directory is a GNU Stow package.

For example:

```text
fish/.config/fish/config.fish
```

is intended to become:

```text
~/.config/fish/config.fish
```

after:

```bash
stow --no-folding fish
```

The same model applies to Kitty, Herdr, scripts and Hyprland configuration.

Stow has **not yet been applied**. Existing files under `$HOME` must be reviewed and backed up before creating the symlinks.

---

# Fish

Shared Fish configuration lives in:

```text
fish/.config/fish/
```

The shell configuration currently defines:

* `EDITOR=nvim`
* `VISUAL=nvim`
* XDG config/cache defaults
* fzf Fish integration
* eza abbreviations
* directory navigation abbreviations
* yay package-management abbreviations
* Git abbreviations
* lazygit integration
* lazydocker integration
* VS Code shortcut
* fd and ripgrep shortcuts

Optional commands are guarded with `type -q`, allowing the same configuration to work even when some tools are not installed.

## Fisher Plugins

Currently tracked:

```text
jorgebucaran/fisher
jorgebucaran/nvm.fish
```

Plugin installation still needs to be included in the machine bootstrap process.

---

# Kitty

Shared Kitty configuration lives in:

```text
kitty/.config/kitty/kitty.conf
```

It controls personal settings such as:

* font size
* window padding and initial size
* cursor behavior
* scrollback
* clipboard shortcuts
* audio bell
* close confirmation
* tab bar appearance

The desktop currently receives additional Kitty configuration from HyDE through:

```conf
include hyde.conf
```

The repository configuration should instead use:

```conf
globinclude hyde.conf
```

This allows the same `kitty.conf` to work in both environments:

* on the desktop, HyDE's `hyde.conf` is loaded when present;
* on a machine without HyDE, Kitty continues using only the shared configuration.

HyDE's own files such as:

```text
hyde.conf
theme.conf
```

remain managed by HyDE and are intentionally not stored in this repository.

---

# Herdr

Herdr is the shared terminal session/multiplexer tool.

Configuration:

```text
herdr/.config/herdr/config.toml
```

Herdr replaces tmux in the personal dotfiles setup.

The exact installation/bootstrap requirements still need to be documented and tested on a clean system.

---

# Personal Scripts

Personal executables live under:

```text
scripts/.local/bin/
```

Current script:

```text
mix_tracks
```

After Stow, it is intended to become:

```text
~/.local/bin/mix_tracks
```

`~/.local/bin` therefore needs to be available in `$PATH`.

---

# Shared Hyprland Configuration

## Scope

Share personal keybindings and Caps Lock as Escape while preserving each environment's own:

* appearance
* window rules
* monitor configuration
* keyboard layout
* touchpad configuration
* power policy

All authored descriptions and comments are in English.

Install `hypr-common` with exactly one of:

```text
hypr-desktop
```

or:

```text
hypr-notebook
```

Both platform packages intentionally provide the same destination file:

```text
~/.config/hypr/nyx/platform.lua
```

Therefore they must never be installed together.

The desktop retains HyDE.

The notebook retains Omarchy.

## Hyprland Packages

Shared configuration:

```text
hypr-common/.config/hypr/nyx/
├── bindings.lua
├── init.lua
└── input.lua
```

Desktop-specific integration:

```text
hypr-desktop/.config/hypr/nyx/platform.lua
```

Notebook-specific integration:

```text
hypr-notebook/.config/hypr/nyx/platform.lua
```

The common files use the Hyprland API directly.

Environment-specific helpers belong only in `platform.lua`.

---

# Keymap

| Action                               | Shortcut                                 |
| ------------------------------------ | ---------------------------------------- |
| Focus left/down/up/right             | Super + H/J/K/L or arrows                |
| Move window                          | Super + Shift + H/J/K/L or arrows        |
| Resize window                        | Super + Ctrl + Shift + H/J/K/L or arrows |
| Close window                         | Super + Q                                |
| Toggle fullscreen                    | Super + F                                |
| Toggle floating                      | Super + Shift + F                        |
| Toggle split                         | Super + Ctrl + J                         |
| Toggle group                         | Super + G                                |
| Previous/next group member           | Super + Alt + H/L or Left/Right          |
| Toggle scratchpad                    | Super + S                                |
| Send to scratchpad without following | Super + Alt + S                          |
| Terminal                             | Super + T                                |
| Herdr session                        | Super + Alt + T                          |
| File manager / Zen / launcher        | Super + E / B / A                        |
| VS Code / Discord / Obsidian         | Super + C / D / O                        |
| Clipboard history                    | Super + V                                |
| Keybinding help                      | Super + /                                |
| Lock session                         | Super + Ctrl + L                         |
| Additional Escape                    | Caps Lock                                |

Numbered workspace shortcuts remain supplied by each environment.

Use:

```text
Super + Shift + workspace number
```

to move a scratchpad window back to a numbered workspace.

Other non-conflicting environment shortcuts remain available and may differ between HyDE and Omarchy.

Floating windows move by 30 pixels per step.

Tiled windows use directional movement.

Resize changes:

* width with `H/L`
* height with `K/J`

in 30-pixel steps.

This represents size adjustment and does not guarantee movement of a particular edge of a tiled window.

---

# Changes to Existing Hyprland Defaults

The shared keymap intentionally replaces several environment defaults.

* HyDE `Shift + arrows` resize while Omarchy uses them for swapping. Both become window movement.
* HyDE `Ctrl + Shift + arrows` move. They become resize.
* `Alt + Left/Right` changes wallpapers in HyDE and navigates groups in Omarchy. They become previous/next group member.
* The previous environment-specific terminal/session shortcuts are replaced by the common terminal and Herdr bindings.
* `Shift + F` pins windows in HyDE and opens files in Omarchy. It becomes floating.
* Omarchy `Super + T`, `C`, `O`, `J`, `K`, `L`, `V` and Slash are reassigned.
* Remove `Super + W` from both environments. It floats in HyDE and closes in Omarchy.
* Remove `Super + X` from both environments. HyDE uses it for mouse resize and Omarchy as universal cut.
* Native application and terminal copy/paste/cut shortcuts remain untouched.
* Remove HyDE `Shift + V` and Omarchy `Ctrl + V` clipboard shortcuts. `Super + V` becomes the shared clipboard shortcut.
* Replace keyboard options with:

```text
caps:escape
```

This removes Omarchy Compose and both-Shifts Caps Lock behavior.

Keyboard layout and model are not changed.

Functions displaced from their previous combinations are not necessarily reassigned.

This currently includes functions such as:

* pin
* dropdown terminal
* wallpaper cycling
* monitor scaling
* layout switching

Existing environment menus and unaffected shortcuts remain available.

Adding common shortcuts for those functions is a separate decision.

---

# Hyprland Loader

The shared configuration is loaded with:

```lua
local config_home = os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")
dofile(config_home .. "/hypr/nyx/init.lua")
```

## Desktop

Replace only the existing personal keybinding loader with the Nyx loader.

Preserve:

* HyDE bootstrap
* keyboard layout/model configuration
* window rules
* HyDE-specific imports

Do not load both the old personal keybinding file and `nyx/init.lua`.

The old configuration should remain available in the backup until validation is complete.

## Notebook

Load the Nyx configuration after Omarchy's:

* defaults
* personal overrides
* toggle imports

Do not replace the Omarchy bootstrap.

---

# Stow Strategy

Nothing is currently installed through Stow.

Before creating any symlinks:

1. inspect the existing configuration;
2. compare existing files against the repository;
3. back up configuration that is still needed;
4. simulate Stow;
5. only then create the links.

Simulation example:

```bash
stow --no-folding -nv fish
```

Actual linking:

```bash
stow --no-folding fish
```

Expected independent packages include:

```text
fish
kitty
herdr
scripts
```

For Hyprland desktop:

```bash
stow --no-folding hypr-common
stow --no-folding hypr-desktop
```

For Hyprland notebook:

```bash
stow --no-folding hypr-common
stow --no-folding hypr-notebook
```

Never install both platform packages simultaneously.

---

# Activation Plan

## 1. Audit Existing Configuration

Compare repository files with the live configuration under:

```text
~/.config/
```

especially:

```text
~/.config/fish/
~/.config/kitty/
~/.config/herdr/
~/.config/hypr/
```

## 2. Back Up Existing Configuration

Back up files before replacing them with Stow-managed symlinks.

Environment-owned configuration from HyDE and Omarchy should not be copied blindly into the repository.

## 3. Simulate Stow

Use:

```bash
stow --no-folding -nv <package>
```

and inspect every conflict before applying it.

## 4. Link Basic Packages

Start with the less environment-sensitive packages:

```text
fish
kitty
herdr
scripts
```

## 5. Link Hyprland

Install:

```text
hypr-common
```

plus the correct platform package.

## 6. Install the Loader

Integrate `nyx/init.lua` into the existing HyDE or Omarchy Hyprland configuration without replacing their complete bootstrap.

## 7. Reload and Validate

Inspect Hyprland configuration errors and test:

* application launching
* focus
* window movement
* resize
* fullscreen
* floating
* grouping
* scratchpad
* clipboard
* Caps Lock → Escape
* keybinding help
* session launcher behavior

## 8. Commit

Commit only after live validation.

If validation fails, restore the backed-up loader/configuration and reload Hyprland.

---

# Validation Boundaries

Lua syntax can be checked offline.

The following require live validation on each machine:

* Hyprland API compatibility
* removal or overriding of existing bindings
* repeating/locked bindings
* help-menu visibility
* application launching
* group behavior
* scratchpad behavior
* Caps Lock behavior
* HyDE integration
* Omarchy integration
* Herdr launching
* Stow conflicts

Static validation alone does not establish that these behaviors work correctly.

---

# Remaining Work

The repository structure exists, but the deployment process is not finished.

Still required:

* [ ] add the conditional HyDE include to the tracked Kitty configuration
* [ ] review the remaining Fish helper/function configuration
* [ ] verify Herdr configuration
* [ ] verify `~/.local/bin` is available in `$PATH`
* [ ] audit existing files before Stow
* [ ] create backups
* [ ] perform Stow dry-runs
* [ ] link Fish
* [ ] link Kitty
* [ ] link Herdr
* [ ] link scripts
* [ ] integrate Hyprland loader on desktop
* [ ] integrate Hyprland loader on notebook
* [ ] validate both machines
* [ ] create a package/bootstrap installation process
* [ ] test installation on a clean Arch + Hyprland VM
* [ ] document clean-machine recovery/setup

The clean VM is the final validation target before relying on these dotfiles for a desktop reinstall.

## Hyprland Reference

[Hyprland 0.56 bindings reference](https://wiki.hypr.land/0.56.0/Configuring/Basics/Binds/)
