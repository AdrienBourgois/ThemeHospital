extends Panel

var map
onready var node_rooms_menu = get_node("../RoomsMenu")

func _ready():
	map = get_node("/root/Game").scene.map
	self.hide()

func _on_Cancel_pressed():
	self.hide()
	map.new_room("cancel", null)
	node_rooms_menu.is_type_selected = false

func _on_Accept_pressed():
	map.new_room("create", null)
	self.hide()
	node_rooms_menu.is_type_selected = false