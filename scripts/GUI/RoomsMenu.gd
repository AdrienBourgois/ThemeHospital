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
#	var i = 0
#	var buttons = get_node("Types").get_children()
#	for room in rooms_types:
#		if (buttons[i].is_connected("pressed", self, "type_rooms_pressed") == true):
#			buttons[i].disconnect("pressed", self, "type_rooms_pressed")
#		print("rooms_type : ", rooms_types[room])
#		buttons[i].connect("pressed", self, "type_rooms_pressed", [rooms_types[room]])
#		i += 1

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
		if (get_node("Rooms/Button" + str(i)).is_connected("pressed", self, "rooms_pressed") == true):
			get_node("Rooms/Button" + str(i)).disconnect("pressed", self, "rooms_pressed")
			i += 1
	if (is_type_selected == true):
		map.new_room("new", room)

#func type_rooms_pressed(type):
#	get_node("Rooms/Label").set_text("Pick Room Type")
#	clean_buttons()
#	var i = 0
#	#print("type : ", type)
#	#print(rooms_types)
#	for rooms in rooms_types:
#		#print(rooms_types[rooms])
#			#print("TEST : ", test)
#			print("room func : ", rooms)
#			print("TEST 1 : ", rooms_types)
#		get_node("Rooms/Button" + str(i)).set_text(rooms_types[type[rooms]].NAME)
#		get_node("Rooms/Button" + str(i)).connect("pressed", self, "rooms_pressed", [rooms])
#		i += 1
#	is_type_selected = true


func on_type_rooms_buttons_pressed():
	get_node("Rooms/Label").set_text("Pick Room Type")
	clean_buttons()


func _on_Diagnosis_pressed():
	on_type_rooms_buttons_pressed()
	var i = 0
	for room in rooms_ressources.diagnosis_rooms:
		get_node("Rooms/Button" + str(i)).set_text(rooms_ressources.diagnosis_rooms[room].NAME)
		get_node("Rooms/Button" + str(i)).connect("pressed", self, "rooms_pressed", [room])
		i += 1
	is_type_selected = true

