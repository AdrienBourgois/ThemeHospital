extends Panel

func _ready():
	get_node("Buttons/Accept").connect("pressed", get_node("/root/Game").scene.map, "new_room", ["create", null])

func _on_Cancel_pressed():
	self.hide()
	#######cancel all construction#########

