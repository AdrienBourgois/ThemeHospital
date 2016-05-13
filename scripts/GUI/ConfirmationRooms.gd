extends Panel

func _ready():
	self.hide()

func _on_Cancel_pressed():
	self.hide()
	get_node("/root/Game").scene.map.new_room("cancel", null)
	get_node("Buttons/Accept").disconnect("pressed", get_node("/root/Game").scene.map, "new_room")
	#######cancel all construction#########

func _on_Accept_pressed():
	get_node("/root/Game").scene.map.new_room("create", null)
	self.hide()