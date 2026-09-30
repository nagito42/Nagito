draw_sprite_stretched(spr_menu, 0, x, y, width_full, height_full);
draw_set_color(c_white);
draw_set_font(global.font_main);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
show_debug_message("My position is: " + string(x) + ", " + string(y));

var _desc = !(description == -1);
var _scroll_push = max(0, hover - (visible_options_max - 1 ));

for (l = 0; l < (visible_options_max + _desc); l++)
{
	if (l >= array_length(options)) break;
	draw_set_colour(c_white);
	if (l == 0) && (_desc)
	{
		draw_text(x + xmargin, y + ymargin, description);
	}
	else
	{
		var _options_to_show = l - _desc + _scroll_push;
		var _str = options[_options_to_show][0];
		if (hover == _options_to_show - _desc)
		{
			draw_set_color(c_yellow);
		}
		if (options[_options_to_show][3] == false) draw_set_color (c_grey);
		draw_text(x + xmargin, y + ymargin + l * height_line, _str);
	}
}

draw_sprite(spr_point, 0, x + xmargin + 8, y + ymargin + ((hover - _scroll_push) * height_line) + 7);
if (visible_options_max < array_length(options)) && (hover < array_length(options) - 1)
{
	draw_sprite(spr_down_arrow, 0, x + width_full * 0.5, y + height_full - 7);
}






