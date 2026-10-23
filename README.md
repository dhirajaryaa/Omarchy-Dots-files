# Omarchy Dotfiles Backup

Personal Omarchy desktop configuration snapshot from **lapi**, created
**2026-10-23**. The private repository is
[`dhirajaryaa/Omarchy-Dots-files`](https://github.com/dhirajaryaa/Omarchy-Dots-files).

This is a **curated backup of `~/.config/hypr` and `~/.config/omarchy` only** — not a
home-directory copy, application-data dump, or system image. It is designed to restore
Hyprland and Omarchy customizations after a clean Omarchy reinstall.

> Keep this repository **private**. It contains your hostname, home path, bar preferences,
> wallpapers, and personal keybindings. It deliberately does **not** contain SSH/GPG keys,
> API tokens, browser profiles, Git identity, or AI-agent configuration.

## Quick facts

| Item | Value |
| --- | --- |
| Snapshot time | `2026-10-23T10:12:12+05:30` |
| Omarchy | `4.0.6-1` (`/usr/share/omarchy`) |
| OS | Omarchy (Arch-based), kernel `7.2.8-9-omarchy` |
| Hyprland | `0.56.2-4` |
| Quickshell | `0.3.2.r7.g2b4501a-1` |
| Current theme | `solitude` |
| Current wallpaper | `~/.config/omarchy/backgrounds/solitude/14.jpg` |
| Config payload | **107 files** (9 Hyprland, 98 Omarchy) |
| Verification | **115/115 SHA-256 checksums OK** (107 config + 8 package files) |
| Size | about **96 MB**, mostly duplicate wallpaper trees |
| Largest file | `17.png`, about **11.6 MB** |
| Git remote | `git@github.com:dhirajaryaa/Omarchy-Dots-files.git` |
| Repository visibility | **PRIVATE** |

### Version note: Omarchy 4.x uses Lua configs

Omarchy 4.0.6 uses the Lua-based Hyprland configuration. The files are:

```text
~/.config/hypr/hyprland.lua
~/.config/hypr/bindings.lua
~/.config/hypr/monitors.lua
~/.config/hypr/input.lua
~/.config/hypr/looknfeel.lua
~/.config/hypr/autostart.lua
```

There is no `hyprland.conf` to restore. The two `.conf` files in this backup are for
Hyprsunset and XDPH, not the main Hyprland config.

## What is in the backup

| Category | Files | Restores to |
| --- | ---: | --- |
| Hyprland Lua config | 9 | `~/.config/hypr/` |
| Omarchy shell settings | 2 | `~/.config/omarchy/shell.json`, `shell.toml` |
| Menu extension | 1 | `~/.config/omarchy/extensions/omarchy-menu.jsonc` |
| Theme hook | 1 | `~/.config/omarchy/hooks/theme-set.d/omazed` |
| User themes | 47 | `~/.config/omarchy/themes/` (`aether`, `snow_black`) |
| Activity Monitor plugin | 29 | `~/.config/omarchy/plugins/stappmus.activity-monitor/` |
| Custom wallpapers | 16 | `~/.config/omarchy/backgrounds/solitude/` |
| Branding text | 2 | `~/.config/omarchy/branding/` |
| **Total** | **107** | |

The 47 theme files are 5 files from `aether` and 42 files from `snow_black`. The plugin
files include QML, helper binaries, build files, tests, and documentation. The backup has
no symlinks.

### Deliberately excluded

- All other `~/.config` application directories: terminals, editors, Neovim, Git,
  Alacritty, Ghostty, Kitty, foot, btop, cava, tmux, starship, autostart entries, and
  Omarchy's `defaults/agent` AI preference.
- Every personal home-directory file: `.bashrc`, `.bash_profile`, `.XCompose`, fonts,
  `~/.local/bin`, shell history, documents, downloads, and media.
- SSH keys, GPG keys, certificate stores, GitHub CLI auth, Git credentials, API tokens,
  AI-agent configuration, browser profiles, password managers, and application state.
- The Activity Monitor plugin's `stappmus-activity-monitor.sudoers` privilege rule and the
  `.git` pack directories of the third-party theme and plugin.
- System-managed files under `/etc`, `/boot`, and `/usr/share/omarchy`.

The package lists are metadata only. They do not cause a package reinstall.

## Detailed configuration inventory

The following 107 paths are exactly what is tracked under `config/`. The machine-readable
version — with original source path, mode, size, SHA-256, and symlink target — is in
`manifest/files.tsv`.

```text
config/hypr/autostart.lua
config/hypr/bindings.lua
config/hypr/hyprland.lua
config/hypr/hyprsunset.conf
config/hypr/input.lua
config/hypr/looknfeel.lua
config/hypr/.luarc.json
config/hypr/monitors.lua
config/hypr/xdph.conf
config/omarchy/backgrounds/solitude/10.jpg
config/omarchy/backgrounds/solitude/11.png
config/omarchy/backgrounds/solitude/12.jpeg
config/omarchy/backgrounds/solitude/13.png
config/omarchy/backgrounds/solitude/14.jpg
config/omarchy/backgrounds/solitude/15.jpg
config/omarchy/backgrounds/solitude/16.jpg
config/omarchy/backgrounds/solitude/17.png
config/omarchy/backgrounds/solitude/1.jpg
config/omarchy/backgrounds/solitude/2.png
config/omarchy/backgrounds/solitude/3.jpg
config/omarchy/backgrounds/solitude/4.png
config/omarchy/backgrounds/solitude/5.jpg
config/omarchy/backgrounds/solitude/7.png
config/omarchy/backgrounds/solitude/8.jpg
config/omarchy/backgrounds/solitude/9.png
config/omarchy/branding/about.txt
config/omarchy/branding/screensaver.txt
config/omarchy/extensions/omarchy-menu.jsonc
config/omarchy/hooks/theme-set.d/omazed
config/omarchy/plugins/stappmus.activity-monitor/ActivityController.qml
config/omarchy/plugins/stappmus.activity-monitor/activity-power-reader
config/omarchy/plugins/stappmus.activity-monitor/activity-sampler
config/omarchy/plugins/stappmus.activity-monitor/activity-sampler.cpp
config/omarchy/plugins/stappmus.activity-monitor/activity-stats
config/omarchy/plugins/stappmus.activity-monitor/.gitignore
config/omarchy/plugins/stappmus.activity-monitor/LICENSE
config/omarchy/plugins/stappmus.activity-monitor/Makefile
config/omarchy/plugins/stappmus.activity-monitor/manifest.json
config/omarchy/plugins/stappmus.activity-monitor/Model.js
config/omarchy/plugins/stappmus.activity-monitor/Panel.qml
config/omarchy/plugins/stappmus.activity-monitor/PKGBUILD
config/omarchy/plugins/stappmus.activity-monitor/preview-compact.png
config/omarchy/plugins/stappmus.activity-monitor/preview-cpu-layouts.png
config/omarchy/plugins/stappmus.activity-monitor/preview-expanded.png
config/omarchy/plugins/stappmus.activity-monitor/preview.png
config/omarchy/plugins/stappmus.activity-monitor/ProcessActionController.qml
config/omarchy/plugins/stappmus.activity-monitor/process-signal
config/omarchy/plugins/stappmus.activity-monitor/README.md
config/omarchy/plugins/stappmus.activity-monitor/scripts/render-cpu-layouts.js
config/omarchy/plugins/stappmus.activity-monitor/Sparkline.qml
config/omarchy/plugins/stappmus.activity-monitor/.SRCINFO
config/omarchy/plugins/stappmus.activity-monitor/test/activity-details-test.sh
config/omarchy/plugins/stappmus.activity-monitor/test/activity-native-test.sh
config/omarchy/plugins/stappmus.activity-monitor/test/activity-privilege-test.sh
config/omarchy/plugins/stappmus.activity-monitor/test/activity-process-action-test.sh
config/omarchy/plugins/stappmus.activity-monitor/test/activity-test.sh
config/omarchy/plugins/stappmus.activity-monitor/test/all.sh
config/omarchy/plugins/stappmus.activity-monitor/test/base-test.sh
config/omarchy/shell.json
config/omarchy/shell.toml
config/omarchy/themes/aether/.aether-managed
config/omarchy/themes/aether/backgrounds/15.jpg
config/omarchy/themes/aether/colors.toml
config/omarchy/themes/aether/icons.theme
config/omarchy/themes/aether/preview.jpg
config/omarchy/themes/snow_black/alacritty.toml
config/omarchy/themes/snow_black/backgrounds/10.jpg
config/omarchy/themes/snow_black/backgrounds/11.png
config/omarchy/themes/snow_black/backgrounds/12.jpeg
config/omarchy/themes/snow_black/backgrounds/13.png
config/omarchy/themes/snow_black/backgrounds/14.jpg
config/omarchy/themes/snow_black/backgrounds/15.jpg
config/omarchy/themes/snow_black/backgrounds/16.jpg
config/omarchy/themes/snow_black/backgrounds/17.png
config/omarchy/themes/snow_black/backgrounds/1.jpg
config/omarchy/themes/snow_black/backgrounds/2.png
config/omarchy/themes/snow_black/backgrounds/3.jpg
config/omarchy/themes/snow_black/backgrounds/4.png
config/omarchy/themes/snow_black/backgrounds/5.jpg
config/omarchy/themes/snow_black/backgrounds/7.png
config/omarchy/themes/snow_black/backgrounds/8.jpg
config/omarchy/themes/snow_black/backgrounds/9.png
config/omarchy/themes/snow_black/btop.theme
config/omarchy/themes/snow_black/cava_theme
config/omarchy/themes/snow_black/chromium.theme
config/omarchy/themes/snow_black/colors.conf
config/omarchy/themes/snow_black/colors.toml
config/omarchy/themes/snow_black/firefox.css
config/omarchy/themes/snow_black/ghostty.conf
config/omarchy/themes/snow_black/ghostty-theme.conf
config/omarchy/themes/snow_black/gtk.css
config/omarchy/themes/snow_black/hyprland.conf
config/omarchy/themes/snow_black/hyprlock.conf
config/omarchy/themes/snow_black/icons.theme
config/omarchy/themes/snow_black/kitty.conf
config/omarchy/themes/snow_black/mako.ini
config/omarchy/themes/snow_black/neovim.lua
config/omarchy/themes/snow_black/preview.png
config/omarchy/themes/snow_black/README.md
config/omarchy/themes/snow_black/snowbar/config.jsonc
config/omarchy/themes/snow_black/snowbar/style.css
config/omarchy/themes/snow_black/swayosd.css
config/omarchy/themes/snow_black/vencord.theme.css
config/omarchy/themes/snow_black/vscode_colors.json
config/omarchy/themes/snow_black/vscode.json
config/omarchy/themes/snow_black/walker.css
config/omarchy/themes/snow_black/waybar.css
```

## Keyboard shortcuts

The live keybinding list was exported at backup time with
`omarchy menu keybindings --print`. It contains **227 active bindings**, including the
eight personal overrides shown first.

### Your custom bindings

| Shortcut | Action | Implementation |
| --- | --- | --- |
| `SUPER + M` | Microphone toggle | `wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle` |
| `SUPER SHIFT + V` | VS Code | `code` |
| `SUPER SHIFT + A` | ChatGPT | Omarchy web app: `https://chatgpt.com` |
| `SUPER SHIFT ALT + A` | Claude | Omarchy web app: `https://claude.ai/new` |
| `SUPER SHIFT + E` | Gmail | Omarchy web app: `https://mail.google.com/mail/u/0/` |
| `SUPER SHIFT + X` | X | Omarchy web app: `https://x.com/` |
| `SUPER SHIFT + G` | GitHub | Omarchy web app: `https://github.com/` |
| `SUPER SHIFT + L` | LinkedIn | Omarchy web app: `https://linkedin.com/` |

These are defined in `config/hypr/bindings.lua`. The file also contains commented-out
examples for changing Omarchy defaults and a commented-out Claude Desktop launcher.

### All active bindings (227)

`★` marks one of the eight personal overrides above; all other rows are Omarchy defaults.

<details>
<summary>Show all 227 active keybindings</summary>

| Shortcut | Action |
| --- | --- |
| `SUPER + K` | Keybindings |
| `SUPER + SPACE` | Omarchy menu |
| `SUPER + RETURN` | Terminal |
| `SUPER SHIFT + RETURN` | Browser |
| `SUPER SHIFT + F` | File manager |
| `SUPER + ESCAPE` | System menu |
| `SUPER SHIFT CTRL + SPACE` | Theme menu |
| `SUPER + F` | Full screen |
| `SUPER ALT + F` | Full width |
| `SUPER + W` | Close window |
| `CTRL ALT + DELETE` | Close all windows |
| `SUPER CTRL + L` | Lock system |
| `SUPER + T` | Toggle window floating/tiling |
| `SUPER + J` | Toggle window split |
| `SUPER + O` | Pop window out (float & pin) |
| `SUPER + C` | Universal copy |
| `SUPER + V` | Universal paste |
| `SUPER + X` | Universal cut |
| `SUPER CTRL + V` | Clipboard manager |
| `SUPER CTRL + E` | Emojis |
| `SUPER + PRINT` | Color picker |
| `PRINT` | Screenshot |
| `ALT + PRINT` | Screenrecording |
| `SUPER ALT + RETURN` | Tmux |
| `SUPER CTRL + RETURN` | Herdr |
| `SUPER SHIFT ALT + B` | Browser (private) |
| `SUPER SHIFT + B` | Browser |
| `SUPER SHIFT ALT + F` | File manager (cwd) |
| `SUPER + 0` | Switch to workspace 10 |
| `SUPER + 1` | Switch to workspace 1 |
| `SUPER + 2` | Switch to workspace 2 |
| `SUPER + 3` | Switch to workspace 3 |
| `SUPER + 4` | Switch to workspace 4 |
| `SUPER + 5` | Switch to workspace 5 |
| `SUPER + 6` | Switch to workspace 6 |
| `SUPER + 7` | Switch to workspace 7 |
| `SUPER + 8` | Switch to workspace 8 |
| `SUPER + 9` | Switch to workspace 9 |
| `SUPER CTRL + TAB` | Former workspace |
| `SUPER SHIFT + TAB` | Previous workspace |
| `SUPER + TAB` | Next workspace |
| `SUPER SHIFT + 0` | Move window to workspace 10 |
| `SUPER SHIFT + 1` | Move window to workspace 1 |
| `SUPER SHIFT + 2` | Move window to workspace 2 |
| `SUPER SHIFT + 3` | Move window to workspace 3 |
| `SUPER SHIFT + 4` | Move window to workspace 4 |
| `SUPER SHIFT + 5` | Move window to workspace 5 |
| `SUPER SHIFT + 6` | Move window to workspace 6 |
| `SUPER SHIFT + 7` | Move window to workspace 7 |
| `SUPER SHIFT + 8` | Move window to workspace 8 |
| `SUPER SHIFT + 9` | Move window to workspace 9 |
| `SUPER SHIFT ALT + 0` | Move window silently to workspace 10 |
| `SUPER SHIFT ALT + 1` | Move window silently to workspace 1 |
| `SUPER SHIFT ALT + 2` | Move window silently to workspace 2 |
| `SUPER SHIFT ALT + 3` | Move window silently to workspace 3 |
| `SUPER SHIFT ALT + 4` | Move window silently to workspace 4 |
| `SUPER SHIFT ALT + 5` | Move window silently to workspace 5 |
| `SUPER SHIFT ALT + 6` | Move window silently to workspace 6 |
| `SUPER SHIFT ALT + 7` | Move window silently to workspace 7 |
| `SUPER SHIFT ALT + 8` | Move window silently to workspace 8 |
| `SUPER SHIFT ALT + 9` | Move window silently to workspace 9 |
| `SUPER SHIFT + DOWN` | Swap window down |
| `SUPER SHIFT + LEFT` | Swap window to the left |
| `SUPER SHIFT + RIGHT` | Swap window to the right |
| `SUPER SHIFT + UP` | Swap window up |
| `ALT + TAB` | Focus on next window |
| `CTRL ALT + TAB` | Focus on next monitor |
| `SHIFT ALT + TAB` | Focus on previous window |
| `SHIFT CTRL ALT + TAB` | Focus on previous monitor |
| `SUPER + DOWN` | Focus on below window |
| `SUPER + LEFT` | Focus on left window |
| `SUPER + RIGHT` | Focus on right window |
| `SUPER + UP` | Focus on above window |
| `SUPER + LEFT MOUSE BUTTON` | Move window |
| `SUPER + RIGHT MOUSE BUTTON` | Resize window |
| `SUPER ALT + MINUS` | Expand window left a little |
| `SUPER CTRL + MINUS` | Expand window left a lot |
| `SUPER + MINUS` | Expand window left |
| `SUPER SHIFT ALT + EQUAL` | Expand window down a little |
| `SUPER SHIFT CTRL + EQUAL` | Expand window down a lot |
| `SUPER SHIFT + EQUAL` | Expand window down |
| `SUPER ALT + EQUAL` | Shrink window left a little |
| `SUPER CTRL + EQUAL` | Shrink window left a lot |
| `SUPER + EQUAL` | Shrink window left |
| `SUPER SHIFT ALT + MINUS` | Shrink window up a little |
| `SUPER SHIFT CTRL + MINUS` | Shrink window up a lot |
| `SUPER SHIFT + MINUS` | Shrink window up |
| `SUPER ALT + S` | Move window to scratchpad |
| `SUPER + S` | Toggle scratchpad |
| `SUPER ALT + COMMA` | Invoke last notification |
| `SUPER + COMMA` | Dismiss last notification |
| `SUPER CTRL + COMMA` | Toggle silencing notifications |
| `SUPER SHIFT ALT + COMMA` | Open notification history |
| `SUPER SHIFT + COMMA` | Dismiss all notifications |
| `SUPER + BACKSPACE` | Toggle window transparency |
| `SUPER CTRL + N` | Toggle nightlight |
| `SUPER CTRL + I` | Toggle locking on idle |
| `SHIFT ALT + D` | Download Video from Web App |
| `SHIFT ALT + L` | Copy URL from Web App |
| `SUPER ALT + BRACKETLEFT` | Make webcam overlay smaller |
| `SUPER ALT + BRACKETRIGHT` | Make webcam overlay larger |
| `SUPER ALT + Home` | Save window width |
| `SUPER ALT + SLASH` | Monitor scaling down |
| `SUPER ALT + SPACE` | Apps menu |
| `SUPER CTRL + 1` | Bar panel 1 |
| `SUPER CTRL + 2` | Bar panel 2 |
| `SUPER CTRL + 3` | Bar panel 3 |
| `SUPER CTRL + 4` | Bar panel 4 |
| `SUPER CTRL + 5` | Bar panel 5 |
| `SUPER CTRL + 6` | Bar panel 6 |
| `SUPER CTRL + 7` | Bar panel 7 |
| `SUPER CTRL + 8` | Bar panel 8 |
| `SUPER CTRL + 9` | Bar panel 9 |
| `SUPER CTRL + A` | Audio |
| `SUPER CTRL ALT + B` | Show battery remaining |
| `SUPER CTRL ALT + D` | Calendar |
| `SUPER CTRL ALT + Delete` | Toggle laptop display mirroring |
| `SUPER CTRL ALT + R` | Show reminders |
| `SUPER CTRL ALT + T` | Show time |
| `SUPER CTRL ALT + W` | Toggle weather |
| `SUPER CTRL ALT + Z` | Reset zoom |
| `SUPER CTRL + BACKSPACE` | Toggle single-window square aspect |
| `SUPER CTRL + B` | Bluetooth |
| `SUPER CTRL + C` | Capture menu |
| `SUPER CTRL + D` | Display |
| `SUPER CTRL + Delete` | Toggle laptop display |
| `SUPER CTRL + F` | Tiled full screen |
| `SUPER CTRL + H` | Hardware menu |
| `SUPER CTRL + O` | Toggle menu |
| `SUPER CTRL + PERIOD` | Transcode |
| `SUPER CTRL + P` | Power |
| `SUPER CTRL + PRINT` | Extract text (OCR) from screenshot |
| `SUPER CTRL + Q` | Calculator |
| `SUPER CTRL + R` | Set reminder |
| `SUPER CTRL + SPACE` | Background switcher |
| `SUPER CTRL + S` | Share |
| `SUPER CTRL + T` | Activity |
| `SUPER CTRL + W` | Network |
| `SUPER CTRL + Z` | Zoom in |
| `SUPER + Home` | Restore window width |
| `SUPER + L` | Toggle workspace layout |
| ★ `SUPER + M` | Microphone toggle |
| `SUPER + P` | Pseudo window |
| ★ `SUPER SHIFT + A` | ChatGPT |
| ★ `SUPER SHIFT ALT + A` | Claude |
| `SUPER SHIFT ALT + DOWN` | Move workspace to down monitor |
| `SUPER SHIFT ALT + E` | New email |
| `SUPER SHIFT ALT + G` | WhatsApp |
| `SUPER SHIFT ALT + LEFT` | Move workspace to left monitor |
| `SUPER SHIFT ALT + M` | Music TUI |
| `SUPER SHIFT ALT + RIGHT` | Move workspace to right monitor |
| `SUPER SHIFT ALT + UP` | Move workspace to up monitor |
| `SUPER SHIFT ALT + X` | X Post |
| `SUPER SHIFT + BACKSPACE` | Toggle window gaps |
| `SUPER SHIFT + C` | Calendar |
| `SUPER SHIFT CTRL + A` | Agent |
| `SUPER SHIFT CTRL + G` | Google Messages |
| `SUPER SHIFT CTRL + R` | Clear reminders |
| `SUPER SHIFT + D` | Docker |
| ★ `SUPER SHIFT + E` | Gmail |
| ★ `SUPER SHIFT + G` | GitHub |
| ★ `SUPER SHIFT + L` | LinkedIn |
| `SUPER SHIFT + M` | Music |
| `SUPER SHIFT + N` | Editor |
| `SUPER SHIFT + O` | Obsidian |
| `SUPER SHIFT + P` | Google Photos |
| `SUPER SHIFT + S` | Google Maps |
| `SUPER SHIFT + SLASH` | Passwords |
| `SUPER SHIFT + SPACE` | Toggle top bar |
| ★ `SUPER SHIFT + V` | VSCode |
| `SUPER SHIFT + W` | Omawrite |
| ★ `SUPER SHIFT + X` | X |
| `SUPER SHIFT + Y` | YouTube |
| `SUPER + SLASH` | Monitor scaling up |
| `SUPER ALT + 1` | Switch to group window 1 |
| `SUPER ALT + 2` | Switch to group window 2 |
| `SUPER ALT + 3` | Switch to group window 3 |
| `SUPER ALT + 4` | Switch to group window 4 |
| `SUPER ALT + 5` | Switch to group window 5 |
| `SUPER ALT + DOWN` | Move window to group on bottom |
| `SUPER ALT + G` | Move active window out of group |
| `SUPER ALT + LEFT` | Move window to group on left |
| `SUPER ALT + mouse_down` | Next window in group |
| `SUPER ALT + mouse_up` | Previous window in group |
| `SUPER ALT + RIGHT` | Move window to group on right |
| `SUPER ALT + TAB` | Next window in group |
| `SUPER ALT + UP` | Move window to group on top |
| `SUPER CTRL + LEFT` | Move grouped window focus left |
| `SUPER CTRL + RIGHT` | Move grouped window focus right |
| `SUPER + G` | Toggle window grouping |
| `SUPER SHIFT ALT + TAB` | Previous window in group |
| `SUPER + mouse_down` | Scroll active workspace forward |
| `SUPER + mouse_up` | Scroll active workspace backward |
| `ALT + TAB` | Reveal active window on top |
| `SHIFT ALT + TAB` | Reveal active window on top |
| `ALT + XF86AudioLowerVolume` | Volume down precise |
| `ALT + XF86AudioPlay` | Next track |
| `ALT + XF86AudioRaiseVolume` | Volume up precise |
| `ALT + XF86MonBrightnessDown` | Brightness down precise |
| `ALT + XF86MonBrightnessUp` | Brightness up precise |
| `SHIFT ALT + XF86AudioPlay` | Previous track |
| `SHIFT + XF86AudioMute` | Switch audio output |
| `SHIFT + XF86AudioPause` | Switch media source |
| `SHIFT + XF86AudioPlay` | Switch media source |
| `SHIFT + XF86MonBrightnessDown` | Brightness minimum |
| `SHIFT + XF86MonBrightnessUp` | Brightness maximum |
| `XF86AudioLowerVolume` | Volume down |
| `XF86AudioMicMute` | Mute microphone |
| `XF86AudioMute` | Mute |
| `XF86AudioNext` | Next track |
| `XF86AudioPause` | Pause |
| `XF86AudioPlay` | Play |
| `XF86AudioPrev` | Previous track |
| `XF86AudioRaiseVolume` | Volume up |
| `XF86Calculator` | Calculator |
| `XF86Eject` | Eject media |
| `XF86KbdBrightnessDown` | Keyboard brightness down |
| `XF86KbdBrightnessUp` | Keyboard brightness up |
| `XF86KbdLightOnOff` | Keyboard backlight cycle |
| `XF86MonBrightnessDown` | Brightness down |
| `XF86MonBrightnessUp` | Brightness up |
| `XF86PowerOff` | Power menu |
| `XF86TouchpadOff` | Disable touchpad |
| `XF86TouchpadOn` | Enable touchpad |
| `XF86TouchpadToggle` | Toggle touchpad |
| `SUPER ALT + K` | Tmux keybindings |
| `SUPER CTRL + K` | Herdr keybindings |

</details>

## Restore guide

### 1. Verify first

```bash
cd ~/Work/omarchy-dots
./scripts/verify.sh
```

The verifier checks every entry in `manifest/checksums.sha256`, then prints the source
Omarchy version, host, theme, and a pass/fail summary. `restore.sh` performs the same
verification automatically and refuses to write anything if a checksum fails.

### 2. See the available categories

```bash
./scripts/restore.sh --list
```

| Category | Restores |
| --- | --- |
| `hypr` | `config/hypr/` → `~/.config/hypr/` |
| `shell` | `shell.json`, `shell.toml` → `~/.config/omarchy/` |
| `extensions` | `extensions/omarchy-menu.jsonc` |
| `hooks` | `hooks/theme-set.d/omazed` |
| `themes` | `themes/aether`, `themes/snow_black` |
| `plugins` | `plugins/stappmus.activity-monitor` |
| `wallpapers` | `backgrounds/solitude` |
| `branding` | `branding/about.txt`, `branding/screensaver.txt` |
| `all` | everything under `config/` |

### 3. Dry run

```bash
./scripts/restore.sh --category hypr --dry-run
./scripts/restore.sh --category all --dry-run
```

A dry run verifies checksums, compares files, and prints `would create` / `would replace`
without touching the desktop. Use it on every new Omarchy release.

### 4. Restore

```bash
# One category, prompting before each replaced file
./scripts/restore.sh --category hypr

# Several categories, no prompts (existing files are still saved first)
./scripts/restore.sh --category hypr,shell,themes,wallpapers --yes

# Everything in this backup
./scripts/restore.sh --category all --yes
```

`--yes` only suppresses prompts. It does **not** skip checksum verification and does
**not** skip saving replaced files.

### Conflict handling

- A byte-identical file is reported `unchanged` and left alone.
- A missing file is created.
- A different existing file triggers a prompt; the default answer is **No**.
- Before replacement, the old file is copied to:

  ```text
  ~/.local/state/omarchy-dotfiles/restore-backup/<timestamp>/
  ```

  The saved path mirrors its original location under `$HOME`, so it can be copied back
  manually.
- A directory at a file destination stops the restore; the script never deletes it.
- If the backup's Omarchy version differs from the running system, the script warns and
  asks for confirmation (unless `--dry-run`). This protects against restoring Lua config
  into an incompatible release.

### Post-restore steps

These are intentionally **not** run automatically:

```bash
# Hyprland
hyprctl reload
hyprctl configerrors

# Omarchy shell, plugins, themes
omarchy restart shell
omarchy plugin list
omarchy theme list

# Current stock theme and wallpaper
omarchy theme set solitude
omarchy theme bg set ~/.config/omarchy/backgrounds/solitude/14.jpg

# Optional user themes
omarchy theme set aether
omarchy theme set snow_black
```

Check the bar after the shell restart. The Activity Monitor plugin should appear in the
right section if `shell.json` and the plugin files were restored. A malformed
`shell.json` can prevent the layout from loading; restore it again and retry.

### Fresh Omarchy reinstall sequence

1. Install Omarchy with the official installer. Do not copy `/etc`, `/boot`, the kernel,
   firmware, or bootloader files from this backup.
2. Boot the new system and run `omarchy update`.
3. Clone this private repository to `~/Work/omarchy-dots`.
4. Run `./scripts/verify.sh`.
5. Dry-run, then restore:
   `./scripts/restore.sh --category all --yes`.
6. Optionally install missing packages from `packages/` (see below).
7. Run `hyprctl reload && hyprctl configerrors`, then `omarchy restart shell`.
8. Apply the theme and wallpaper shown above.
9. Reinstall git-managed themes/plugins if you want upstream updates (see below).
10. Log out and back in once to confirm a clean session.

### Packages

The package lists describe the source machine. They are **not** a reinstall script, and
they include base packages, the kernel, firmware, the bootloader, and Omarchy itself. Do
not blindly reinstall everything.

To see which explicit packages are missing:

```bash
cd ~/Work/omarchy-dots
comm -23 \
  <(sort packages/pacman-explicit-names.txt) \
  <(pacman -Qq | sort)
```

Review the list, then install only what you need:

```bash
comm -23 \
  <(sort packages/pacman-explicit-names.txt) \
  <(pacman -Qq | sort) \
  | sudo pacman -S --needed -
```

Foreign/AUR packages:

```bash
comm -23 \
  <(sort packages/pacman-foreign-names.txt) \
  <(pacman -Qq | sort)
# review, then install individually, for example:
yay -S --needed <package>
```

Keep Omarchy itself under the control of its installer and `omarchy update`.

### Reinstalling the plugin and git themes

The `.git` directories of `snow_black` and the Activity Monitor plugin were excluded to
avoid committing their pack files. The upstream URLs and exact commits are recorded in
`manifest/git-repos.tsv`:

| Repository | Upstream | Commit |
| --- | --- | --- |
| `themes/snow_black` | `https://github.com/ankur311sudo/snow_black` | `394d5d9f128b8c281c92a4e50ee15bcc16a825ed` |
| `plugins/stappmus.activity-monitor` | `https://github.com/stappmus/omarchy-activity-monitor.git` | `b25a98c7ff2a688ab74d86d2be42249e2db2f9cf` |

For upstream updates, prefer a fresh install:

```bash
# Quickshell plugin
omarchy plugin add https://github.com/stappmus/omarchy-activity-monitor.git --enable

# Snow Black theme
omarchy theme install https://github.com/ankur311sudo/snow_black
```

If you restore the copied files instead, validate them:

```bash
omarchy plugin validate ~/.config/omarchy/plugins/stappmus.activity-monitor
omarchy plugin list
omarchy restart shell
```

The plugin's `stappmus-activity-monitor.sudoers` file is **not** in this backup. The basic
CPU/memory/GPU panel works without it. Install the optional privilege helper through the
plugin's own PKGBUILD/Makefile only after reading it.

The `aether` theme is generated by the Aether app. The five backed-up files are enough to
apply it, but regenerating through Aether is the supported workflow.

### What not to restore

Do not use this backup to restore:

- `/etc`, `/boot`, `/usr/share/omarchy`, the kernel, firmware, or the bootloader.
- System packages automatically.
- SSH/GPG keys, GitHub CLI auth, API tokens, password stores, or browser profiles.
- Personal home-directory files that were excluded by request.
- Caches, package caches, or application state.

This is a desktop-configuration backup, not a disaster-recovery image.

## Future backups

Create a new timestamped snapshot without touching the current one:

```bash
cd ~/Work/omarchy-dots
./scripts/backup.sh
```

The default destination is:

```text
~/Backups/omarchy-dotfiles/YYYY-MM-DD_HHMMSS/
```

The script refuses to write into a non-empty directory, so previous snapshots are never
overwritten. Options:

```bash
./scripts/backup.sh --output /path/to/new/empty-dir  # explicit destination
./scripts/backup.sh --no-wallpapers                  # skip wallpaper trees
./scripts/backup.sh --quiet                          # warnings and errors only
```

Each snapshot contains its own manifest, checksums, package lists, `scripts/`, and a short
`README.txt`. Verify it immediately:

```bash
./scripts/verify.sh ~/Backups/omarchy-dotfiles/2026-10-23_120000
```

The repository is a curated snapshot, not an automatic mirror. To refresh it, create a
timestamped backup, review changes with `diff -ru`, copy intended changes into `config/`,
and commit. Do not delete the existing `config/` tree until the differences have been
reviewed.

## Private GitHub storage

The repository is already private and uses this SSH remote:

```text
git@github.com:dhirajaryaa/Omarchy-Dots-files.git
```

Confirm visibility before every push:

```bash
gh repo view dhirajaryaa/Omarchy-Dots-files --json visibility,url
```

The `visibility` value must be `PRIVATE`. Then commit and push:

```bash
cd ~/Work/omarchy-dots
git status --short
git diff --cached --stat
git add -A
git commit -m "Update Omarchy dotfiles backup"
git push -u origin main
```

The SSH remote uses your normal GitHub SSH key. If you prefer HTTPS without touching your
global Git config, use the GitHub CLI credential helper:

```bash
git remote set-url origin https://github.com/dhirajaryaa/Omarchy-Dots-files.git
git -c credential.helper= \
    -c credential.helper='!gh auth git-credential' \
    push -u origin main
```

Do not make the repository public. It contains host identifiers, personal bar settings,
and wallpapers even though secrets are excluded.

### Wallpapers and Git LFS

The payload is about 96 MB and the largest file is about 11.6 MB, below GitHub's 100 MB
per-file limit. LFS is optional. If you add many more wallpapers:

```bash
git lfs install
git lfs track "*.jpg" "*.jpeg" "*.png"
git add .gitattributes
git commit -m "Track wallpapers with Git LFS"
```

### If a secret is ever committed

1. Make the repository private immediately.
2. Revoke and rotate the exposed credential.
3. Remove it from Git history with `git filter-repo` or GitHub's secret-removal workflow.
4. Force-push only after coordinating with anyone else who has the repository.

## Safe Quickshell and Omarchy customization

### How the shell is structured

Omarchy 4.x runs one long-lived Quickshell process, `omarchy-shell`. Most functionality is
delivered as plugins:

- Built-in plugins: `$OMARCHY_PATH/shell/plugins/` — read-only and package-owned.
- User plugins: `~/.config/omarchy/plugins/` — safe to edit.
- Bar layout and idle settings: `~/.config/omarchy/shell.json`.
- Menu extensions: `~/.config/omarchy/extensions/omarchy-menu.jsonc`.
- Theme hook: `~/.config/omarchy/hooks/theme-set.d/omazed`.

Third-party plugins run as arbitrary, unsandboxed code inside the shell process. Only add
repositories you trust, and read the QML before enabling them. Built-in plugins receive
trusted shell interfaces; third-party plugins receive a limited interface but still run
with your user account's access.

### Everyday plugin commands

```bash
omarchy plugin list
omarchy plugin enable omarchy.tailscale
omarchy plugin disable omarchy.weather
omarchy plugin clone omarchy.clock --edit
omarchy plugin add https://github.com/example/plugin.git --enable
omarchy plugin update
omarchy plugin remove example.plugin
omarchy plugin validate ~/.config/omarchy/plugins/example.plugin
```

### The safe way to customize a built-in widget

Do **not** edit `/usr/share/omarchy/shell/plugins/`. Clone it instead:

```bash
omarchy plugin clone omarchy.clock --edit
```

This creates `~/.config/omarchy/plugins/<username>.clock`, enables it, and redirects calls
to the original plugin id to your clone. Remove the clone to fall back to the built-in.
Saving QML reloads it automatically.

### Bar layout

Use the Omarchy CLI when possible:

```bash
omarchy bar move omarchy.clock --section right
```

Or edit `~/.config/omarchy/shell.json` directly. Keep a copy before large edits; the shell
hot-reloads JSON and user plugin QML on save.

### Themes and hooks

- A custom theme lives in `~/.config/omarchy/themes/<name>/` and needs at least
  `colors.toml`. Do not edit stock themes in `/usr/share/omarchy/themes/`.
- Apply with `omarchy theme set <name>`; refresh generated templates with
  `omarchy theme refresh`.
- Hooks are executable scripts in `~/.config/omarchy/hooks/<event>.d/`. Install with
  `omarchy hook install <event> <script>`. Events include `post-boot`, `post-update`,
  `theme-set`, `font-set`, `battery-low`, and `pre-refresh-pacman`.
- `omazed` is a one-line theme-set hook: `omazed set "$1"`.

### Updating without losing changes

1. Run `./scripts/backup.sh`.
2. Run `omarchy update`.
3. Run `omarchy plugin update` for git-managed plugins and review the diff.
4. Run `hyprctl reload && hyprctl configerrors`.
5. Run `omarchy restart shell`.
6. Re-apply the theme if colors look stale: `omarchy theme set <name>`.
7. If a plugin breaks, disable it with `omarchy plugin disable <id>` and check upstream.

Never edit `/usr/share/omarchy/`; updates overwrite it. Put overrides in `~/.config/`.
Never store API keys, tokens, or passwords in `shell.json`, plugin QML, hooks, or theme
files.

## Security and exclusions

### Excluded from this backup

| Path / pattern | Reason |
| --- | --- |
| All `~/.config` directories except `hypr/` and `omarchy/` | Terminal, editor, Git, AI-agent, browser, app state, and private configs. |
| `~/.config/omarchy/defaults/agent` | AI-agent preference; excluded by request. |
| `~/.config/omarchy/plugins/stappmus.activity-monitor/stappmus-activity-monitor.sudoers` | Privilege-escalation rule; security-sensitive upstream file. |
| `~/.ssh/`, `~/.gnupg/`, `~/.pki/` | Private keys and authentication material. |
| `~/.config/gh/`, Git credential helpers | GitHub CLI auth and secrets. |
| Browser profiles, password managers, AI tools | Cookies, sessions, tokens, and password stores. |
| `~/.cache/`, `~/.local/share/`, `~/.local/state/` | Caches and generated/runtime state. |
| `~/Documents`, `Downloads`, `Pictures`, `Videos`, `Music` | Personal documents and media. |
| `~/.bashrc`, `~/.bash_profile`, `~/.XCompose`, `~/.fonts/`, `~/.local/bin/` | Personal home-directory files. |
| `*.lacquer-backup-*`, `*.bak.*`, `*.sample` | Stale/generated local backups and stock samples. |
| Stock first-run hooks | Verified identical to `/usr/share/omarchy`. |
| `snow_black/.git/`, plugin `.git/` | Large pack files; upstream URL and commit are recorded instead. |
| `/etc`, `/boot`, `/usr/share/omarchy` | System-managed, package-owned files. |

### Secret scan result

`manifest/security-scan.txt` scans backed-up files for common credential patterns and
prints **file names only**, never matching values. It found no API keys, tokens, private
keys, or passwords. Four files in the Activity Monitor plugin matched words such as
`passwd` and `password`; these are source/test references to `/etc/passwd`, not secrets.

The scan is a safety net, not proof. Review `manifest/security-scan.txt` and the staged
diff before every push.

### Personal data that is included

Even though secrets are excluded, the private repository contains:

- Hostname and home path in `manifest/system.txt`, `manifest/files.tsv`, and `sources.tsv`.
- Bar clock settings (`birthYear` and `lifeExpectancy`) in `config/omarchy/shell.json`.
- Wallpaper images and personal theme choices.
- Personal keybinding choices.
- Package lists from the source machine.

Keep the GitHub repository private. Do not add SSH keys, browser profiles, API tokens, Git
identity, or shell history later.

## Verification performed

| Test | Result |
| --- | --- |
| SHA-256 verification of the final snapshot | **115/115 files OK** |
| Restore into a sandboxed fake `$HOME` | Created 107 files; no source files changed. |
| Second identical restore | All 107 files reported unchanged; no writes. |
| Conflict restore | Existing file saved under `restore-backup/` before replacement. |
| Corrupted backup test | `verify.sh` failed and `restore.sh` refused before changing anything. |
| Backup source safety | Source configuration was read only. |
| Excluded-content check | No `sudoers`, `defaults/agent`, Git config, home files, or `.git` packs. |

The exact verification command and its output are reproducible with:

```bash
cd ~/Work/omarchy-dots
./scripts/verify.sh
```

## Troubleshooting

### Checksum verification fails

Do not restore. The backup is incomplete or has been modified. Recreate it with
`backup.sh` and verify the new snapshot. If only one file is affected, compare
`manifest/files.tsv` and restore that file from a known-good copy.

### Omarchy version mismatch

`restore.sh` warns when the backup's `omarchy_version` differs from the running system.
Prefer restoring on the same major release, or read the upstream migration notes first.
Hyprland's Lua API and shell plugin schemas can change between releases.

### Hyprland config errors

```bash
hyprctl reload
hyprctl configerrors
```

Fix errors in `~/.config/hypr/*.lua`. `omarchy refresh hyprland` resets to defaults and
backs up current files, but it removes customizations; restore them from this backup
afterward.

### Shell or plugin does not load

```bash
omarchy plugin list
omarchy plugin validate ~/.config/omarchy/plugins/stappmus.activity-monitor
omarchy restart shell
```

Check that `shell.json` is valid JSON. A malformed file can prevent the bar layout from
loading; restore it from the backup and retry.

### Theme colors look wrong after restore

```bash
omarchy theme set solitude
omarchy theme bg set ~/.config/omarchy/backgrounds/solitude/14.jpg
omarchy theme refresh
```

The generated theme lives in `~/.local/state/omarchy/current/`, which is intentionally not
backed up because Omarchy regenerates it.

### Activity Monitor privilege helper

The optional power reader uses a narrow sudoers rule. The backup does not include or
install it. Read the plugin's PKGBUILD/Makefile and install it only if you want that
feature; the basic CPU/memory/GPU display works without it.

### Plugin binary does not run

The plugin includes prebuilt `activity-sampler`, `activity-power-reader`,
`activity-stats`, and `process-signal` binaries. If they do not run on a future
architecture or library set, rebuild them from `activity-sampler.cpp` with the included
Makefile/PKGBUILD.

## Limitations

- This is not a full system restore. Packages, `/etc`, `/boot`, the kernel, firmware, the
  bootloader, and Omarchy itself must be installed separately.
- Personal home-directory files are excluded. Back up `.bashrc`, fonts, and custom scripts
  separately after reviewing them for secrets.
- Wallpaper data is duplicated between `solitude` and `snow_black`; use
  `--no-wallpapers` for a smaller backup.
- Git metadata for the third-party plugin and `snow_black` is excluded. Upstream URLs and
  commits are recorded for fresh installs.
- Configuration formats can change between Omarchy releases. Always dry-run a restore on
  a new major version.
- `stow` is not installed on the source machine and is not used by this repository.

## Optional: GNU Stow

`stow` is **not installed** and the repository is designed around `restore.sh`. If you
choose to use Stow:

```bash
sudo pacman -S stow
```

The `config/` directory mirrors `~/.config`, so stow individual subtrees only:

```bash
cd ~/Work/omarchy-dots
stow --simulate --no-folding -d config -t ~/.config hypr
stow --simulate --no-folding -d config -t ~/.config omarchy/themes/aether
```

Rules for safe use:

- Always run with `--simulate` first.
- Stow one small subtree at a time; never stow the whole `config/` or `omarchy/` tree.
- Do not stow over Omarchy's generated/runtime directories.
- Commit or stash changes before changing symlinks.
- `omarchy refresh` and theme updates may replace symlinked files with real files.
- `restore.sh` is safer for this layout because it copies files and saves conflicts.

## Final notes

- Keep this repository **private**.
- Run `./scripts/verify.sh` before every restore.
- Run `./scripts/backup.sh` before every Omarchy update and keep several snapshots.
- Do not edit `/usr/share/omarchy/`; put changes in `~/.config/`.
- Clone built-in plugins instead of modifying packaged copies.
- If documentation and the installed version disagree, trust the installed version and
  re-read the current manual.
