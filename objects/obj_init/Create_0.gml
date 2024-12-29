randomize();
init_data();
dialogue_load();

globalvar file_loading;
file_loading = false;

audio_group_load( audiogroup_music );
audio_group_load( audiogroup_sounds );

alarm[0] = 1;

