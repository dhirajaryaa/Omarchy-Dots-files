-- Keep only your personal input overrides here.
-- Uncommented settings below replace Omarchy's defaults.

-- Keyboard layout and options.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input

hl.config({
  input = {
    -- Keyboard settings

    -- Caps Lock is completely NORMAL.
    -- Caps Lock = Capital letters ON/OFF.
    -- It is NOT mapped to Super/Windows key.
    kb_options = "",

    -- Change keyboard repeat speed if needed.
    -- repeat_rate = 40,
    -- repeat_delay = 250,

    -- Start with Num Lock enabled.
    -- numlock_by_default = true,

    -- Mouse/trackpad sensitivity.
    -- sensitivity = 0.35,

    -- Turn off mouse acceleration.
    -- accel_profile = "flat",

    touchpad = {
      -- Enable tap-to-click.
      tap_to_click = true,

      -- Natural/inverse scrolling.
      natural_scroll = true,

      -- Two-finger click/tap = RIGHT CLICK.
      --
      -- 1 finger  = Left click
      -- 2 fingers = Right click / Context menu
      -- 3 fingers = Middle click
      clickfinger_behavior = true,

      -- Control touchpad scrolling speed.
      scroll_factor = 0.4,

      -- Keep touchpad enabled while typing.
      disable_while_typing = false,

      -- Three-finger drag.
      -- 1 = enable three-finger drag.
      drag_3fg = 1,
    },
  },
})


-- App-specific touchpad scroll speeds.
-- Uncomment if you want different scrolling speeds for specific apps.

-- o.window("(Alacritty|kitty|foot)", { scroll_touchpad = 1.5 })
-- o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })


-- Enable touchpad gestures for changing workspaces.
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/

-- hl.gesture({
--   fingers = 3,
--   direction = "horizontal",
--   action = "workspace"
-- })


-- Enable touchpad gestures for moving focus.
-- Helpful when using the scrolling layout.

-- hl.gesture({
--   fingers = 3,
--   direction = "left",
--   action = function()
--     hl.dispatch(hl.dsp.focus({ direction = "l" }))
--   end
-- })

-- hl.gesture({
--   fingers = 3,
--   direction = "right",
--   action = function()
--     hl.dispatch(hl.dsp.focus({ direction = "r" }))
--   end
-- })