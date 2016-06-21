
extends State

func enter(owner):
	owner.checkWorkRoom()

func execute(owner):
	if owner.pathfinding.animation_completed == true || owner.pathfinding.found == false:
		owner.pathfinding.stop()
		owner.state_machine.changeState(owner.states.waiting_for_patients)

func exit(owner):
	pass
