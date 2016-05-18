
extends Camera

onready var root = get_tree().get_root()
onready var game = get_node("/root/Game")
export var border = 10
export var inferior_limit = Vector3(9, 7, 20)
export var superior_limit = Vector3(30, 20, 47)

var position
export var speed = 2.5

func _ready():
	set_process_input(true)
	set_fixed_process(true)

func _fixed_process(delta):
	if game.config.move_cam_with_mouse:
		checkMove()
	checkLimit()

func _input(event):
	if event.is_action_pressed("zoom"):
		translate(Vector3(0, -1, -1))
	if event.is_action_pressed("dezoom"):
		translate(Vector3(0, 1, 1))
	if event.is_action("ui_left"):
		move_x(2)
	if event.is_action("ui_right"):
		move_x(-2)
	if event.is_action("ui_up"):
		move_y(2)
	if event.is_action("ui_down"):
		move_y(-2)

func checkMove():
	var mouse_pos = root.get_mouse_pos()
	var window = OS.get_window_size()
	if mouse_pos.x >= window.x - border:
		move_x(-1)
	elif mouse_pos.x <= border:
		move_x(1)
	if mouse_pos.y >= window.y - border:
		move_y(-1)
	elif mouse_pos.y <= border:
		move_y(1)

func checkLimit():
	position = get_translation()
	checkXLimit()
	checkYLimit()
	checkZLimit()
	set_translation(position)

func checkXLimit():
	if position.x < inferior_limit.x:
		position.x = inferior_limit.x
	elif position.x > superior_limit.x:
		position.x = superior_limit.x

func checkYLimit():
	if position.y < inferior_limit.y:
		position.y = inferior_limit.y
	elif position.y > superior_limit.y:
		position.y = superior_limit.y

func checkZLimit():
	if position.z < inferior_limit.z:
		position.z = inferior_limit.z
	elif position.z > superior_limit.z:
		position.z = superior_limit.z

func move_x(x):
	var delta = get_process_delta_time()
	var new_pos = get_translation() - Vector3(x,0,0) * speed * delta
	set_translation(new_pos)

func move_y(y):
	var delta = get_process_delta_time()
	var new_pos = get_translation() - Vector3(0,0,y) * speed * delta
	set_translation(new_pos)