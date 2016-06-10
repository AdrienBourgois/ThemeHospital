
extends State

func enter(owner):
	owner.checkGPOffice()

func execute(owner):
	owner.checkEndPath()

func exit(owner):
	pass