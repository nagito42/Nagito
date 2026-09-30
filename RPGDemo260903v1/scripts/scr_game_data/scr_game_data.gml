//Action Library
global.actionlibrary = 
{
	attack :
	{
		name : "Attack",
		description : "{0} attacks!",
		sub_menu : -1,
		targetr_equired : true,
		target_enemy_default : true,
		target_all : MODE.NEVER,
		user_animation : "attack",
		effect_sprite : spr_player_idle,
		effect_target : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			var _damage = ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
			battle_change_hp(_targets[0], -_damage, 0);
		}
	}
}		

enum MODE
{
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2
}


//Party Data
global.party = 
[
	{
		name: "Maxime",
		hp: 89,
		hpmax: 89,
		tp: 10,
		tpmax: 10,
		strength: 6,
		sprites : { idle: spr_player_idle, attack: spr_player_idle, defend: spr_player_idle, down: spr_player_idle},
		actions : [],
	}
]

//Enemy Data
global.enemies =
{
	placeholder:
	{
		name: "Enemy",
		hp: 30,
		hpmax: 30,
		tp:	0,
		tpmax: 0,
		strength: 5,
		sprites : {idle: spr_enemy_placeholder, attack: spr_enemy_placeholder},
		actions : [global.actionlibrary.attack],
		xpvalue : 15,
		AIscript : function()
			{
				//Attack Random Party Member
				var _action = actions[0];
				var _possible_targets = array_filter(obj_battle.party_units, function(_unit, _index)
				{
					return (_unit.hp > 0);
				});
				var _target = _possible_targets[irandom(array_length(_possible_targets)-1)];
				return [_action,_target];
			},
	}
}