
extends State

func enter(owner):
	owner.checkGPOffice()

func execute(owner):
	if owner.pathfinding.animation_completed == true:
		owner.checkEndPath()

func exit(owner):
	pass