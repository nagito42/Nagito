event_inherited()
if (hp <= 0)
{
	sprite_index = spr_player_dead
}
else
{
	if (sprite_index == spr_player_dead) sprite_index = spr_player_idle
}