
extends State

func enter(owner):
	owner.checkDesk()

func execute(owner):
	if owner.pathfinding.animation_completed:
		owner.state_machine.changeState(owner.get_node("AtDesk"))

func exit(owner):
	pass
