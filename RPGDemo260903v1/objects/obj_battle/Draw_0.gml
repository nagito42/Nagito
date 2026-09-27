//Draw Background
draw_sprite(battlebackground, 0, x, y);

//Draw Units in Depth Order
var unit_current_turn = unit_turn_order[turn].id;
for (var i = 0; i < array_length(unit_render_order); i++)
{
	with (unit_render_order[i])
	{
		draw_self();
	}
}

//Draw UI Boxes
draw_sprite_stretched(spr_menu, 0, x + 10, y + 150, 90, 60);
draw_sprite_stretched(spr_menu, 0, x + 110, y + 150, 168, 60);

//Positions
#macro COLUMN_ENEMY 15
#macro COLUMN_NAME 115
#macro COLUMN_HP 180
#macro COLUMN_TP 230

//Draw Headings
draw_set_font(global.font_main);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(x + COLUMN_ENEMY, y + 153, "ENEMIES");
draw_text(x + COLUMN_NAME, y + 153, "NAME");
draw_text(x + COLUMN_HP, y + 153, "HP");
draw_text(x + COLUMN_TP, y + 153, "TP");

//Draw Enemy Names
draw_set_font(global.font_main);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
var _drawnlimit = 4;
var _drawn = 0;
for (var i  = 0; (i < array_length(enemy_units)) && (_drawn < _drawnlimit); i++)
{
	var _char = enemy_units[i];
	if (_char.hp > 0)
	{
		_drawn++;
		draw_set_color(c_white)
		if (_char.id == unit_current_turn) draw_set_color(c_yellow);
		draw_text(x + COLUMN_ENEMY, y + 163 + (i*10), _char.name);
	}
}

//Draw Party Info
for (var i = 0; i < array_length(party_units); i++)
{
	draw_set_halign(fa_left);
	draw_set_color(c_white);
	var _char = party_units[i];
	if (_char.id == unit_current_turn) draw_set_color(c_yellow);
	if (_char.hp <= 0) draw_set_color(c_red);
	draw_text(x + COLUMN_NAME, y + 163 + (i*10), _char.name);
	draw_set_halign(fa_right);
	
	draw_set_color(c_white);
	if (_char.hp < (_char.hpmax * 0.5)) draw_set_color(c_orange);
	if (_char.hp <= 0) draw_set_color(c_red);
	draw_text(x + COLUMN_HP + 24, y + 163 + (i*10), string(_char.hp) + "/" + string(_char.hpmax));
	
	draw_set_color(c_white);
	if (_char.tp < (_char.tpmax *0.5)) draw_set_color(c_orange);
	if (_char.tp <= 0) draw_set_color(c_red);
	draw_text(x + COLUMN_TP + 22, y + 163 + (i*10), string(_char.tp) + "/" + string(_char.tpmax));
}














