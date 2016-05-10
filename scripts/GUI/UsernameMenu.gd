
extends Control

onready var game = get_node("/root/Game")
onready var loader = get_node("/root/Load")
onready var line_edit = get_node("Panel/LineEdit")

func _ready():
	loader.loadInit()
	set_process_input(true)
	pass

func _input(event):
	if event.is_action("enter") && checkIfUsernameCorrect():
		game.username = line_edit.get_text()
		get_tree().get_current_scene().queue_free()
		get_tree().change_scene("res://scenes/GUI/MainMenu.scn")

func checkIfUsernameCorrect():
	var username = line_edit.get_text()
	if username.empty() || username.begins_with(' ') || username.ends_with(' '):
		return false
	else:
		return true