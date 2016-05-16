extends Panel

var rooms_ressources
var map
var confirm_build
var is_type_selected = false

func _ready():
	confirm_build = get_node("../Confirmation")
	map = get_node("/root/Game").scene.map
	rooms_ressources = map.ressources
	
	var rooms_types = rooms_ressources.type_rooms
	var i = 0
	var buttons = get_node("Types").get_children()
	for room in rooms_types:
		if (buttons[i].is_connected("pressed", self, "type_rooms_pressed") == true):
			buttons[i].disconnect("pressed", self, "type_rooms_pressed")
		buttons[i].connect("pressed", self, "type_rooms_pressed", [rooms_types[room]])
		i += 1

func _on_Cancel_pressed():
	self.hide()
	clean_buttons()
	is_type_selected = false

func clean_buttons():
	for number_button in range(10):
		get_node("Rooms/Button" + str(number_button)).set_text("")

#func on_mouse_enter():
#	get_node("Rooms/Cost").set_text("cost : " + rooms_ressources.type_selected.room.COST)
#	get_node("Text/Label").set_text(rooms_ressources.type_selected.room.NAME)
#	pass

func rooms_pressed(room):
	clean_buttons()
	if (is_type_selected == true):
		confirm_build.show()
		self.hide()
	var i = 0
	for button in get_node("Rooms").get_children():
		get_node("Rooms/Button" + str(i)).disconnect("pressed", self, "rooms_pressed")
		i += 1
	if (is_type_selected == true):
		map.new_room("new", room)

func type_rooms_pressed(type):
	get_node("Rooms/Label").set_text("Pick Room Type")
	clean_buttons()
	var i = 0
	print("type : ", type)
	for room in rooms_ressources.get_rooms_by_type(type):
		get_node("Rooms/Button" + str(i)).set_text(rooms_ressources.type_rooms[type.NAME])
		get_node("Rooms/Button" + str(i)).connect("pressed", self, "rooms_pressed", [type])
		i += 1
	is_type_selected = true