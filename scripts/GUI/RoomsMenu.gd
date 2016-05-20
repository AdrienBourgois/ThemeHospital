extends Panel

var rooms_ressources
var map
var confirm_build
var is_type_selected = false
var rooms_types

func _ready():
	confirm_build = get_node("../Confirmation")
	map = get_node("/root/Game").scene.map
	rooms_ressources = map.ressources
	rooms_types = rooms_ressources.type_rooms
	var button_number = 0
	var buttons = get_node("Types").get_children()
	for type in rooms_types:
		if (buttons[button_number].is_connected("pressed", self, "type_rooms_pressed") == true):
			buttons[button_number].disconnect("pressed", self, "type_rooms_pressed")
		buttons[button_number].set_text(type)
		buttons[button_number].connect("pressed", self, "type_rooms_pressed", [rooms_types[type]])
		button_number += 1

func _on_Cancel_pressed():
	self.hide()
	clean_buttons()
	is_type_selected = false

func clean_buttons():
	for number_button in range(10):
		get_node("Rooms/Button" + str(number_button)).set_text("")

func rooms_pressed(room):
	clean_buttons()
	if (is_type_selected == true):
		confirm_build.show()
		self.hide()
	if (is_type_selected == true):
		map.new_room("new", room)

func type_rooms_pressed(type):
	get_node("Rooms/Label").set_text("Pick Room Type")
	clean_buttons()
	var number_button = 0
	var buttons
	for rooms in type:
		print(rooms)
		buttons = get_node("Rooms/Button" + str(number_button))
		if buttons.is_connected("pressed", self, "rooms_pressed"):
			buttons.disconnect("pressed", self, "rooms_pressed")
		buttons.set_text(rooms)
		buttons.connect("pressed", self, "rooms_pressed",[type[rooms]])
		number_button += 1
	is_type_selected = true