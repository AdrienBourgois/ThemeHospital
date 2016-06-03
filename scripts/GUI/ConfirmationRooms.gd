extends Panel

onready var game = get_node("/root/Game")
onready var node_rooms_menu = get_node("../RoomsMenu")

onready var gamescn = game.scene
onready var map = gamescn.map
onready var player = gamescn.player
onready var object_resources = gamescn.getObjectResources()
onready var temp_array = gamescn.getTempObjectsNodesArray()

func _ready():
	self.hide()

func _on_Cancel_pressed():
	self.hide() 
	map.new_room("cancel", null)
	node_rooms_menu.is_type_selected = false

func _on_Accept_pressed():
	if (game.getMultiplayer() && map.is_new_room_valid()):
		map.sendRoomToServer()
	else:
		if  (map.new_room("create", null)):
			player.money -= node_rooms_menu.price
			temp_array.append(object_resources.createRoomObject(map.getActualRoomTypeName()))
			temp_array[0].is_selected = true
			temp_array[0].can_selected = true
			temp_array[0].set_process_input(true)
			for current in temp_array:
				gamescn.add_child(current)
		if (!temp_array.empty()):
			temp_array[0].hideOtherObjects()
			gamescn.setHaveObject(true)
	self.hide()
	
	node_rooms_menu.is_type_selected = false