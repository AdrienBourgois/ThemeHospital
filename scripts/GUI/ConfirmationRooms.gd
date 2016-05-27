extends Panel

onready var game = get_node("/root/Game")
onready var node_rooms_menu = get_node("../RoomsMenu")

onready var gamescn = game.scene
onready var map = gamescn.map
onready var player = gamescn.player

onready var object_resources = gamescn.getObjectResources()
onready var desk_res = preload("res://scenes/Entities/Objects/Desk.scn")
onready var plant_res = preload("res://scenes/Entities/Objects/Plant.scn")
onready var door_res = preload("res://scenes/Map/Door.scn")

func _ready():
	self.hide()

func _on_Cancel_pressed():
	self.hide() 
	map.new_room("cancel", null)
	node_rooms_menu.is_type_selected = false

func _on_Accept_pressed():
	if (game.getMultiplayer()):
		map.sendRoomToServer()
	
	else:
		if (map.new_room("create", null)):
			player.money -= node_rooms_menu.price
			var node = object_resources.createRoomObject(map.getActualRoomTypeName())
			node.is_selected = true
			node.can_selected = true
			node.set_process_input(true)
			gamescn.add_child(node)
	self.hide()
	
	node_rooms_menu.is_type_selected = false