
extends Viewport

export var camera_distance = 5
onready var node = null
onready var viewport_camera = get_node("Camera")

func _ready():
	pass

func _process(delta):
	viewport_camera.set_translation(node.get_translation() + Vector3(0,camera_distance,camera_distance))
