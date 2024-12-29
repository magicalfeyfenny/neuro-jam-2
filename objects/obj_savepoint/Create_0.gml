tag = -1;
name = "";
save_allowed = false;
save_attempting = false;
saved_display = -1;

/// Save points added to the room can have their properties edited in obj_init's save_points struct
/// The arrays expand to fit any save points added to the room, but will have default properties
/// To make sure a specific save point links to a specific array entry, make sure that the listed position
/// is near the save point.
/// Extra save points listed will be generated, but will prioritize linking to an existing obj_savepoint

/// If the player's last save file was in the current room and the file_loading globalvar flag is set,
/// the player will be teleported to the corresponding save point, and the flag will be unset. 
/// If either of those are not true, the player will remain in their normal position