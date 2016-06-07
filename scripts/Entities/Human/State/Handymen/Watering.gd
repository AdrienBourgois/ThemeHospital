
extends State

func enter(owner):
	owner.plant_thirsty = 100

func execute(owner):
	owner.checkEndPath()

func exit(owner):
	pass