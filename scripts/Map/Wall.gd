
extends MeshInstance

var static_body = null
var room = null

func _ready():
	static_body = get_node("StaticBody")

func placeDoor(camera, event, click_pos, click_normal, shape_idx):
	if event.type == InputEvent.MOUSE_BUTTON && event.is_action_pressed("left_click"):
		room.placeDoor(self)
