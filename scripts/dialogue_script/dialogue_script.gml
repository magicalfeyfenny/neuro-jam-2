/// Place an obj_dialogue in the room, along with an object similar to obj_cutscene_test that starts a timeline similar to tml_cutscene_test
/// When text dialogue would appear on the screen, use the timeline to start dialogue, pause the timeline, and enter the text
/// The object restarts the timeline when the dialogue scene is over
/// When text is no longer on the screen, for example, characters taking actions during the scene, handle it through timeline events

function dialogue_load() {
    enum SCENES {
        NO_SCENE = -1,
        TEST_SCENE = 0,
    }
    enum DISPLAY {
        ADV = 0,
        FULLSCREEN = 1,
        NOTEXT = 2,
    }
    enum TEXT {
        LOADING = -1,
        TYPING = 0,
        READY = 1,
    }
    globalvar frames_queue;
    frames_queue = ds_queue_create();
    globalvar dialogue;
    dialogue = {
        //scenes are structs in the array 'scene'
        scene : [ {
            scene_name : "test scene do not watch",
            //individual frames of a scene are structs in the array 'frames' within the scene array
            frames : [ {   
                name : "Neuro?",
                text :  "Don't worry, silly!\n" + 
                        "We're much too cute to be in danger!",
                display : DISPLAY.ADV,
                sprite : [ spr_talk_neuro, spr_talk_neuro, spr_talk_neuro, spr_talk_neuro ],
                sprite_pos_x : [ 95, 56, 303, 529 ],
                sprite_pos_y : [ 130, 193, 300, 59 ],
                audio : -1,
                bg : -1,
                mus : mus_11,
            } ],
        } ],
    }
    globalvar cutscene_mode;
    cutscene_mode = false;
    globalvar cutscene_number;
    cutscene_number = SCENES.TEST_SCENE;
    globalvar dialogue_mode;
    dialogue_mode = false;
}

function dialogue_start( _scene ) {
    if (!instance_exists(obj_dialogue) ) {
        show_debug_message( "Cannot start dialogue without an obj_dialogue instance!" );
        return -1;
    }

    //clear the frames queue
    ds_queue_clear( frames_queue );
    
    //load the cutscene frames into the queue
    for ( var i = 0; i < array_length( dialogue.scene[_scene].frames ); i++ ) {
        ds_queue_enqueue( frames_queue, dialogue.scene[_scene].frames[i] );
    }
    
    dialogue_mode = true;
    with (obj_dialogue) {
        event_perform( ev_create, 0 );
    }
    
}