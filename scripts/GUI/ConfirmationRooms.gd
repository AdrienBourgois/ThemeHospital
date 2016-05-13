extends Panel

var map

func _ready():
	map = get_node("/root/Game").scene.map
	self.hide()

func _on_Cancel_pressed():
	self.hide()
	map.new_room("cancel", null)

func _on_Accept_pressed():
	map.new_room("create", null)
	self.hide()