
extends State

func enter(owner):
	owner.moveTo()

func execute(owner):
	if owner.checkEndPath():
		owner.state_machine.changeState(owner.states.go_to_reception)

func exit(owner):
	pass