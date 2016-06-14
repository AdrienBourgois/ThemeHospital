
extends State

func enter(owner):
	owner.tire *= -1
	owner.moveIntoRoom()
	owner.is_resting = true

func execute(owner):
	if owner.tireness == 100:
		owner.checkEndPath()
		return
		
	if owner.pathfinding.animation_completed == true || owner.pathfinding.found == false:
		owner.moveIntoRoom()

func exit(owner):
	owner.tire *= -1
	owner.is_resting = false