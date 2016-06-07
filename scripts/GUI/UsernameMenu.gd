extends Control

onready var game = get_node("/root/Game")
onready var loader = get_node("/root/Load")
onready var saver = get_node("/root/Save")
onready var label = get_node("Panel/UsernameBox/UsernameLabel")
onready var line_edit = get_node("Panel/UsernameBox/UsernameLineEdit")

onready var empty_label = get_node("Panel/UsernameBox/EmptyLabel")
onready var begin_label = get_node("Panel/UsernameBox/BeginLabel")
onready var end_label = get_node("Panel/UsernameBox/EndLabel")

onready var timer = get_node("Panel/UsernameBox/Timer")

var error_username = []

func _ready():
	loader.loadInit()
	label.set_text("TXT_ENTERNAME")
	line_edit.set_text(game.config.username)
	set_process_input(true)

func _input(event):
	if event.is_action("enter") && checkIfUsernameCorrect():
		game.username = line_edit.get_text()
		game.config.username = game.username
		saver.setInit()
		get_tree().get_current_scene().queue_free()
		get_tree().change_scene("res://scenes/GUI/MainMenu.scn")
	else:
		timer.start()

func checkIfUsernameCorrect():
	var username = line_edit.get_text()
	var is_correct = true
	
	error_username.clear()
	
	if username.empty():
		is_correct = false
		empty_label.show()
		error_username.push_back(empty_label)
	else:
		empty_label.hide()
	
	if username.begins_with(' '):
		is_correct = false
		begin_label.show()
		error_username.push_back(begin_label)
	else:
		begin_label.hide()
		
	if username.ends_with(' '):
		is_correct = false
		end_label.show()
		error_username.push_back(end_label)
	else:
		end_label.hide()
	
		return is_correct

func _on_Timer_timeout():
	for error in error_username:
		error.set_hidden(!error.is_hidden())
