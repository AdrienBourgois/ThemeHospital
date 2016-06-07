
extends State

func enter(owner):
	owner.watering()

func execute(owner):
	owner.checkEndPath()

func exit(owner):
	pass