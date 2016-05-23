extends Panel

var map
onready var node_rooms_menu = get_node("../RoomsMenu")
onready var game = get_node("/root/Game")
onready var gamescn = game.scene
onready var player = gamescn.player
onready var desk_res = preload("res://scenes/Entities/Objects/Desk.scn")
onready var plant_res = preload("res://scenes/Entities/Objects/Plant.scn")
onready var door_res = preload("res://scenes/Map/Door.scn")

func _ready():
	map = get_node("/root/Game").scene.map
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
			var desk = desk_res.instance()
			gamescn.add_child(desk)
	self.hide()
	
	player.money -= node_rooms_menu.price
	
	node_rooms_menu.is_type_selected = false