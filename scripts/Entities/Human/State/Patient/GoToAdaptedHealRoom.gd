 
extends State

onready var gamescn = get_node("/root/Game").scene
onready var player = gamescn.player

func enter(owner):
	owner.goToAdaptedHealRoom()

func execute(owner):
	if owner.checkEndPath():
		player.increaseHealPatients(1)
		owner.room_occuped.present_patient.clear()
		owner.disease.queue_free()
		owner.state_machine.changeState(owner.states.go_out)

func exit(owner):
	pass
