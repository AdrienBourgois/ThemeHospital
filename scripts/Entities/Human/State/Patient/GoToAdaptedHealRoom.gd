
extends State

func enter(owner):
	owner.goToAdaptedHealRoom()

func execute(owner):
	if owner.checkEndPath():
		owner.room_occuped.present_patient.clear()
		owner.disease.queue_free()
		owner.state_machine.changeState(owner.states.go_out)

func exit(owner):
	pass
