
extends KinematicBody

onready var game = get_node("/root/Game")
onready var map = game.scene.map
onready var mouse_pos_3d = map.center_tile_on_cursor
onready var cube = get_node("TestCube")

var is_selected = false
var can_selected = true

func _ready():
	var cube_scale = cube.get_scale()
	set_translation(Vector3(mouse_pos_3d.x - (cube_scale.x * 2), cube_scale.y, mouse_pos_3d.y - (cube_scale.z * 2)))
	set_process(true)

func _process(delta):
	if can_selected == true:
		var cube_scale = cube.get_scale()
		mouse_pos_3d = map.center_tile_on_cursor
		set_translation(Vector3(mouse_pos_3d.x - (cube_scale.x * 2), cube_scale.y, mouse_pos_3d.y - (cube_scale.z * 2)))

func _on_Entity_input_event( camera, event, click_pos, click_normal, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON && event.is_action_pressed("left_click") && can_selected == true:
		can_selected = false
	elif event.type == InputEvent.MOUSE_BUTTON && event.is_action_pressed("left_click") && can_selected == false:
		is_selected = true
		can_selected = true
