
extends State

func enter(owner):
	owner.pathfinding = owner.pathfinding_res.getPath(Vector2(owner.get_translation().x, owner.get_translation().z), Vector2(owner.spawn_point.x, owner.spawn_point.z), owner)
	owner.add_child(owner.pathfinding)

func execute(owner):
	if owner.checkEndPath():
		owner.queue_free()

func exit(owner):
	pass

