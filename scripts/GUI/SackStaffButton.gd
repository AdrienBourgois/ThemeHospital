
extends Button

onready var hire_manager = get_node("/root/Game").scene.hire_manager

func _on_SackButton_pressed():
	get_parent().hide()
	get_node("ConfirmationDialog").show()
