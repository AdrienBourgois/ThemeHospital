
extends KinematicBody

onready var game = get_node("/root/Game")
onready var map = game.scene.map
onready var mouse_pos_3d = map.mouse_pos


var id
var name
var skill
var salary
var specialities
var seniority
var is_selected = false

func _ready():
	set_translation(mouse_pos_3d)
	set_process(true)

func _process(delta):
	mouse_pos_3d = map.mouse_pos
	set_translation(mouse_pos_3d)