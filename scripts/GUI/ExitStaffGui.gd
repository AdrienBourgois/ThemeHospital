
extends Button

onready var viewport = get_parent().get_node("Viewport")

func _on_ExitStaffGui_pressed():
	get_parent().hide()
	viewport.set_process(false)
	viewport.node = null