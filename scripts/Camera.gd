
extends Camera

onready var root = get_tree().get_root()
onready var game = get_node("/root/Game")
var map
export var border = 10
var inferior_limit = Vector3(0,5,0)
var superior_limit = Vector3(9,20,9)
var rotation_limit = Vector3(0,45,45)
const size_min = 10
const size_max = 30

var position
var size = 20
var movement = Vector3(0,0,0)
var pause = false setget setPause,getPause
export var speed = 10


func _ready():
	set_process_input(true)
	set_fixed_process(true)
	map = game.scene.get_node("Map")
	if map:
		inferior_limit += map.getPosition()
		superior_limit += map.getSize()
	set_orthogonal(size, 0.1, 100)


func _fixed_process(delta):
	if !pause:
		if game.config.move_cam_with_mouse:
			checkMouseMove()
		checkInputMove()
		move()


func _input(event):
	if !pause:
		if event.is_action_pressed("zoom"):
			size -= 5
			set_orthogonal(size, 0.1, 100)
		if event.is_action_pressed("dezoom"):
			size += 5
			set_orthogonal(size, 0.1, 100)
		checkLimit()


func checkInputMove():
	if Input.is_action_pressed("ui_left"):
		movement.x += 1
		movement.z -= 1
	if Input.is_action_pressed("ui_right"):
		movement.x -= 1
		movement.z += 1
	if Input.is_action_pressed("ui_up"):
		movement.x += 1
		movement.z += 1
	if Input.is_action_pressed("ui_down"):
		movement.x -= 1
		movement.z -= 1


func checkMouseMove():
	var mouse_pos = root.get_mouse_pos()
	var window = OS.get_window_size()
	if mouse_pos.x >= window.x - border:
		movement.x -= 1
		movement.z += 1
	elif mouse_pos.x <= border:
		movement.x += 1
		movement.z -= 1
	if mouse_pos.y >= window.y - border:
		movement.x -= 1
		movement.z -= 1
	elif mouse_pos.y <= border:
		movement.x += 1
		movement.z += 1


func checkLimit():
	position = get_translation()
	checkXLimit()
	checkYLimit()
	checkZLimit()
	checkSize()
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

func checkSize():
	if size > size_max:
		size = size_max
	elif size < size_min:
		size = size_min

func move():
	var delta = get_process_delta_time()
	var new_pos = get_translation() - movement * speed * delta
	set_translation(new_pos)
	movement = Vector3(0,0,0)

func setPause(state):
	pause = state

func getPause():
	return pause