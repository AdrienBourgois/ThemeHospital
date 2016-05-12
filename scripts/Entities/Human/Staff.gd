
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
var can_selected = true

func _ready():
	set_translation(mouse_pos_3d)
	set_process(true)

func _process(delta):
	mouse_pos_3d = map.mouse_pos
	if can_selected == true:
		set_translation(mouse_pos_3d)
	

func _on_Staff_input_event( camera, event, click_pos, click_normal, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON && event.is_action_pressed("left_click") && can_selected == true:
		can_selected = false
	elif event.type == InputEvent.MOUSE_BUTTON && event.is_action_pressed("left_click") && can_selected == false:
		is_selected = true
		can_selected = true
	