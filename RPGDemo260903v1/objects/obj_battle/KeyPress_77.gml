Menu(x+10,y+10,
[
	["Fight", -1, -1, true],
	["Skills", Sub_Menu,
		[[
			["Gunfire", -1, -1, true],
			["Back", Menu_Go_Back, -1, true]
		]],
		true
	],
	["Retreat", -1, -1, true]
]);