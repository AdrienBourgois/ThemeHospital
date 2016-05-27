extends Panel

onready var game = get_node("/root/Game")
onready var camera = game.scene.camera
onready var reputation_value = get_node("/root/Game").scene.player.reputation
onready var hud = get_parent().get_node("HUD")

func _ready():
	pass


func _on_Quit_pressed():
	self.hide()
	hud.show()
	camera.pause = false