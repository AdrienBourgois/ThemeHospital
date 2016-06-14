extends Panel

onready var game = get_node("/root/Game")
onready var node_rooms_menu = get_node("../RoomsMenu")

onready var gamescn = game.scene
onready var map = gamescn.map
onready var player = gamescn.player
onready var object_resources = gamescn.getObjectResources()
onready var temp_array = gamescn.getTempObjectsNodesArray()

var room

func _ready():
	self.hide()

func _on_Cancel_pressed():
	self.hide() 
	room = map.new_room("cancel", null)
	node_rooms_menu.is_type_selected = false

func _on_Accept_pressed():
	room = map.new_room("create", null)
	if  (room):
		player.money -= node_rooms_menu.price
		
		var door = object_resources.createObject("Door")
		temp_array.append(door)
		gamescn.add_child(door)
		door.is_selected = true
		door.can_selected = true
		door.set_process_input(true)
		door.setUniqueID(room.getUniqueID())
		
		object_resources.createRoomObject(map.getActualRoomTypeName())
		self.hide()
	else:
		game.feedback.display("FEEDBACK_BLUEPRINT")
		self.hide()
		return
	
	if (!temp_array.empty()):
		gamescn.setHaveObject(true)
	
	node_rooms_menu.is_type_selected = false