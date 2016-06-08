
extends State

func enter(owner):
	owner.goToReception()

func execute(owner):
	print("Hey")
	if owner.pathfinding.animation_completed:
		owner.checkGPOffice()

func exit(owner):
	pass