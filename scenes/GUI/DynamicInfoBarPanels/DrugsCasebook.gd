extends Panel

onready var reputation_value = get_node("/root/Game").scene.player.reputation
onready var hud = get_parent().get_node("HUD")

func _ready():
	pass


func _on_Quit_pressed():
	self.hide()
	hud.show()
