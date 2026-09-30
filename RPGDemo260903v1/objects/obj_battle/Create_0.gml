instance_deactivate_all(true);

units = [];
turn = 0;
unit_turn_order = [];
unit_render_order = [];

turn_count = 0;
round_count = 0;
battle_wait_time_frames = 30;
battle_wait_time_remaining = 0;
current_user = noone;
current_action = -1;
current_targets = noone;

//Create Enemies
for (var i = 0; i < array_length(enemies); i++)
{
	enemy_units[i] = instance_create_depth(x + 210 + (i*20), y + 60 + (i*40), depth - 10, obj_battle_unit_enemy, enemies[i]);
	array_push(units, enemy_units[i]);
}

//Create Party
for (var i = 0; i < array_length(global.party); i++)
{
	party_units[i] = instance_create_depth(x + 50 + (i*10), y + 60 + (i*20), depth - 10, obj_battle_unit_PC, global.party[i]);
	array_push(units, party_units[i]);
}

//Shuffle Turn Order
unit_turn_order = array_shuffle(units);

//Get Render Order
Refresh_Render_order = function()
{
	unit_render_order = [];
	array_copy(unit_render_order, 0, units, 0, array_length(units));
	array_sort(unit_render_order, function(_1,_2)
	{
		return _1.y - _2.y
	});
}
Refresh_Render_order();

//Battle State
function battle_state_select_action()
{
	if (!instance_exists(obj_menus))
	{
		//Get Current Unit
		var _unit = unit_turn_order[turn];
	
		//Is The Unit Dead Or Unable To Act?
		if (!instance_exists(_unit)) || (_unit.hp <= 0)
		{
			battle_state = battle_state_victory_check;
			exit;
		}
	
		//Select An Action To Perform
		//begin_action(_unit.id, global.actionlibrary.attack, _unit.id);
	
		//If Unit is Player Controlled
		if (_unit.object_index == obj_battle_unit_PC)
		{
			//Compile Action Menu
			var _menu_options = [];
			var _submenus = {};
			
			var _action_list = _unit.actions;
			
			for (var i = 0; i < array_length(_action_list); i++)
			{
				var _action = _action_list[i];
				var _available = true;
				var _name_and_count = _action.name;
				if (_action.sub_menu == -1)
				{
					array_push(_menu_options, [_name_and_count, menu_select_action, [_unit, _action], _available]);
				}
				else
				{
					//Create or Add to Submeny
					if (is_undefined(_submenus[$ _action.sub_menu]))
					{
						variable_struct_set(_submenus, _action.sub_menu, [[_name_and_count, menu_select_action, [_unit, _action], _available]]);
					}
					else
					{
						array_push(_submenus[$ _action.sub_menu], [_name_and_count, menu_select_action, [_unit, _action], _available]);
					}
				}
				
				var _sub_menus_array = variable_struct_get_names(_submenus);
				for (var i = 0; i < array_length(_sub_menus_array); i++)
				{
					//sort submenu if needed
					//Top Menu here
					
					//add back option
					array_push(_submenus[$ _sub_menus_array[i]], ["Back", Menu_Go_Back, -1, true]);
					//add submenu to main menu
					array_push(_menu_options, [_sub_menus_array[i], Sub_Menu, [_submenus[$ _sub_menus_array[i]]], true]);
				}
			}
			
			Menu(x + 10, y + 110, _menu_options, , 74, 60);
		}
		else
		{
			//If Unit Is AI Controlled
			var _enemy_action = _unit.AIscript();
			if (_enemy_action != -1) begin_action(_unit.id, _enemy_action[0], _enemy_action[1]);
		}
	}
}

function begin_action(_user, _action, _targets)
{
	current_user = _user;
	current_action = _action;
	current_targets = _targets;
	if (!is_array(current_targets)) current_targets = [current_targets];
	battle_wait_time_remaining = battle_wait_time_frames;
	with (_user)
	{
		acting = true;
		//Play User Animation if it is Defined for that Action, and that User
		if (!is_undefined(_action[$ "user_animation"])) && (!is_undefined(_user.sprites[$ _action.user_animation]))
		{
			sprite_index = sprites[$ _action.user_animation];
			image_index = 0;
		}
	}
	battle_state = battle_state_perform_action;
}

function battle_state_perform_action()
{
	//If Animation etc is still Playing
	if (current_user.acting)
	{
		//When It Ends, Perform Action Effect if it Exists
		if (current_user.image_index >= current_user.image_number -1)
		{
			with (current_user)
			{
				sprite_index = sprites.idle;
				image_index = 0;
				acting = false;
			}
			
			if (variable_struct_exists(current_action, "effect_sprite"))
			{
				if (current_action.effect_target == MODE.ALWAYS) || ( (current_action.effect_target == MODE.VARIES) && (array_length(current_targets) <= 1) )
				{
					for (var i = 0; i < array_length(current_targets); i++)
					{
						instance_create_depth(current_targets[i].x, current_targets[i].y, current_targets[i].depth - 1, obj_battle_effect, {sprite_index : current_action.effect_sprite});
					}
				}
				else //Play at (0,0)
				{
					var _effectsprite = current_action.effect_sprite
					if (variable_struct_exists(current_action, "effect_sprite_no_target")) _effectsprite = current_action.effect_sprite_no_target;
					instance_create_depth(x,y,depth - 100, obj_battle_effect, {sprite_index : _effectsprite});
				}
			
			}
			current_action.func(current_user, current_targets);
		}
		
	}
	else //Wait for Delay and then End Turn
	{
		if (!instance_exists(obj_battle_effect))
		{
			battle_wait_time_remaining--
			if (battle_wait_time_remaining == 0)
			{
				battle_state = battle_state_victory_check;
			}
		}
	}
}

function battle_state_victory_check()
{
	battle_state = battle_state_turn_progression;
}

function battle_state_turn_progression()
{
	turn_count++;
	turn++;
	//Loop Turns
	if (turn > array_length(unit_turn_order) - 1)
	{
		turn = 0;
		round_count++;
	}
	battle_state = battle_state_select_action;
}

battle_state = battle_state_select_action;







