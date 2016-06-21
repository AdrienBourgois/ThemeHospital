
extends State

func enter(owner):
	owner.checkStaffRoom()

func execute(owner):
	if owner.pathfinding.animation_completed == true || owner.pathfinding.found == false:
		owner.pathfinding.stop()
		owner.state_machine.changeState(owner.states.rest)


func exit(owner):
	pass
