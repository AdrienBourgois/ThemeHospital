
extends Button

onready var game = get_node("/root/Game")

func _on_GrabButton_pressed():
	game.scene.hire_manager.staff_selected.can_selected = true
	get_parent().hide()
