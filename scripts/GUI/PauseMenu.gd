extends Panel

func _ready():
	get_tree().set_pause(true)
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("pause"):
		get_tree().set_pause(false)
		get_tree().get_current_scene().set_process_input(true)
		queue_free()
