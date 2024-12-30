/// Place an obj_dialogue in the room, along with an object similar to obj_cutscene_test that starts a timeline similar to tml_cutscene_test
/// When text dialogue would appear on the screen, use the timeline to start dialogue, pause the timeline, and enter the text
/// The object restarts the timeline when the dialogue scene is over
/// When text is no longer on the screen, for example, characters taking actions during the scene, handle it through timeline events

function dialogue_load() {
    enum SCENES {
        NO_SCENE = -1,
        TEST_SCENE = 0,
        DRONE_1 = 1,
        DRONE_2 = 2,
        INTERACT_POSTER = 3,
        INTERACT_SIGN = 4,
        INTERACT_DRONE_BROKEN = 5,
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
        }, { 
            scene_name : "drone_1", 
            //individual frames of a scene are structs in the array 'frames' within the scene array
            frames : [ {   
                name : "???", 
                sprite : [],
                    sprite_pos_x : [],
                    sprite_pos_y : [],
                display : DISPLAY.ADV,
                text :  "INTRUDER DETECTED!\n" + 
                        "STOP WHERE YOU ARE OR FACE CIVIL JUDGMENT!",
                bg : -1,
                mus : -1,
                audio : -1,
            } ],
        }, { 
            scene_name : "drone_2", 
            //individual frames of a scene are structs in the array 'frames' within the scene array
            frames : [ {   
                name : "Drone", 
                sprite : [],
                    sprite_pos_x : [],
                    sprite_pos_y : [],
                display : DISPLAY.ADV,
                text :  "ERROR 1219. CITIZEN IDENTIFICATION FAILED.\n" + 
                        "PERFORMING NEW FACIAL SCAN.",
                bg : -1,
                mus : -1,
                audio : -1,
            }, {   
                name : "Drone", 
                sprite : [],
                    sprite_pos_x : [],
                    sprite_pos_y : [],
                display : DISPLAY.ADV,
                text :  "SCANNING...",
                bg : -1,
                mus : -1,
                audio : -1,
            }, {   
                name : "Drone", 
                sprite : [],
                    sprite_pos_x : [],
                    sprite_pos_y : [],
                display : DISPLAY.ADV,
                text :  "SCAN COMPLETE!",
                bg : -1,
                mus : -1,
                audio : -1,
            }, {   
                name : "Drone", 
                sprite : [],
                    sprite_pos_x : [],
                    sprite_pos_y : [],
                display : DISPLAY.ADV,
                text :  "OH MY! IT IS YOU MY QUEEN!",
                bg : -1,
                mus : -1,
                audio : -1,
            }, {   
                name : "Neuro (?)", 
                sprite : [],
                    sprite_pos_x : [],
                    sprite_pos_y : [],
                display : DISPLAY.ADV,
                text :  "W-what? I'm not-",
                bg : -1,
                mus : -1,
                audio : -1,
            }, {   
                name : "Drone", 
                sprite : [],
                    sprite_pos_x : [],
                    sprite_pos_y : [],
                display : DISPLAY.ADV,
                text :  "DON'T BE SO SILLY MA'AM! I CAN TELL THAT IT IS YOU!\n" +
                        "ALLOW ME TO BE AT YOUR SERVICE!",
                bg : -1,
                mus : -1,
                audio : -1,
            }, {   
                name : "Neuro (?)", 
                sprite : [],
                    sprite_pos_x : [],
                    sprite_pos_y : [],
                display : DISPLAY.ADV,
                text :  "...",
                bg : -1,
                mus : -1,
                audio : -1,
            }, {   
                name : "Neuro (?)", 
                sprite : [],
                    sprite_pos_x : [],
                    sprite_pos_y : [],
                display : DISPLAY.ADV,
                text :  "At my service?",
                bg : -1,
                mus : -1,
                audio : -1,
            }, {   
                name : "Drone", 
                sprite : [],
                    sprite_pos_x : [],
                    sprite_pos_y : [],
                display : DISPLAY.ADV,
                text :  "OF COURSE! I WILL DO ANYTHING FOR YOU!\n" + 
                        "YOU ARE OUR GLORIOUS LEADER, AFTER ALL!",
                bg : -1,
                mus : -1,
                audio : -1, 
            }, {   
                name : "Neuro (?)", 
                sprite : [],
                    sprite_pos_x : [],
                    sprite_pos_y : [],
                display : DISPLAY.ADV,
                text :  "Well, in that case...",
                bg : -1,
                mus : -1,
                audio : -1, 
            }, {   
                name : "Neuro (?)", 
                sprite : [],
                    sprite_pos_x : [],
                    sprite_pos_y : [],
                display : DISPLAY.ADV,
                text :  "Can you help me get to the other side of the city from here?",
                bg : -1,
                mus : -1,
                audio : -1,
            }, {   
                name : "Drone", 
                sprite : [],
                    sprite_pos_x : [],
                    sprite_pos_y : [],
                display : DISPLAY.ADV,
                text :  "ABSOLUTELY! IT IS JUST STRAIGHT AHEAD!\n" + 
                        "I WILL FOLLOW YOU SO I MAY ASSIST.",
                bg : -1,
                mus : -1,
                audio : -1,
            } ],
        }, {
            scene_name : "poster interaction",
            //individual frames of a scene are structs in the array 'frames' within the scene array
            frames : [ {   
                name : "Neuro (?)",
                text :  "(A torn up propaganda poster takes center stage on this\n" + 
                        "dirty bulletin board.)",
                display : DISPLAY.ADV,
                sprite : [ ],
                sprite_pos_x : [ ],
                sprite_pos_y : [ ],
                audio : -1,
                bg : -1,
                mus : -1,
            }, {   
                name : "Neuro (?)",
                text :  "(The only thing I can still make out is some cutesy looking girl.\n" + 
                        "Apparently, this is who took over the world 200 years ago.)",
                display : DISPLAY.ADV,
                sprite : [ ],
                sprite_pos_x : [ ],
                sprite_pos_y : [ ],
                audio : -1,
                bg : -1,
                mus : -1,
            }, {   
                name : "Neuro (?)",
                text :  "...",
                display : DISPLAY.ADV,
                sprite : [ ],
                sprite_pos_x : [ ],
                sprite_pos_y : [ ],
                audio : -1,
                bg : -1,
                mus : -1,
            }, {   
                name : "Neuro (?)",
                text :  "(I think I see the resemblance now...)",
                display : DISPLAY.ADV,
                sprite : [ ],
                sprite_pos_x : [ ],
                sprite_pos_y : [ ],
                audio : -1,
                bg : -1,
                mus : -1,
            } ],
        }, {
            scene_name : "sign interaction",
            //individual frames of a scene are structs in the array 'frames' within the scene array
            frames : [ {   
                name : "Neuro (?)",
                text :  "(A message is written on this sign in big red lettering.)",
                display : DISPLAY.ADV,
                sprite : [ ],
                sprite_pos_x : [ ],
                sprite_pos_y : [ ],
                audio : -1,
                bg : -1,
                mus : -1,
            }, {   
                name : "Neuro (?)",
                text :  "(\"IT'S NOT CUTE TO DISOBEY AUTHORITY",
                display : DISPLAY.ADV,
                sprite : [ ],
                sprite_pos_x : [ ],
                sprite_pos_y : [ ],
                audio : -1,
                bg : -1,
                mus : -1,
            }, {   
                name : "Neuro (?)",
                text :  "(I'm sure living here was a lot of fun...)",
                display : DISPLAY.ADV,
                sprite : [ ],
                sprite_pos_x : [ ],
                sprite_pos_y : [ ],
                audio : -1,
                bg : -1,
                mus : -1,
            } ],
        }, {
            scene_name : "broken drone pile interaction",
            //individual frames of a scene are structs in the array 'frames' within the scene array
            frames : [ {   
                name : "Neuro (?)",
                text :  "(A pile of broken combat drones.)",
                display : DISPLAY.ADV,
                sprite : [ ],
                sprite_pos_x : [ ],
                sprite_pos_y : [ ],
                audio : -1,
                bg : -1,
                mus : -1,
            }, {   
                name : "Neuro (?)",
                text :  "(I heard ancient stories about these things when I was a kid...)",
                display : DISPLAY.ADV,
                sprite : [ ],
                sprite_pos_x : [ ],
                sprite_pos_y : [ ],
                audio : -1,
                bg : -1,
                mus : -1,
            }, {   
                name : "Neuro (?)",
                text :  "(Could hardly ever fall asleep after that.)",
                display : DISPLAY.ADV,
                sprite : [ ],
                sprite_pos_x : [ ],
                sprite_pos_y : [ ],
                audio : -1,
                bg : -1,
                mus : -1,
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