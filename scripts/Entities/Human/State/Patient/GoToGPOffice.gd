
extends State

func enter(owner):
	owner.checkGPOffice()

func execute(owner):
	if owner.pathfinding.animation_completed == true:
#		owner.checkEndPath()
		pass

func exit(owner):
	pass