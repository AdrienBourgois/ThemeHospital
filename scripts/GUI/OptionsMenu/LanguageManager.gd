
extends Control

onready var game = get_node("/root/Game")
onready var option_button = get_node("Language_option")
onready var options_menu = get_parent()

var language = ["fr", "en"]

func _ready():
	set_selected()

func set_selected():
	var count = 0
	for idx in language:
		if idx == game.config.langage:
			option_button.select(count)
		count += 1

func _on_Language_option_item_selected(ID):
	game.config.langage = language[ID]
	options_menu.apply_button.set_disabled(false)