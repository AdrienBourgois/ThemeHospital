
extends State

func enter(owner):
	owner.goToReception()

func execute(owner):
#	if owner.pathfinding.animation_completed == true:
#		owner.is_go_to_reception = true
#		owner.checkEndPath()
	pass

func exit(owner):
	pass