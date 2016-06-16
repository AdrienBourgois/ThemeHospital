
extends State

func enter(owner):
	owner.checkGPOffice()

func execute(owner):
	if owner.checkEndPath():
		owner.room_occuped.present_patient.clear()
		owner.state_machine.changeState(owner.states.go_to_adapted_heal_room)

func exit(owner):
	pass