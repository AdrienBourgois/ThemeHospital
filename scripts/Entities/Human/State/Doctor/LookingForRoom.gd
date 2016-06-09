extends State

func enter(owner):
	owner.checkRoom()

func execute(owner):
	if owner.pathfinding.animation_completed:
		owner.state_machine.changeState(owner.states.waiting_for_patient)

func exit(owner):
	pass


