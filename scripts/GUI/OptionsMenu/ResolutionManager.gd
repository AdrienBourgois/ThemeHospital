
extends Control

onready var game = get_node("/root/Game")
onready var option_button = get_node("OptionButton")
onready var options_menu = get_parent()

export var res = [Vector2(800, 600), Vector2(1024, 720), Vector2(1366, 768)]

func _ready():
	option_button.add_item("800*600", 0)
	option_button.add_item("1024*720", 1)
	option_button.add_item("1366*768", 2)
	set_selected()

func set_selected():
	var game_res = Vector2(game.config.res_x, game.config.res_y)
	var count = 0
	for idx in res:
		if game_res == idx:
			option_button.select(count)
			return
		count += 1

func _on_OptionButton_item_selected( ID ):
	game.config.res_x = res[ID].x
	game.config.res_y = res[ID].y
	options_menu.apply_button.set_disabled(false)