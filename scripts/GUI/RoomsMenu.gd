extends Panel

var rooms_ressources
var confirm_node

func _ready():
	confirm_node = get_node("Confirmation")
	rooms_ressources = get_node("/root/Game").scene.map.ressources

func _on_Diagnostic_pressed():
	on_button_pressed()
	var i = 0
	for room in rooms_ressources.diagnosis_rooms:
		get_node("Rooms/Button" + str(i)).set_text(rooms_ressources.diagnosis_rooms[room].NAME)
		i += 1


func _on_Treatment_pressed():
	on_button_pressed()
	var i = 0
	for room in rooms_ressources.treatment_rooms:
		get_node("Rooms/Button" + str(i)).set_text(rooms_ressources.treatment_rooms[room].NAME)
		i += 1

func _on_Clinics_pressed():
	on_button_pressed()
	var i = 0
	for room in rooms_ressources.clinics:
		get_node("Rooms/Button" + str(i)).set_text(rooms_ressources.clinics[room].NAME)
		i += 1

func _on_Facilities_pressed():
	on_button_pressed()
	var i = 0
	for room in rooms_ressources.facilities:
		get_node("Rooms/Button" + str(i)).set_text(rooms_ressources.facilities[room].NAME)
		i += 1

func on_button_pressed():
	get_node("Rooms/Label").set_text("Pick Room Type")
	for number_button in range(10):
		get_node("Rooms/Button" + str(number_button)).set_text("")

func _on_Cancel_pressed():
	self.hide()

func _on_Button1_pressed():
	get_node("/root/Game").scene.map.new_room("cancel", null)
	get_node("/root/Game").scene.map.new_room("new", get_node("/root/Game").scene.map.ressources.psychiatric)
	get_node("Confirmation").show()


func _on_Button0_pressed():
	get_node("/root/Game").scene.map.new_room("cancel", null)
	get_node("/root/Game").scene.map.new_room("new", get_node("/root/Game").scene.map.ressources.psychiatric)
	get_node("Confirmation").show()