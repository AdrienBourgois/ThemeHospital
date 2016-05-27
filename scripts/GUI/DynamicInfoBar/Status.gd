
extends Panel

onready var game = get_node("/root/Game")
onready var camera = game.scene.camera
onready var hud = get_parent().get_node("HUD")

func _on_Quit_pressed():
	hud.show()
	hide()
	camera.pause = false