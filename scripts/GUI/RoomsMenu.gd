extends Panel

var rooms_ressources
var map
var confirm_build
var is_type_selected = false

func _ready():
	confirm_build = get_node("../Confirmation")
	map = get_node("/root/Game").scene.map
	rooms_ressources = map.ressources

func _on_Diagnostic_pressed():
	on_type_rooms_buttons_pressed()
	var i = 0
	for room in rooms_ressources.diagnosis_rooms:
		get_node("Rooms/Button" + str(i)).set_text(rooms_ressources.diagnosis_rooms[room].NAME)
		i += 1
	is_type_selected = true

func _on_Treatment_pressed():
	on_type_rooms_buttons_pressed()
	var i = 0
	for room in rooms_ressources.treatment_rooms:
		get_node("Rooms/Button" + str(i)).set_text(rooms_ressources.treatment_rooms[room].NAME)
		i += 1
	is_type_selected = true

func _on_Clinics_pressed():
	on_type_rooms_buttons_pressed()
	var i = 0
	for room in rooms_ressources.clinics:
		get_node("Rooms/Button" + str(i)).set_text(rooms_ressources.clinics[room].NAME)
		i += 1
	is_type_selected = true

func _on_Facilities_pressed():
	on_type_rooms_buttons_pressed()
	var i = 0
	for room in rooms_ressources.facilities:
		get_node("Rooms/Button" + str(i)).set_text(rooms_ressources.facilities[room].NAME)
		i += 1
	is_type_selected = true

func on_type_rooms_buttons_pressed():
	get_node("Rooms/Label").set_text("Pick Room Type")
	clean_buttons()

func _on_Cancel_pressed():
	self.hide()
	clean_buttons()
	is_type_selected = false

func on_rooms_button_pressed():
	clean_buttons()
	if (is_type_selected == true):
		confirm_build.show()
		self.hide()

func clean_buttons():
	for number_button in range(10):
		get_node("Rooms/Button" + str(number_button)).set_text("")

func on_mouse_enter():
	#get_node("Rooms/Cost").set_text("cost : " + rooms_ressources.type_selected.room.COST)
	#get_node("Text/Label").set_text(rooms_ressources.type_selected.room.NAME)
	pass

func _on_Button1_pressed():
	on_rooms_button_pressed()
	if (is_type_selected == true):
		map.new_room("new", rooms_ressources.diagnosis_rooms.GP_OFFICE)
	else:
		return

func _on_Button0_pressed():
	on_rooms_button_pressed()
	if (is_type_selected == true):
		map.new_room("new", rooms_ressources.treatment_rooms.PSYCHIATRIC)
	else:
		return
