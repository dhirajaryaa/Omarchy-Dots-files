-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")


-- My custom bindings
-- Unbind Omarchy defaults before replacing them.


-- ============================================================
-- Microphone
-- ============================================================

hl.unbind("SUPER + M")
o.bind(
  "SUPER + M",
  "Microphone toggle",
  "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
)


-- ============================================================
-- Applications
-- ============================================================


hl.unbind("SUPER + SHIFT + V")
o.bind(
  "SUPER + SHIFT + V",
  "VSCode",
  "code"
)

-- hl.unbind("SUPER + SHIFT + ALT + A")
-- o.bind(
--   "SUPER + SHIFT + ALT + A",
--   "Claude Desktop",
--   "claude-desktop"
-- )


-- ============================================================
-- Web Apps
-- ============================================================

hl.unbind("SUPER + SHIFT + A")
o.bind(
  "SUPER + SHIFT + A",
  "ChatGPT",
  'omarchy-launch-webapp "https://chatgpt.com"'
)

hl.unbind("SUPER + SHIFT + ALT + A")
o.bind(
  "SUPER + SHIFT + ALT + A",
  "Claude",
  'omarchy-launch-webapp "https://claude.ai/new"'
)

hl.unbind("SUPER + SHIFT + E")
o.bind(
  "SUPER + SHIFT + E",
  "Gmail",
  'omarchy-launch-webapp "https://mail.google.com/mail/u/0/"'
)

hl.unbind("SUPER + SHIFT + X")
o.bind(
  "SUPER + SHIFT + X",
  "X",
  'omarchy-launch-webapp "https://x.com/"'
)

hl.unbind("SUPER + SHIFT + G")
o.bind(
  "SUPER + SHIFT + G",
  "GitHub",
  'omarchy-launch-webapp "https://github.com/"'
)

hl.unbind("SUPER + SHIFT + L")
o.bind(
  "SUPER + SHIFT + L",
  "LinkedIn",
  'omarchy-launch-webapp "https://linkedin.com/"'
)


-- Swap Omarchy menu bindings back to the old behavior

-- Remove current defaults
-- hl.unbind("SUPER + SPACE")
-- hl.unbind("SUPER + ALT + SPACE")

-- Super + Space → App menu
-- o.bind(
--   "SUPER + SPACE",
--   "App menu",
--   "omarchy-launcher"
-- )

-- Super + Alt + Space → Omarchy menu
-- o.bind(
--   "SUPER + ALT + SPACE",
--   "Omarchy menu",
--   "omarchy-menu toggle root"
-- )