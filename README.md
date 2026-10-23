# Omarchy Dotfiles Backup

Private backup of my **Hyprland + Omarchy 4.0.6** configuration from `lapi`
(2026-10-23).

> Keep this repository **private**. It contains my hostname, home path, bar settings,
> wallpapers, and keybindings. It does **not** contain SSH/GPG keys, API tokens, browser
> profiles, Git identity, or AI-agent configuration.

## What is inside

Only `~/.config/hypr` and `~/.config/omarchy` are backed up:

| Content | Files |
| --- | ---: |
| Hyprland Lua config | 9 |
| Shell settings (`shell.json`, `shell.toml`) | 2 |
| Menu extension + theme hook | 2 |
| Themes (`aether`, `snow_black`) | 47 |
| Activity Monitor plugin | 29 |
| Wallpapers + branding | 18 |
| **Total** | **107** |

- **Verification:** 115/115 SHA-256 checksums OK.
- **Full file list:** `manifest/files.tsv`.
- **Package metadata:** `packages/` (not a reinstall script).
- **Excluded:** all other app configs, home files, SSH/GPG keys, GitHub auth, browser
  data, caches, plugin/theme `.git` packs, and the plugin's sudoers rule.

## My keybindings

| Shortcut | Action |
| --- | --- |
| `SUPER + M` | Microphone mute toggle |
| `SUPER + SHIFT + V` | VS Code |
| `SUPER + SHIFT + A` | ChatGPT |
| `SUPER + SHIFT + ALT + A` | Claude |
| `SUPER + SHIFT + E` | Gmail |
| `SUPER + SHIFT + X` | X |
| `SUPER + SHIFT + G` | GitHub |
| `SUPER + SHIFT + L` | LinkedIn |

Defined in `config/hypr/bindings.lua`. All **227** active bindings are listed in
[`KEYBINDINGS.md`](KEYBINDINGS.md) and `manifest/keybindings.txt`.

## Restore

```bash
cd ~/Work/omarchy-dots

./scripts/verify.sh
./scripts/restore.sh --list
./scripts/restore.sh --category all --dry-run
./scripts/restore.sh --category all --yes
```

Categories: `hypr`, `shell`, `extensions`, `hooks`, `themes`, `plugins`, `wallpapers`,
`branding`, `all`.

Replaced files are saved under
`~/.local/state/omarchy-dotfiles/restore-backup/<timestamp>/` before being overwritten.
The script refuses to restore if any checksum fails.

After restoring:

```bash
hyprctl reload && hyprctl configerrors
omarchy restart shell
omarchy theme set solitude
omarchy theme bg set ~/.config/omarchy/backgrounds/solitude/14.jpg
```

## Make a new backup

```bash
./scripts/backup.sh
```

Default output: `~/Backups/omarchy-dotfiles/<timestamp>/`. It refuses to write into a
non-empty directory. Use `--no-wallpapers` to skip the ~90 MB wallpaper trees.

## Git

```bash
git status --short
git add -A
git commit -m "Update Omarchy dotfiles backup"
git push -u origin main
```

Remote: `git@github.com:dhirajaryaa/Omarchy-Dots-files.git` (SSH, private).

## Notes

- Omarchy 4 uses Lua configs (`hyprland.lua`), not `hyprland.conf`.
- Never edit `/usr/share/omarchy/`; put changes in `~/.config/`.
- Plugin/theme `.git` directories and the plugin's sudoers file are excluded. Upstream
  URLs and commits are recorded in `manifest/git-repos.tsv`.
- The secret scan found no keys or tokens. Personal hostname, paths, bar settings, and
  wallpapers remain, so keep this repository private.
