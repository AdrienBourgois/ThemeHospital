
extends State

func enter(owner):
	print(owner)
	if owner.desk_occuped.is_occuped:
		owner.desk_occuped = null
		owner.state_machine.changeState(owner.get_node("GoToDesk"))
	else:
		owner.desk_occuped.is_occuped = true

func execute(owner):
	pass

func exit(owner):
	pass