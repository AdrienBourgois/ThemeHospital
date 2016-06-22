
extends State

func enter(owner):
	owner.pathfinding = owner.pathfinding_res.new(Vector2(owner.get_translation().x, owner.get_translation().z), Vector2(owner.spawn_point.x, owner.spawn_point.z), owner, owner.speed, owner.map)
	owner.add_child(owner.pathfinding)

func execute(owner):
	if owner.pathfinding.animation_completed || !owner.pathfinding.found:
		owner.pathfinding.free()
		owner.queue_free()

func exit(owner):
	pass

