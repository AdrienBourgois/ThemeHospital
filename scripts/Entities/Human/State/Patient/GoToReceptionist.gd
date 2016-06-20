
extends State

func enter(owner):
	owner.goToReception()

func execute(owner):
	if owner.pathfinding.animation_completed || !owner.pathfinding.found:
		owner.pathfinding.free()
		if Vector2(owner.get_translation().x, owner.get_translation().z) == owner.desk_ptr.vector_pos:
			owner.is_go_to_reception = true
			owner.state_machine.changeState(owner.states.go_to_gp_office)
		else:
			owner.state_machine.changeState(owner.states.random_movement)

func exit(owner):
	pass