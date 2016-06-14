
extends State

func enter(owner):
	owner.goToReception()

func execute(owner):
	if owner.checkEndPath() && Vector2(owner.get_translation().x, owner.get_translation().z) == owner.desk_ptr.vector_pos:
		owner.is_go_to_reception = true
		print("GoToGpOffice")
	else:
		owner.changeState(owner.states.random_movement)

func exit(owner):
	pass