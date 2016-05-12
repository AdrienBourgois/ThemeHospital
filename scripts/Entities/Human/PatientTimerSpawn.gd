
extends Timer

func _ready():
	randomize()

func _on_Timer_timeout():
	var spawn_time = randi()%20
	set_wait_time(spawn_time)
	get_parent().patient_array.push_back(get_parent().generatePatientData())
	get_parent().createPatientBody()
	start()
