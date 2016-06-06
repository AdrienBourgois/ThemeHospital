
extends KinematicBody

onready var game = get_node("/root/Game")
onready var gamescn = game.scene
onready var map = game.scene.map
onready var mouse_pos_3d = map.center_tile_on_cursor
onready var cube = get_node("TestCube")

onready var stats = {}

var cube_scale

export var position = Vector3(0,0,0) setget setPosition, getPosition 
export var rotation = 0

var is_selected = false
var can_selected = true

func put():
	pass

func take():
	pass

func _ready():
	connect("input_event", self, "_on_Entity_input_event")
	cube_scale = cube.get_scale()
	set_translation(Vector3(mouse_pos_3d.x - cube_scale.x, cube_scale.y, mouse_pos_3d.y - cube_scale.z))
	set_process(true)
	set_process_input(true)

func createStatsDict():
	stats = {
	POSITION_X = position.x,
	POSITION_Y = position.y,
	POSITION_Z = position.z
	}
	return stats

func rotate():
	self.rotate_y(deg2rad(90))

func _process(delta):
	var cube_scale = cube.get_scale()
	if can_selected == true:
		var cube_scale = cube.get_scale()
		mouse_pos_3d = map.center_tile_on_cursor
		set_translation(Vector3(mouse_pos_3d.x - cube_scale.x, cube_scale.y, mouse_pos_3d.y - cube_scale.z))
		set_process_input(true)

func _on_Entity_input_event( camera, event, click_pos, click_normal, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON && event.is_action_pressed("left_click") && can_selected == true:
		can_selected = false
		set_process_input(false)
		position.x = self.get_translation().x
		position.y = self.get_translation().y
		put()
	elif event.type == InputEvent.MOUSE_BUTTON && event.is_action_released("right_click") && can_selected == false:
		is_selected = true
		can_selected = true
		take()
		set_process_input(true)

func _input(event):
	if (event.is_action_released("right_click")):
		rotate()

func setPosition(value):
	position = value

func getPosition():
	return position