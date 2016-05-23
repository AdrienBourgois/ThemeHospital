extends Panel

var rooms_ressources
var map
var confirm_build
var is_type_selected = false
var rooms_types
var price
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
		buttons[button_number].set_text(type)
		buttons[button_number].connect("pressed", self, "type_rooms_pressed", [rooms_types[type]])
		button_number += 1

func _on_Cancel_pressed():
	self.hide()
	clean_buttons()
	
	is_type_selected = false
	node_label.set_text("PICK_DPT")

func clean_buttons():
	var buttons
	for number_button in range(10):
		buttons = get_node("Rooms/Button" + str(number_button))
		buttons.set_text("")
		buttons.set_tooltip("")
		
		disconnect_buttons(buttons)
	
	node_text_label.set_text("")
	node_cost_label.set_text("")

func disconnect_buttons(buttons):
	if buttons.is_connected("mouse_enter", self, "enter_rooms"):
		buttons.disconnect("mouse_enter", self, "enter_rooms")
	
	if buttons.is_connected("mouse_exit", self, "exit_rooms"):
		buttons.disconnect("mouse_exit", self, "exit_rooms")
	
	if buttons.is_connected("pressed", self, "rooms_pressed"):
		buttons.disconnect("pressed", self, "rooms_pressed")
	
	if buttons.is_connected("pressed", self, "type_rooms_pressed") == true:
		buttons.disconnect("pressed", self, "type_rooms_pressed")

func rooms_pressed(room):
	clean_buttons()
	
	price = room.COST
	
	if (is_type_selected == true):
		confirm_build.show()
		self.hide()
	
	if (is_type_selected == true):
		map.new_room("new", room)

func type_rooms_pressed(type):
	node_label.set_text("PICK_ROOM")
	clean_buttons()
	
	var number_button = 0
	var buttons
	
	for rooms in type:
		buttons = get_node("Rooms/Button" + str(number_button))
		
		buttons.set_text(type[rooms].NAME)
		buttons.set_tooltip(type[rooms].TOOLTIP)
		
		mouse_enter_on_room(type, rooms, number_button)
		buttons.connect("pressed", self, "rooms_pressed",[type[rooms]])
		number_button += 1
	
	is_type_selected = true

func mouse_enter_on_room(type, rooms, number_button):
	var buttons = get_node("Rooms/Button" + str(number_button))
	
	buttons.connect("mouse_enter", self, "enter_rooms", [type[rooms]])
	buttons.connect("mouse_exit", self, "exit_rooms")

func enter_rooms(type):
	node_text_label.set_text(type.NAME)
	node_cost_label.set_text(tr("COST") + str(type.COST) + "$")

func exit_rooms():
	node_text_label.set_text("")
	node_cost_label.set_text("")