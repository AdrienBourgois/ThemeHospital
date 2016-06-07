
extends State

func enter(owner):
	owner.checkDesk()

func execute(owner):
	if owner.pathfinding.animation_completed:
		owner.state_machine.changeState(owner.states.at_desk)

func exit(owner):
	pass
