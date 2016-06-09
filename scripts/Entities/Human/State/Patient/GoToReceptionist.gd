
extends State

func enter(owner):
	owner.goToReception()

func execute(owner):
	owner.checkEndPath()

func exit(owner):
	pass