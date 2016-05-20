
extends Control

onready var game = get_node("/root/Game")
onready var loader = get_node("/root/Load")
onready var saver = get_node("/root/Save")
onready var line_edit = get_node("Panel/UsernameBox/UsernameLineEdit")

func _ready():
	loader.loadInit()
	line_edit.set_text(game.config.username)
	set_process_input(true)

func _input(event):
	if event.is_action("enter") && checkIfUsernameCorrect():
		game.username = line_edit.get_text()
		game.config.username = game.username
		saver.setInit()
		get_tree().get_current_scene().queue_free()
		get_tree().change_scene("res://scenes/GUI/MainMenu.scn")

func checkIfUsernameCorrect():
	var username = line_edit.get_text()
	if username.empty() || username.begins_with(' ') || username.ends_with(' '):
		return false
	else:
		return true