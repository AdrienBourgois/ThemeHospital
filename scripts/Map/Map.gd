
extends Node

var squares = []

func _ready():
	create_map(5, 5)

func create_map(_x, _y):
	for x in range(_x):
		for y in range(_y):
			var square = load("res://scenes/Map/MapSquare.scn").instance()
			add_child(square)
			if(!y):
				square.change_wall("Up", square.enum_wall_type.WALL)
			square.create(x, y, square.enum_room_type.DECORATION)
			square.set_translation(Vector3(x, 0, y))
			squares.append(square)
