
extends Spatial

onready var squares_array = []

func _ready():
	pass

#func create(array, idx):
	#var new_cube = get_node("TestCube").duplicate()
	#new_cube.set_translation(array[idx].get_translation() + Vector3(0,1,0))
	#array[idx].add_child(new_cube)

func create(square):
	var cube = get_node("TestCube")
	cube.set_translation(self.get_translation())
	cube.show()


