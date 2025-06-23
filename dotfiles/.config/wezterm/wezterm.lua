local wezterm = require("wezterm")

config = wezterm.config_builder()

wezterm.plugin
    .require('https://github.com/yriveiro/wezterm-status')
    .apply_to_config(config)

config = {
    automatically_reload_config = true,
    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = true,
    window_close_confirmation = "NeverPrompt",
    window_decorations = "RESIZE",
    default_cursor_style = "BlinkingBar",
    color_scheme = "Nord (Gogh)",
    font = wezterm.font 'FiraCode Nerd Font',
    font_size = 12.0,
    window_background_opacity = 0.6,
    macos_window_background_blur = 20,
    window_padding = {
        left = 3,
        right = 3,
        top = 0,
        bottom = 0,
    },
}

return config
