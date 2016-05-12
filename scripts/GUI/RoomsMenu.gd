extends Panel

func _ready():
	pass

func _on_Diagnostic_pressed():
	on_button_pressed()

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
