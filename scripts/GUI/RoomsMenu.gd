extends Panel

var rooms_ressources
var map
var confirm_build

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

func _on_Treatment_pressed():
	on_type_rooms_buttons_pressed()
	var i = 0
	for room in rooms_ressources.treatment_rooms:
		get_node("Rooms/Button" + str(i)).set_text(rooms_ressources.treatment_rooms[room].NAME)
		i += 1

func _on_Clinics_pressed():
	on_type_rooms_buttons_pressed()
	var i = 0
	for room in rooms_ressources.clinics:
		get_node("Rooms/Button" + str(i)).set_text(rooms_ressources.clinics[room].NAME)
		i += 1

func _on_Facilities_pressed():
	on_type_rooms_buttons_pressed()
	var i = 0
	for room in rooms_ressources.facilities:
		get_node("Rooms/Button" + str(i)).set_text(rooms_ressources.facilities[room].NAME)
		i += 1

func on_type_rooms_buttons_pressed():
	get_node("Rooms/Label").set_text("Pick Room Type")
	for number_button in range(10):
		get_node("Rooms/Button" + str(number_button)).set_text("")

func _on_Cancel_pressed():
	self.hide()

func on_rooms_button_pressed():
	self.hide()
	map.new_room("cancel", null)
	confirm_build.show()

func on_mouse_enter():
	#get_node("Rooms/Cost").set_text("cost : " + rooms_ressources.type_selected.room.COST)
	#get_node("Text/Label").set_text(rooms_ressources.type_selected.room.NAME)
	pass

func _on_Button1_pressed():
	on_rooms_button_pressed()
	map.new_room("new", rooms_ressources.diagnosis_rooms.GP_OFFICE)

func _on_Button0_pressed():
	on_rooms_button_pressed()
	map.new_room("new", rooms_ressources.treatment_rooms.PSYCHIATRIC)
