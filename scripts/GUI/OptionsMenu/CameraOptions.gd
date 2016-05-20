
extends MenuButton

onready var game = get_node("/root/Game")
onready var check_button = get_node("CheckButton")
onready var options_menu = get_node("../../..")

func _ready():
	if game.config.move_cam_with_mouse:
		check_button.set_pressed(true)

func _on_CheckButton_toggled( pressed ):
	game.config.move_cam_with_mouse = pressed
	options_menu.apply_button.set_disabled(false)