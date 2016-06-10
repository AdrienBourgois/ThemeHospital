
extends State

func enter(owner):
	print("Enter GoToGPOffice State")
	owner.checkGPOffice()

func execute(owner):
	print("Execute GoToGPOffice State")
	owner.checkEndPath()

func exit(owner):
	pass