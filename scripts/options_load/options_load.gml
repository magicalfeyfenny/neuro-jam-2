function options_load() {
    window_set_fullscreen(data.options.fullscreen);
    display_reset(0, data.options.vsync );
}