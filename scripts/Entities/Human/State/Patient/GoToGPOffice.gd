
extends State

func enter(owner):
	owner.checkGPOffice()

func execute(owner):
	print(owner.get_node("Disease").type)
	pass

func exit(owner):
	pass