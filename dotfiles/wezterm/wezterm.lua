local wezterm = require("wezterm")

config = wezterm.config_builder()

config = {
    automatically_reload_config = true,
    enable_tab_bar = true,
    window_close_confirmation = "NeverPrompt",
    window_decorations = "RESIZE",
}

return config
