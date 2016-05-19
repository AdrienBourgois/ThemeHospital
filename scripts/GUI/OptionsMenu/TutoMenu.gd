
extends MenuButton

onready var game = get_node("/root/Game")
onready var check_button = get_node("CheckButton")
onready var options_menu = get_node("../../..")

func _ready():
	if game.config.tutorial:
		check_button.set_pressed(true)

func _on_CheckButton_toggled( pressed ):
	game.config.tutorial = pressed
	options_menu.apply_button.set_disabled(false)