
extends Button

onready var viewport = get_parent().get_node("Viewport")
onready var root = get_tree().get_current_scene().get_node("Control")

func _on_ExitStaffGui_pressed():
#	get_parent().hide()
#	viewport.set_process(false)
#	viewport.node = null
	root.queue_free()