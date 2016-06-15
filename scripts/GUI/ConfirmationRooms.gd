
extends Control

onready var game = get_node("/root/Game")
onready var rooms_menu = game.scene.get_node("RoomsMenu")
onready var control_panel = game.scene.get_node("./In_game_gui/HUD/Control_panel/Build_hire_controls")

onready var gamescn = game.scene
onready var map = gamescn.map
onready var player = gamescn.player
onready var object_resources = gamescn.getObjectResources()
onready var temp_array = gamescn.getTempObjectsNodesArray()


func _on_CancelButton_pressed():
	map.new_room("cancel", null)
	control_panel.hideCurrentWindow()


func _on_AcceptButton_pressed():
	if  (map.new_room("create", null)):
		player.money -= rooms_menu.price
		
		var door = object_resources.createObject("Door")
		temp_array.append(door)
		gamescn.add_child(door)
		door.is_selected = true
		door.can_selected = true
		door.set_process_input(true)
		
		object_resources.createRoomObject(map.getActualRoomTypeName())
	
	if (!temp_array.empty()):
		gamescn.setHaveObject(true)
	
	control_panel.hideCurrentWindow()