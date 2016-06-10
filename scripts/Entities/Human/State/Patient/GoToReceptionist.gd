
extends State

func enter(owner):
	owner.goToReception()

func execute(owner):
	if owner.pathfinding.animation_completed:
		owner.is_go_to_reception = true
		owner.checkEndPath()
		owner.state_machine.changeState(owner.states.random_movement)

func exit(owner):
	pass