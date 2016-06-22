
extends Control

onready var game = get_node("/root/Game")
onready var rooms_menu = game.scene.get_node("RoomsMenu")
onready var control_panel = game.scene.get_node("./In_game_gui/HUD/Control_panel/Build_hire_controls")

onready var gamescn = game.scene
onready var map = gamescn.map
onready var player = gamescn.player


func _on_CancelButton_pressed():
	map.newRoom("cancel", null)
	control_panel.hideCurrentWindow()

func _on_AcceptButton_pressed():
	var room = map.newRoom("create", null)
	if  (room):
		player.money -= rooms_menu.price
		player.hospital_value += rooms_menu.price
	else:
		game.feedback.display("FEEDBACK_BLUEPRINT")
		
	self.hide()
	
	control_panel.hideCurrentWindow()
