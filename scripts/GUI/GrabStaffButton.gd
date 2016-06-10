
extends Button

onready var game = get_node("/root/Game")

func _on_GrabButton_pressed():
	game.scene.hire_manager.staff_selected.can_selected = true
	game.scene.hire_manager.staff_selected.pathfinding.animation_completed = true
	game.scene.hire_manager.staff_selected.is_taken = true
	game.scene.hire_manager.staff_selected.take()
	
	get_parent().hide()
