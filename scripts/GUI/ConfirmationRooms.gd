extends Panel

onready var game = get_node("/root/Game")
onready var node_rooms_menu = get_node("../RoomsMenu")

onready var gamescn = game.scene
onready var map = gamescn.map
onready var player = gamescn.player

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
	self.hide()
	
	node_rooms_menu.is_type_selected = false