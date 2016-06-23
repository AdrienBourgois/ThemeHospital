
extends State

func enter(owner):
	owner.room_occuped.present_staff.append(owner)
	owner.moveIntoRoom()

func execute(owner):
	if owner.pathfinding.animation_completed == true || owner.pathfinding.found == false:
		owner.pathfinding.free()
		owner.moveIntoRoom()

func exit(owner):
	owner.room_occuped.present_staff.clear()
	owner.room_occuped.is_occuped = false
	owner.room_occuped = null