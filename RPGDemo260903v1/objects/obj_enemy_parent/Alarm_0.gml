//Player detection
if (instance_exists(obj_player) && distance_to_object(obj_player) < distance_to_player)
	{
	target_x = obj_player.x;
	target_y = obj_player.y;
	alarm[0] = 30;
	}
else
	{
	target_x = random_range(xstart - 50, xstart + 50);
	target_y = random_range(ystart - 50, ystart + 50);
	}

alarm[0] = 60;