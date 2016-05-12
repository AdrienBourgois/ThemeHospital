
extends Timer

func _ready():
	randomize()
	#set_process(true)

#func _process(delta):
#	print(get_wait_time() - get_time_left())

func _on_Timer_timeout():
	var spawn_time = randi()%20
	set_wait_time(spawn_time)
	get_parent().patient_array.push_back(get_parent().generatePatientData())
	print("Hello", get_parent().patient_array)
	start()
	pass # replace with function body
