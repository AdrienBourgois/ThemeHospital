
extends State

func enter(owner):
	owner.moveTo()

func execute(owner):
	if owner.pathfinding.animation_completed || !owner.pathfinding.found:
		owner.checkEndPath()

func exit(owner):
	pass