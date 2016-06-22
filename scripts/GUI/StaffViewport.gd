
extends Viewport

export var camera_distance = 5
onready var node = null
onready var viewport_camera = get_node("Camera")
onready var root = get_node("/root")
export var base_rect = Rect2(Vector2(0,0), Vector2(120,120))
export var base_resolution = Vector2(1024,600)

func _ready():
	set_process(true)
	base_rect = get_rect()
	root.connect("size_changed",self,"resize")
	resize()

func _process(delta):
	viewport_camera.set_translation(node.get_translation() + Vector3(0,camera_distance,camera_distance))
	
func resize():
	var resolution = root.get_rect()
	var ratio = resolution.size/base_resolution
	set_rect(Rect2(get_rect().pos, base_rect.size*ratio))