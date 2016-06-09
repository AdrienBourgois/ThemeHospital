
extends State

func enter(owner):
	owner.moveIntoRoom()

func execute(owner):
	if owner.pathfinding.animation_completed == true:
		owner.moveIntoRoom()

func exit(owner):
	pass