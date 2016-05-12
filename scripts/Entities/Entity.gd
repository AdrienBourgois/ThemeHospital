
extends KinematicBody

onready var game = get_node("/root/Game")
onready var map = game.scene.map
onready var mouse_pos_3d = map.center_tile_on_cursor

var is_selected = false
var can_selected = true

func _ready():
	var cube_scale = get_node("TestCube").get_scale()
	set_translation(Vector3(mouse_pos_3d.x - cube_scale.x, cube_scale.y, mouse_pos_3d.y - cube_scale.z))
	set_process(true)

func _process(delta):
	var cube_scale = get_node("TestCube").get_scale()
	if can_selected == true:
		mouse_pos_3d = map.center_tile_on_cursor
		set_translation(Vector3(mouse_pos_3d.x - cube_scale.x, cube_scale.y, mouse_pos_3d.y - cube_scale.z))

func _on_Entity_input_event( camera, event, click_pos, click_normal, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON && event.is_action_pressed("left_click") && can_selected == true:
		can_selected = false
	elif event.type == InputEvent.MOUSE_BUTTON && event.is_action_pressed("left_click") && can_selected == false:
		is_selected = true
		can_selected = true
