
extends State

func enter(owner):
	owner.moveTo()

func execute(owner):
	owner.checkEndPath()

func exit(owner):
	pass