target_x = x;
target_y = y;

xspd = 0;
yspd = 0;

alarm[0] = 120;

//collisions
if place_meeting( x + xspd, y, obj_wall ) == true
	{
	xspd = 0;
	}
if place_meeting( x, y + yspd, obj_wall ) == true
	{
	yspd = 0;
	}

