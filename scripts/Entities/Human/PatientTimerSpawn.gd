
extends Timer

var count = 0

func _ready():
	randomize()

func _on_Timer_timeout():
	if count == 100:
		disconnect("timeout", self, "_on_Timer_timeout")
	else:
		var spawn_time = rand_range(1, 20)
		set_wait_time(spawn_time)
		get_parent().patient_array.push_back(get_parent().generatePatientData())
		get_parent().createPatientBody()
		start()
		count += 1
