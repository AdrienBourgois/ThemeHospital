
extends Spatial

onready var squares_array = []
onready var cube = get_node("TestCube")

func _ready():
	pass

func create(array):
	for current in array:
		var new_cube = cube.duplicate()
		array.add_child(new_cube)

