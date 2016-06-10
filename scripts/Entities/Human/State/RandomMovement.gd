
extends State

func enter(owner):
	owner.moveTo()

func execute(owner):
	if owner.pathfinding.animation_completed == true:
		owner.checkEndPath()

func exit(owner):
	pass