
extends Control

var loader
var status
var update_ready = true
onready var root = get_tree().get_root()
onready var progress_bar = get_node("Panel/ProgressBar")

export var waiting_frame = 10

var current_scene setget setCurrentScene

var load_percent = 0.0

func _ready():
	goToScene("res://scenes/gamescn.scn")

func _process(delta):
	if waiting_frame > 0:
		waiting_frame -= 1
		return

	load_resources()

func load_resources():
	if update_ready:
		status = loader.poll()
	
	if status == ERR_FILE_EOF:
		set_scene(loader.get_resource())
		set_process(false)
	elif status == OK:
		update()
	else:
		set_process(false)

func update():
	var current = float(loader.get_stage())
	var total = loader.get_stage_count()
	var progress = (current/total)*100
	
	
	if load_percent < progress:
		update_ready = false
		load_percent += progress/10
		progress_bar.set_value(progress)
	else:
		update_ready = true

func goToScene(scene_path):
	loader = ResourceLoader.load_interactive(scene_path)
	
	if loader != null:
		set_process(true)
		if current_scene != null:
			current_scene.queue_free()

func set_scene(scene):
	var new_scene = scene.instance()
	root.add_child(new_scene)
	
	queue_free()

func setCurrentScene(scene):
	current_scene = scene