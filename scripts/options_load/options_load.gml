function options_load() {
    window_set_fullscreen(data.options.fullscreen);
    display_reset(0, data.options.vsync );
    audio_group_set_gain( audiogroup_music, (data.options.volume_music / 10), 0 );
    audio_group_set_gain( audiogroup_sounds, (data.options.volume_sound / 10), 0 );
}