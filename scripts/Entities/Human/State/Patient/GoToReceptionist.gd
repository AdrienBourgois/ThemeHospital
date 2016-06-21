
extends State

func enter(owner):
	owner.goToReception()

func execute(owner):
	if owner.pathfinding.animation_completed || !owner.pathfinding.found:
		owner.pathfinding.stop()
		if Vector2(owner.get_translation().x, owner.get_translation().z) == owner.object_ptr.vector_pos:
			owner.is_go_to_reception = true
			owner.state_machine.changeState(owner.states.go_to_gp_office)
		else:
			owner.state_machine.changeState(owner.states.random_movement)

func exit(owner):
	if owner.object_ptr:
		owner.object_ptr = null
