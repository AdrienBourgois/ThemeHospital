
extends Spatial

onready var game = get_node("/root/Game")
onready var mouse_pos_3d = game.scene.map.mouse_pos

var squares_array = []
var name
var activated = false

func _ready():
	pass

func _process(delta):
	pass

func create(square):
	var cube = get_node("TestCube")


