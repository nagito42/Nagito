//get inputs
up_key = keyboard_check_pressed(vk_up);
down_key = keyboard_check_pressed(vk_down);
enter_key = keyboard_check_pressed(vk_enter);

//store number of options in current menu
op_length = array_length(option[menu_level]);

//move through menu
pos += down_key - up_key;
if pos >= op_length {pos = 0};
if pos < 0 {pos = op_length-1};

//use options
if enter_key {
	
	var _sml = menu_level;
	
	switch(menu_level) {
	
		//pause menu
		case 0:
			switch(pos){
				//start game
				case 0: room_goto_next(); break;
				//open settings
				case 1: menu_level = 1; break;
				//quit game
				case 2: game_end(); break;
					}
			break;
		
		//settings menu
		case 1:
			switch(pos) {
				//window size
				case 0:
				 {window_set_fullscreen(!window_get_fullscreen())}
					break;
				//brightness
				case 1:
			
					break;
				//controls
				case 2:
				
			
					break;
				//return
				case 3:
					menu_level = 0;
					break;
				}
			break;
		}
	
	//set position back
	if _sml != menu_level {pos = 0};

	//correct option length
	op_length = array_length(option[menu_level]);

	}