
extends Camera

onready var root = get_tree().get_root()
export var cam_speed = 10
export var border = 50

var speed = 2.5

func _ready():
	set_process_input(true)
	set_process(true)

func _process(delta):
	checkMove()

func _input(event):
	if event.is_action_pressed("zoom"):
		translate(Vector3(0, 0, -1))
	if event.is_action_pressed("dezoom"):
		translate(Vector3(0, 0, 1))

func checkMove():
	var mouse_pos = root.get_mouse_pos()
	var window = OS.get_window_size()
	if mouse_pos.x >= window.x - border:
		move_x(-cam_speed)
	elif mouse_pos.x <= border:
		move_x(cam_speed)
	if mouse_pos.y >= window.y - border:
		move_y(-cam_speed)
	elif mouse_pos.y <= border:
		move_y(cam_speed)

func move_x(x):
	var delta = get_process_delta_time()
	var new_pos = get_translation() - Vector3(x,0,0) * speed * delta
	set_translation(new_pos)

func move_y(y):
	var delta = get_process_delta_time()
	var new_pos = get_translation() - Vector3(0,0,y) * speed * delta
	set_translation(new_pos)