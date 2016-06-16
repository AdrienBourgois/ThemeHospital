
extends State

func enter(owner):
	owner.get_node("Timer").stop()
	owner.goToStaffRoom()

func execute(owner):
	if owner.tireness == 100:
		owner.state_machine.returnToPreviousState()

func exit(owner):
	pass