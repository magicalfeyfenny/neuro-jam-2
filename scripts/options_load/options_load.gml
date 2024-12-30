function options_load() {
    window_set_fullscreen(data.options.fullscreen);
    with obj_camera {
        if window_get_fullscreen() == false {
            window_scale = 2;
            window_set_size(global.view_w*window_scale,global.view_h*window_scale);
            window_center();
        }
    }
    display_reset(0, data.options.vsync );
    audio_group_set_gain( audiogroup_music, (data.options.volume_music / 10), 0 );
    audio_group_set_gain( audiogroup_sounds, (data.options.volume_sound / 10), 0 );
}