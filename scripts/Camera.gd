
extends Camera

onready var root = get_tree().get_root()
onready var game = get_node("/root/Game")
var map
export var border = 10
var inferior_limit = Vector3(0,5,0)
var superior_limit = Vector3(9,20,9)

var position
var rotation
var movement = Vector3(0,0,0)
export var speed = 2.5

func _ready():
	set_process_input(true)
	set_fixed_process(true)
	rotation = get_rotation()
	map = game.scene.get_node("Map")
	if map:
		inferior_limit += map.getPosition()
		superior_limit += map.getSize()

func _fixed_process(delta):
	if game.config.move_cam_with_mouse:
		checkMove()
	move()
	checkLimit()

func _input(event):
	if event.is_action_pressed("zoom"):
		translate(Vector3(0, -1, 0))
	if event.is_action_pressed("dezoom"):
		translate(Vector3(0, 1, 0))
	if event.is_action("ui_left"):
		movement.x += 3
	if event.is_action("ui_right"):
		movement.x -= 3
	if event.is_action("ui_up"):
		movement.z += 3
	if event.is_action("ui_down"):
		movement.z -= 3

func checkMove():
	var mouse_pos = root.get_mouse_pos()
	var window = OS.get_window_size()
	if mouse_pos.x >= window.x - border:
		movement.x -= 1
	elif mouse_pos.x <= border:
		movement.x += 1
	if mouse_pos.y >= window.y - border:
		movement.z -= 1
	elif mouse_pos.y <= border:
		movement.x += 1


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

func move():
	var delta = get_process_delta_time()
	var new_pos = get_translation() - movement * speed * delta
	set_translation(new_pos)
	movement = Vector3(0,0,0)