extends Panel

var rooms_ressources
var confirm_node

func init():
	confirm_node = get_node("Confirmation")
	rooms_ressources = get_node("/root/Game").scene.map.ressources

func _on_Diagnostic_pressed():
	on_button_pressed()
	get_node("Rooms/1stButton").set_text(rooms_ressources.diagnosis_rooms.GP_OFFICE.NAME)


func _on_Treatment_pressed():
	on_button_pressed()

func _on_Clinics_pressed():
	on_button_pressed()

func _on_Facilities_pressed():
	on_button_pressed()

func on_button_pressed():
	get_node("Rooms/Label").set_text("Pick Room Type")

func _on_Cancel_pressed():
	self.hide()

func _on_1stButton_pressed():
	get_node("/root/Game").scene.map.new_room("new", get_node("/root/Game").scene.map.ressources.psychiatric)
	get_node("Confirmation").show()