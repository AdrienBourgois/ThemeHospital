extends Panel

func _ready():
	get_node("Buttons/Accept").connect("pressed", get_node("/root/Game").scene.map, "new_room", ["create", null])
	self.hide()

func _on_Cancel_pressed():
	self.hide()
	get_node("Buttons/Accept").disconnect("pressed", get_node("/root/Game").scene.map, "new_room")
	#######cancel all construction#########

