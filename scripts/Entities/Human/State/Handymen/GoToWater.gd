
extends State

func enter(owner):
	owner.checkPlant()

func execute(owner):
	if owner.pathfinding.animation_completed == true:
		owner.state_machine.changeState(owner.get_node("Watering"))

func exit(owner):
	pass