
extends State

func enter(owner):
	owner.happiness -= 2
	owner.checkBench()

func execute(owner):
	if owner.pathfinding != null && owner.pathfinding.animation_completed || !owner.pathfinding.found:
		owner.pathfinding.free()
		if owner.is_diagnosed == false:
			owner.state_machine.changeState(owner.states.go_to_gp_office)
			owner.object_ptr.is_occuped = false
		else:
			owner.state_machine.changeState(owner.states.go_to_adapted_heal_room)
			owner.object_ptr.is_occuped = false

func exit(owner):
	if owner.object_ptr:
		owner.object_ptr = null