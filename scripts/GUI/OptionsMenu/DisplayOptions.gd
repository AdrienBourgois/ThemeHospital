
extends MenuButton

onready var game = get_node("/root/Game")
onready var resolution_button = get_node("./ResolutionOptionButton")
onready var options_menu = get_node("../..")
onready var fullscreen_button = get_node("./FullscreenCheckButton")

export var res = [Vector2(800, 600), Vector2(1024, 720), Vector2(1366, 768)]

func _ready():
	if ( game.config.fullscreen ):
		fullscreen_button.set_pressed(true)
	
	set_selected()

func set_selected():
	var game_res = Vector2(game.config.res_x, game.config.res_y)
	var count = 0
	for idx in res:
		if game_res == idx:
			resolution_button.select(count)
			return
		count += 1

func _on_ResolutionOptionButton_item_selected( ID ):
	game.config.res_x = res[ID].x
	game.config.res_y = res[ID].y
	options_menu.apply_button.set_disabled(false)

func _on_FullscreenCheckButton_toggled( pressed ):
	game.config.fullscreen = pressed
	options_menu.apply_button.set_disabled(false)



