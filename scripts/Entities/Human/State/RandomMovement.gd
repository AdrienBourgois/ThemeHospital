
extends State

func enter(owner):
	owner.happiness -= 2
	owner.moveTo()

func execute(owner):
	if owner.pathfinding && owner.pathfinding.animation_completed || !owner.pathfinding.found:
		owner.checkEndPath()

func exit(owner):
	pass