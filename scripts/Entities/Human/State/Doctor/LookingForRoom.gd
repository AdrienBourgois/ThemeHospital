extends State

func enter(owner):
	owner.checkWorkRoom()

func execute(owner):
#	if owner.pathfinding.animation_completed:
#		owner.state_machine.changeState(owner.states.waiting_for_patient)
	pass

func exit(owner):
	pass


