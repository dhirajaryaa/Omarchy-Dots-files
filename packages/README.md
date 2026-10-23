# Packages

These files record the package set of the source machine. They are not a full
system restore.

- `pacman-explicit.txt` — explicitly installed packages with versions.
- `pacman-explicit-names.txt` — names only, suitable for reinstall.
- `pacman-foreign.txt` / `pacman-foreign-names.txt` — AUR/foreign packages.

On a fresh Omarchy install, install only the packages that are missing:

```bash
comm -23 <(sort pacman-explicit-names.txt) <(pacman -Qq | sort) | sudo pacman -S --needed -
```

Then handle foreign packages (review first; some may now be in the repos):

```bash
comm -23 <(sort pacman-foreign-names.txt) <(pacman -Qq | sort)
# review the list, then:
yay -S --needed <package> ...
```

Do not blindly reinstall `base`, kernel, firmware, bootloader, or Omarchy
packages. Omarchy itself should be installed by its own installer.
