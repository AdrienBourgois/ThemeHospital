
extends State

func enter(owner):
	owner.checkBench()

func execute(owner):
	if owner.pathfinding != null && owner.checkEndPath():
		if owner.is_diagnosed == false:
			owner.state_machine.changeState(owner.states.go_to_gp_office)
			owner.bench_ptr.is_occuped = false
		else:
			owner.state_machine.changeState(owner.states.go_to_adapted_heal_room)
			owner.bench_ptr.is_occuped = false

func exit(owner):
	pass