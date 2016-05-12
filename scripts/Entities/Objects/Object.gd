
extends Spatial

onready var game = get_node("/root/Game")
onready var map = game.scene.map
onready var mouse_pos_3d = map.mouse_pos

var squares_array = []
var name
var is_selected = false
var can_be_selected = true

func _ready():
	self.set_translation(mouse_pos_3d)
	set_process(true)

func _process(delta):
	pass

func create(square):
	var cube = get_node("TestCube")


