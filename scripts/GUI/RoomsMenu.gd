extends Panel

var rooms_ressources
var map
var confirm_build
var is_type_selected = false
var rooms_types
var price

onready var game = get_node("/root/Game")
onready var player = game.scene.player

onready var node_label = get_node("Rooms/Label")
onready var node_text_label = get_node("Text/Label")
onready var node_cost_label = get_node("Rooms/Cost")

func _ready():
	confirm_build = get_node("../Confirmation")
	map = get_node("/root/Game").scene.map
	rooms_ressources = map.ressources
	rooms_types = rooms_ressources.type_rooms
	
	var button_number = 0
	var buttons = get_node("Types").get_children()
	
	for type in rooms_types:
		print(type)
		buttons[button_number].set_text(type)
		buttons[button_number].connect("pressed", self, "typeRoomsPressed", [rooms_types[type]])
		
		button_number += 1

func typeRoomsPressed(type):
	node_label.set_text("PICK_ROOM")
	cleanButtons()
	
	var number_button = 0
	var buttons
	
	for rooms in type:
		buttons = get_node("Rooms/Button" + str(number_button))
		buttons.set_text(type[rooms].NAME)
		buttons.set_tooltip(type[rooms].TOOLTIP)
		
		mouseEnterOnRoom(type, rooms, number_button)
		buttons.connect("pressed", self, "roomsPressed",[type[rooms]])
		number_button += 1
	
	is_type_selected = true

func cleanButtons():
	var buttons
	for number_button in range(10):
		buttons = get_node("Rooms/Button" + str(number_button))
		
		buttons.set_text("")
		buttons.set_tooltip("")
		
		disconnectButtons(buttons)
	
	node_text_label.set_text("")
	node_cost_label.set_text("")

func disconnectButtons(buttons):
	disconnectFunc(buttons, "mouse_enter", "enterRooms")
	disconnectFunc(buttons, "mouse_exit", "exitRooms")
	disconnectFunc(buttons, "pressed", "roomsPressed")
	disconnectFunc(buttons, "pressed", "typeRoomsPressed")

func disconnectFunc(buttons, type, method):
	if buttons.is_connected(type, self, method):
		buttons.disconnect(type, self, method)

func mouseEnterOnRoom(type, rooms, number_button):
	var buttons = get_node("Rooms/Button" + str(number_button))
	
	buttons.connect("mouse_enter", self, "enterRooms", [type[rooms]])
	buttons.connect("mouse_exit", self, "exitRooms")

func enterRooms(type):
	node_text_label.set_text(type.NAME)
	node_cost_label.set_text(tr("COST") + str(type.COST) + "$")

func exitRooms():
	node_text_label.set_text("")
	node_cost_label.set_text("")

func roomsPressed(room):
	if player.money >= room.COST:
		cleanButtons()
	
		price = room.COST
	
		if (is_type_selected == true):
			confirm_build.show()
			self.hide()
	
		if (is_type_selected == true):
			map.new_room("new", room)
	else:
		game.feedback.display("FEEDBACK_ENOUGH_MONEY")

func _on_Cancel_pressed():
	self.hide()
	cleanButtons()
	
	is_type_selected = false
	node_label.set_text("PICK_DPT")