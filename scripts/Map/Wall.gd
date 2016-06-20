
extends Quad

var static_body = null
var room = null

func _ready():
	static_body = get_node("StaticBody")

func place_door(camera, event, click_pos, click_normal, shape_idx):
	if event.type == InputEvent.MOUSE_BUTTON && event.is_action_pressed("left_click"):
		room.place_door(self)
