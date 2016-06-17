
extends State

func enter(owner):
	owner.checkPlant()

func execute(owner):
	if owner.pathfinding.animation_completed == true && Vector2(owner.get_translation().x, owner.get_translation().z) == owner.plant_pos:
		owner.watering()
		owner.checkEndPath()

func exit(owner):
	pass